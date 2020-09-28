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
