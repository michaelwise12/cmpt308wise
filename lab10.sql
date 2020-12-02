------------------------------------------------------------------------------------------------------
-- Author: Michael Wise
--
-- Date: 3 December 2020
--
-- Class: CMPT308 Database Management
--
-- Professor: Dr. Alan Labouseur
-- 
-- Lab #10: Stored Procedures
------------------------------------------------------------------------------------------------------

-- Question #1: Write a function PreReqsFor(courseNum) - Returns the immediate
-- prerequisites for the passed-in course number. --

create or replace function PreReqsFor(int, REFCURSOR) returns refcursor as 
$$
declare
   courseNumber int    := $1;
   resultset REFCURSOR := $2;
begin
   open resultset for 
      select *
      from Courses
      where num in (select preReqNum -- query Prereq table for prereqs w/ specified course number
                    from Prerequisites
                    where courseNum = courseNumber);
   return resultset;
end;
$$ 
language plpgsql;

select PreReqsFor(308, 'results');
fetch all from results;