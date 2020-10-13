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
select city
from Products
group by city
order by count(*) DESC
limit 2;

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