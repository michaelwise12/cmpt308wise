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
select orderNum, totalUsd
from Orders;

-- Question 2: List the last name and home city of people whose prefix is "Dr.". --
select lastName, homeCity
from People
where prefix = 'Dr.';



