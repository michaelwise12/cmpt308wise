------------------------------------------------------------------------------------------------------
-- Author: Michael Wise
--
-- Date: 1 October 2020
--
-- Class: CMPT308 Database Management
--
-- Professor: Dr. Alan Labouseur
-- 
-- Lab #5: SQL Queries - The Joins Three-quel
------------------------------------------------------------------------------------------------------

-- Question #1: Show all the People data (and only people data) for people who are customers.
-- Use joins this time; no subqueries. --
select p.*
from People p, Customers c
where p.pid = c.pid;

-- Question #2: Show all the People data (and only people data) for people who are agents.
-- Use joins this time; no subqueries. --
select p.*
from People p, Agents a
where p.pid = a.pid;

-- Question #3: Show all People and Agent data for people who are both customers and agents.
-- Use joins this time; no subqueries. --
select p.*, a.*
from People p, Customers c, Agents a
where p.pid = c.pid
  and c.pid = a.pid;

-- Question #4: Show the first name of customers who have never placed an order. Use subqueries. --
select firstName
from People
where pid in (select pid
              from Customers
              where pid not in (select custId
                                from Orders
                               )
             );

-- Question #5: Show the first name of customers who have never placed an order. Use one inner and
-- one outer join. --
select firstName
from People p inner join Customers c   on p.pid = c.pid
              left outer join Orders o on c.pid = o.custId
where o.custId is null;

-- Question #6: Show the id and commission percent of Agents who booked an order for the customer
-- whose id is 008, sorted by commission percent from low to high. Use joins; no subqueries. --
select distinct pid, commissionPct
from Agents a inner join Orders o on a.pid = o.agentId
where custId = 008
order by commissionPct ASC;

-- Question #7: Show the last name, city, and commission percent of Agents who booked an order for
-- the customer whose id is 001, sorted by commission percent from high to low. Use joins. --
select distinct p.lastName, p.homeCity, a.commissionPct
from People p inner join Agents a on p.pid = a.pid
              inner join Orders o on a.pid = o.agentId
where custId = 001
order by commissionPct DESC;

-- Question #8: Show the last name and home city of customers who live in the city that makes the
-- fewest different kinds of products. (Hint: use count and group by on the Products table. You
-- may need limit as well.) --
select p.lastName, p.homeCity
from People p inner join Customers c on p.pid = c.pid
where p.homeCity in (select city
                     from Products
                     group by city
                     order by count(*) -- list cities in order from fewest to most amount of products
                     limit 1 -- limits search to first row, just made to be city with fewest products
                    );

-- Question #9: Show the name and id of all Products ordered through any Agent who booked at least
-- one order for a Customer in Chicago, sorted by product name from A to Z. You can use joins or subqueries. --
select name, prodId
from Products
where prodId in (select prodId
                 from Orders
                 where agentId in (select agentId
                                   from Orders 
                                   where custId in (select pid
                                                    from Customers
                                                    where pid in (select pid
                                                                  from People
                                                                  where homeCity = 'Chicago'
                                                                 )
                                                   )
                                  )
                )
order by name ASC;

-- Question #10: Show the first name and last name of customers and agents living in the same
-- city, along with the name of their shared city. (Living in a city with yourself does not
-- count, so exclude those from your results.) --

select firstName, lastName, homeCity
from People
where homeCity in (select homeCity
                   from People p inner join Customers c on p.pid = c.pid)
  and homeCity in (select homeCity
                   from People p inner join Agents a on p.pid = a.pid)
  and pid not in (select a.pid -- this query removes people who are both customers and agents
                  from Agents a inner join Customers c on a.pid = c.pid);
