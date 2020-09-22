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

-- Question #3: Get all of People data for people who are both customers and agents. --
select *
from People
where pid in (select pid
			 from Customers
			 where pid in (select pid
						   from Agents)
			 );
			 
-- Question #4: Get all of People data who are neither customers nor agents. --
select *
from People
where pid not in (select pid
				  from Customers
				 )
	and pid not in (select pid 
					from Agents
				   );

-- Question #5: Get the ID of customers who ordered either product 'p01' or 'p07' (or both). --
select distinct custId
from Orders
where prodId in ('p01', 'p07');
			 
-- Question #6: Get the ID of customers who ordered both products 'p01' and 'p07'. List 
-- the IDs in order from lowest to highest. Include each ID only once. --
select distinct custId
from Orders
where prodId = 'p01'
	and custId in (select custId
				   from Orders
				   where prodId = 'p07'
				  )
order by custId ASC;
			 


