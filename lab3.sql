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

-- Question 5: List the prefix and last name of people who are not "Mr.". --
select prefix, lastName
from People
where prefix != 'Mr.';

-- Question 6: List all fields for products in neither Dallas nor Duluth that cost $3 or more. --
select *
from Products
where (city != 'Dallas'
   and city != 'Duluth'
	  )
	and priceUSD >= 3.00;

-- Question 7: List all fields for orders in March. --
select *
from Orders
where dateOrdered >= '2020-03-01'
  and dateOrdered <  '2020-04-01';

-- Question 8: List all fields for orders in February of $20,000 or more. --
select *
from Orders
where (dateOrdered >= '2020-02-01'
   and dateOrdered <  '2020-03-01'
	  )
	and totalUSD >= 20000.00;



