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

-- Hotels -- (players & staff stayed in a selection of hotels on the Disney campus)
CREATE TABLE Hotels (
   hotelID       int not null,
   hotelName     text,
   streetAddress text,
 primary key(hotelID)
);

-- Rooms -- (how people are assigned to what hotel and what room number)
CREATE TABLE Rooms (
   pid        int not null references People(pid),
   hotelID    int not null references Hotels(hotelID),
   roomNumber text,
 primary key(pid)
);

-- Teams --
CREATE TABLE Teams (
   teamID   int  not null,
   location text not null,
   name     text not null,
   wins     int,
   losses   int,
 primary key(teamID)
);

-- PlaysFor -- (associative entity - many Players play/have played for many Teams)
CREATE TABLE PlaysFor (
   pid            int not null references Players(pid),
   teamID         int not null references Teams(teamID),
   contract_start date,
   contract_end   date,
 primary key(pid, teamID)
);

-- StaffType -- (i.e. Coaching staff, training staff, etc.)
CREATE TABLE StaffType (
   staffID int  not null,
   name    text not null,
 primary key (staffID)
);

-- TeamStaff -- (each staff member is associated with a team, i.e. coaches & trainers)
CREATE TABLE TeamStaff (
   pid     int not null references People(pid),
   staffID int not null references StaffType(staffID),
   teamID  int not null references Teams(teamID),
 primary key(pid)
);