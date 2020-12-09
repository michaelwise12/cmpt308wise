------------------------------------------------------------------------------------------------------
-- Author: Michael Wise
--
-- Date: 10 December 2020
--
-- Class: CMPT308 Database Management
--
-- Professor: Dr. Alan Labouseur
-- 
-- Design Project: The NBA Bubble
------------------------------------------------------------------------------------------------------

-- CREATE STATEMENTS --

-- People --
CREATE TABLE People (
   pid              int  not null,
   firstName        text not null,
   lastName         text not null,
   suffix           text,
   dateOfBirth      date not null,
   phoneNumber      text,
 primary key(pid)
);

-- Players --
CREATE TABLE Players (
   pid               int  not null references People(pid),
   primaryPosition   text not null,
   secondaryPosition text,
   heightInches      int,
   weightPounds      int,
   shootingHand      text not null check (shootingHand in ('left', 'right', 'both')),
 primary key(pid)
);

-- COVIDTesting --
CREATE TABLE COVIDTesting (
   pid            int  not null references People(pid),
   lastResultDate date not null,
   lastTestResult text not null check (lastTestResult = 'postive' or lastTestResult = 'negative'),
 primary key(pid, lastResultDate)
);

-- JobInfo -- (Specifically for employees that work on the Orlando campus)
CREATE TABLE JobInfo (
   jobID       int  not null,
   name        text not null,
   description text,
 primary key(jobID)
);

-- BubbleEmployees -- (Not including team staff, this is only for the Disney staff)
CREATE TABLE BubbleEmployees (
   pid          int not null references People(pid),
   jobID        int not null references JobInfo(jobID),
   hourlyWage   money,
 primary key(pid)
);