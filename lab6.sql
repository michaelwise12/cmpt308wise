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
limit 3;

-- Question #2: Display the names of products whose priceUSD is at or above the average
-- priceUSD, in reverse-alphabetical order. --
select *
from Products
where priceUSD >= (select avg(priceUSD)
                   from Products
                  )
order by name DESC; -- In this snapshot, a brilliant Red Barchetta significantly affects the average.