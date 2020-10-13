------------------------------------------------------------------------------------------------------
-- Author: Michael Wise
--
-- Date: 15 October 2020
--
-- Class: CMPT308 Database Management
--
-- Professor: Dr. Alan Labouseur
-- 
-- Lab #6: Interesting and Painful SQL Queries
------------------------------------------------------------------------------------------------------

-- Question #1: Display the cities that make the most different kinds of products. --
select city, count(*)
from Products
group by city
having count(city) > 2;


-- Question #2: Display the names of products whose priceUSD is at or above the average
-- priceUSD, in reverse-alphabetical order. --
select name
from Products
where priceUSD >= (select avg(priceUSD)
                   from Products
                  )
order by name DESC; -- In this snapshot, a brilliant Red Barchetta significantly affects the average.

-- Question #3: Display the customer last name, product id ordered, and the totalUSD for all
-- orders made in March, sorted by totalUSD from high to low. --
select p.lastName, o.prodId, o.totalUSD
from People p inner join Customers c on p.pid = c.pid
              inner join Orders o    on c.pid = o.custId
where extract(month from o.dateOrdered) = 3
order by totalUSD DESC;

-- Question #4: Display the last name of all customers (in reverse alphabetical order) and their
-- total ordered, and nothing more. (Hint: use coalesce to avoid showing NULLs.) --
select p.lastName, coalesce(sum(o.totalUSD), 0)
from People p inner join      Customers c on p.pid = c.pid
              left outer join Orders o    on c.pid = o.custId
group by p.lastName
order by p.lastName DESC;

-- Question #5: Display the names of all customers who bought products from agents based in Teaneck
-- along with the names of the products they ordered, and the names of the agents who sold it to them. --
select p.firstName, p.lastName, pr.name as "productName", p2.firstName, p2.lastName
from People p inner join Customers c on p.pid = c.pid
              inner join Orders o    on c.pid = o.custId
              inner join Agents a    on o.agentId = a.pid
              inner join Products pr on o.prodId = pr.prodId
              inner join People p2   on a.pid = p2.pid -- inner join another People table to get agent data
where p2.homeCity = 'Teaneck';

-- Question #6: Write a query to check the accuracy of the totalUSD column in the Orders table. This
-- means calculating Orders.totalUSD from data in other tables and comparing those values to the values
-- in Orders.totalUSD. Display all rows in Orders where Orders.totalUSD is incorrect, if any. If there
-- are any incorrect values, explain why they are wrong. --
select o.*, round((o.quantityOrdered * pr.priceUSD) * (1 - (c.discountPct/100)), 4) as "Actual totalUSD"
from Orders o inner join Products pr on o.prodId = pr.prodId
              inner join Customers c on o.custId = c.pid -- we need the customers table to get discount percent
where o.totalUSD != (o.quantityOrdered * pr.priceUSD) * (1 - (c.discountPct/100)); -- total = quantity * price * (1 - discount %)

/* These values appear as "incorrect" because of how SQL calculates decimals. In the Orders table,
 * the totalUSD is a numeric rounded to 2 decimal places to account for the fact that US currency
 * cannot be split further than 1 cent. However, when the total is multiplied by each customer's
 * discount percent, some calculated totals have more than 2 decimal places. Thus, SQL reads '74871.83'
 * and '74871.8304' as different values, making them technically 'incorrect' due to the 2-decimal place
 * nature of currency. The only order that is truly incorrect is order number 1017, in which the totalUSD
 * should have been rounded up to $25643.89 instead of $25643.88. I appended an "actual totalUSD" column
 * to show the correct, unrounded calculation.
 */

-- Question #7: Display the first and last name of customers who are also agents. --
select p.firstName, p.lastName
from People p inner join Customers c on p.pid = c.pid
              inner join Agents a    on c.pid = a.pid; -- finds people who are both customers and agents

-- Question #8: Create a VIEW of all Customer and People data called PeopleCustomers. Then another VIEW
-- of all Agent and People data called PeopleAgents. Then "select *" from each of them in turn to test. --
create view PeopleCustomers
as
select *
from People
where pid in (select pid
              from Customers);

create view PeopleAgents
as
select *
from People
where pid in (select pid
              from Agents);
-- Select statements:
select *
from PeopleCustomers;

select *
from PeopleAgents;
