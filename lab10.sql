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
   courseNumber int    := $1; -- I named the variable 'courseNumber' to avoid ambiguity
   resultset REFCURSOR := $2;
begin
   open resultset for 
      select *
      from Courses
      where num in (select preReqNum -- query Prereq table for prereqs of specified course number
                    from Prerequisites
                    where courseNum = courseNumber);
   return resultset;
end;
$$ 
language plpgsql;

select PreReqsFor(308, 'results');
fetch all from results;

-- Question #2: Write a function IsPreReqFor(courseNumber) - Returns the courses for
-- which the passed-in course number is an immediate prerequisite. --

create or replace function IsPreReqFor(int, REFCURSOR) returns refcursor as 
$$
declare
   courseNumber int    := $1;
   resultset REFCURSOR := $2;
begin
   open resultset for 
      select *
      from Courses
      where num in (select courseNum -- query Prereq table for courses that ARE a prereq for a course
                    from Prerequisites
                    where preReqNum = courseNumber);
   return resultset;
end;
$$ 
language plpgsql;