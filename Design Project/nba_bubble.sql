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
   lastTestResult text not null check (lastTestResult = 'positive' or lastTestResult = 'negative'),
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

-- Practice -- (dealing with teams' daily practice times)
CREATE TABLE Practice (
   teamID            int not null references Teams(teamID),
   courtNumber       int,
   dailyPracticeTime time,
 primary key(teamID)
);

-- Venues -- (games are played in 3 different venues in ESPN Wide World of Sports Complex)
CREATE TABLE Venues (
   venueID       int  not null,
   name          text,
   streetAddress text,
 primary key(venueID)
);

-- Games --
CREATE TABLE Games (
   gameID    int not null,
   venueID   int not null references Venues(venueID),
   matchDate date,
   matchTime time,
 primary key(gameID)
);

-- Matchmaking -- (entity that tells what teams are playing what games)
CREATE TABLE Matchmaking (
   gameID     int not null references Games(gameID),
   homeTeamID int not null references Teams(teamID),
   awayTeamID int not null references Teams(teamID),
 primary key(gameID)
);

-- INSERT STATEMENTS --

-- People --
INSERT INTO People (pid, firstName, lastName, suffix, dateOfBirth, phoneNumber)
VALUES
 (001, 'Lebron',  'James',         NULL,  '1984-12-30', '555-023-0824'),
 (002, 'Giannis', 'Antetokounmpo', NULL,  '1994-12-06', '555-123-4567'),
 (003, 'Kawhi',   'Leonard',       NULL,  '1991-06-29', NULL),
 (004, 'Anthony', 'Davis',         NULL,  '1993-03-11', '800-111-2323'),
 (005, 'John',    'Smith',         'Sr.', '1964-11-06', '321-100-2020'),
 (006, 'James',   'Harden',        'Jr.', '1989-08-26', NULL),
 (007, 'Damian',  'Lillard',       NULL,  '1990-07-15', '123-000-0000'),
 (008, 'Joel',    'Embiid',        NULL,  '1994-03-16', NULL),
 (009, 'Kemba',   'Walker',        NULL,  '1990-05-08', '555-150-0815'),
 (010, 'Frank',   'Vogel',         NULL,  '1973-06-21', '800-987-6543'),
 (011, 'Jimmy',   'Butler',        'III', '1989-09-14', '555-222-2222'),
 (012, 'Nick',    'Nurse',         NULL,  '1967-07-24', '123-426-3333'),
 (013, 'Thomas',  'Thomas',        'IX',  '1958-01-11', '666-666-1337'),
 (014, 'Alan',    'Labouseur',     NULL,  '1970-01-01', '845-440-1102')
;

-- Players --
INSERT INTO Players (pid, primaryPosition, secondaryPosition, heightInches, weightPounds, shootingHand)
VALUES
 (001, 'SF', 'PG', 81, 250, 'both'),
 (002, 'PF', 'C',  83, 242, 'right'),
 (003, 'SF', NULL, 79, 225, 'right'),
 (004, 'C', 'PF',  82, 253, 'right'),
 (006, 'SG','PG',  77, 220, 'left'),
 (007, 'PG', NULL, 74, 195, 'right'),
 (008, 'C',  NULL, 84, 280, 'right'),
 (009, 'PG', NULL, 72, 184, 'right'),
 (011, 'SF', 'SG', 79, 230, 'right'),
 (014, 'SG', 'C',  98, 360, 'both')
;

-- COVIDTesting --
INSERT INTO COVIDTesting (pid, lastResultDate, lastTestResult)
VALUES
 (001, '2020-10-07', 'negative'),
 (002, '2020-09-12', 'negative'),
 (003, '2020-09-17', 'negative'),
 (004, '2020-10-07', 'negative'),
 (005, '2020-10-05', 'positive'),
 (006, '2020-09-25', 'negative'),
 (007, '2020-09-03', 'negative'),
 (008, '2020-09-05', 'negative'),
 (009, '2020-09-28', 'negative'),
 (010, '2020-10-07', 'negative'),
 (011, '2020-10-06', 'negative'),
 (012, '2020-09-15', 'negative'),
 (013, '2020-10-01', 'positive'),
 (014, '2020-10-04', 'negative')
;

-- JobInfo --
INSERT INTO JobInfo (jobID, name, description)
VALUES
 (01, 'Front Desk', 'Serves players and staff at the front desk.'),
 (02, 'Janitor', 'Cleans the public areas of the resorts.'),
 (03, 'Hotel Manager', 'The manager of a hotel.'),
 (04, 'Maid', 'Cleans rooms of players, coaches, and other staff.'),
 (05, 'Food Service', 'Provides and prepares food for teams.')
;

-- BubbleEmployees --
INSERT INTO BubbleEmployees (pid, jobID, hourlyWage)
VALUES
 (005, 02, 11.30),
 (013, 01, 17.50)
;

-- Hotels --
INSERT INTO Hotels (hotelID, hotelName, streetAddress)
VALUES
 (01, 'Grand Floridian',                        '4401 Floridian Way'),
 (02, 'Gran Destino Tower at Coronado Springs', '1000 Buena Vista Dr'),
 (03, 'Disneys Yacht Club Resort',              '1700 Epcot Resorts Blvd')
;

-- Rooms --
INSERT INTO Rooms (pid, hotelID, roomNumber)
VALUES
 (001, 02, '5004'),
 (002, 02, '3016'),
 (003, 02, '4120'),
 (004, 02, '5012'),
 (006, 01, '4428'),
 (007, 03, '1238'),
 (008, 02, '4014'),
 (009, 02, '1238'),
 (010, 02, '5008'),
 (011, 02, '3042'),
 (012, 02, '5764'),
 (014, 01, '1622')
;

select * from People
select * from Rooms