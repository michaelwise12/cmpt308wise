------------------------------------------------------------------------------------------------------
-- Author: Michael Wise
--
-- Date: 24 September 2020
--
-- Class: CMPT308 Database Management
--
-- Professor: Dr. Alan Labouseur
-- 
-- Lab #4: The Subqueries Sequel
------------------------------------------------------------------------------------------------------

-- Question #1: Get all the People data for people who are customers. --
select *
from People
where pid in (select pid
			  from Customers
			 );

-- Question #2: Get all the People data for people who are agents. --
select *
from People
where pid in (select pid
			  from Agents
			 );


