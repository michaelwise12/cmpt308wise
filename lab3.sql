------------------------------------------------------------------------------------------------------
-- Author: Michael Wise
--
-- Date: 17 September 2020
--
-- Class: CMPT308 Database Management
--
-- Professor: Dr. Alan Labouseur
-- 
-- Lab #3: Getting Started with SQL Queries
------------------------------------------------------------------------------------------------------

-- Question 1: List the order number and total dollars of all orders. --
select orderNum, totalUSD
from Orders;

-- Question 2: List the last name and home city of people whose prefix is "Dr.". --
select lastName, homeCity
from People
where prefix = 'Dr.';

-- Question 3: List id, name, and price of products with quantity more than 1007. --
select prodId, name, priceUSD
from Products
where qtyOnHand > 1007;

-- Question 4: List the first name and home city of people born in the 1950s. --
select firstName, homeCity
from People
where DOB >= '1950-01-01'
  and DOB <  '1960-01-01';


