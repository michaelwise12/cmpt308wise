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
-- the IDs in order from highest to lowest. Include each ID only once. --
select distinct custId
from Orders
where prodId = 'p01'
	and custId in (select custId
				   from Orders
				   where prodId = 'p07'
				  )
order by custId DESC;
			 
-- Question #7: Get the first and last names of agents who sold products 'p05' or 'p07'
-- in order by last name from Z to A. --
select firstName, lastName
from People
where pid in (select pid
			  from Agents
			  where pid in (select distinct agentId
						    from Orders
						    where prodId in ('p05', 'p07')
						   )
			 )
order by lastName DESC;

-- Question #8: Get the home city and birthday of agents booking an order for the customer
-- whose pid is 001, sorted by home city from A to Z. --
select homeCity, DOB
from People
where pid in (select pid
			  from Agents
			  where pid in (select distinct agentId
							from Orders
						    where custId = 001
						   )
			 )
order by homeCity ASC;

-- Question #9: Get the unique ids of products ordered through any agent who takes at least one
-- order from a customer in Toronto, sorted by id from highest to lowest. (This is not the same
-- as asking for ids of products ordered by customers in Toronto.) --

select distinct prodId
from Orders
where agentId in (select distinct agentId -- in this snapshot, the applicable agents have ids 2 & 3
				  from Orders
				  where custId in (select pid
				 				   from People
				 				   where homeCity = 'Toronto')
				 )
order by prodId DESC;

-- Question #10: Get the last name and the home city for all customers who place orders
-- through agents in Teaneck or Santa Monica. --
select lastName, homeCity
from People
where pid in (select distinct custId -- in this snapshot, customers 4 & 8 place orders through 5
			  from Orders
			  where agentId in (select pid   -- in this snapshot, they are agents with id 5 & 6
								from Agents
								where pid in (select pid
											  from People
											  where homeCity in ('Teaneck', 'Santa Monica')
											 )
							   )
			 );
