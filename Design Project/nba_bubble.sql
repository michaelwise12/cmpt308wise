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
-----------------------

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
select * from matchmaking
-- INSERT STATEMENTS --
-----------------------

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

-- Teams --
INSERT INTO Teams (teamID, location, name, wins, losses)
VALUES
 (01, 'Los Angeles',  'Lakers',         52, 19),
 (02, 'Milwaukee',    'Bucks',          56, 17),
 (03, 'Toronto',      'Raptors',        53, 19),
 (04, 'Los Angeles',  'Clippers',       49, 23),
 (05, 'Houston',      'Rockets',        44, 28),
 (06, 'Philadelphia', '76ers',          43, 30),
 (07, 'Portland',     'Trail Blazers',  35, 39),
 (08, 'Boston',       'Celtics',        48, 24),
 (09, 'Miami',        'Heat',           44, 29)
;

-- PlaysFor --
INSERT INTO PlaysFor (pid, teamID, contract_start, contract_end)
VALUES
 (001, 01, '07-09-2018', '07-09-2022'),
 (002, 02, '09-20-2016', '09-20-2021'),
 (003, 04, '07-09-2018', '07-09-2022'),
 (004, 01, '07-06-2019', '12-03-2025'),
 (006, 05, '07-08-2017', '07-08-2023'),
 (007, 07, '07-06-2019', '07-06-2025'),
 (008, 06, '10-10-2017', '10-10-2023'),
 (009, 08, '07-06-2019', '07-06-2023'),
 (011, 09, '07-06-2019', '07-06-2023'),
 (014, 03, '07-09-2018', '07-09-2112')
;

-- StaffType --
INSERT INTO StaffType (staffID, name)
VALUES
 (01, 'Head Coach'),
 (02, 'Assistant Coach'),
 (03, 'General Manager'),
 (04, 'Athletic Trainer')
;

-- TeamStaff --
INSERT INTO TeamStaff (pid, staffID, teamID)
VALUES
 (010, 01, 01),
 (012, 01, 03)
;

-- Practice --
INSERT INTO Practice (teamID, courtNumber, dailyPracticeTime)
VALUES
 (01, 1, '7:30 AM'),
 (02, 2, '8:00 AM'),
 (03, 3, '8:30 AM'),
 (04, 4, '9:00 AM'),
 (05, 1, '9:30 AM'),
 (06, 2, '10:00 AM'),
 (07, 3, '10:30 AM'),
 (08, 4, '11:00 AM'),
 (09, 1, '11:30 AM')
;

-- Venues --
INSERT INTO Venues (venueID, name, streetAddress)
VALUES
 (01, 'HP Field House',       '701 S Victory Way'),
 (02, 'Visa Athletic Center', '702 S Victory Way'),
 (03, 'AdventHealth Arena',   '700 S Victory Way')
;
-- Games --
INSERT INTO Games (gameID, venueID, matchDate, matchTime)
VALUES
 (001, 03, '08-21-2020', '5:00 PM'),
 (002, 02, '08-21-2020', '9:00 PM'),
 (003, 01, '08-23-2020', '1:00 PM'),
 (004, 01, '08-28-2020', '6:30 PM'),
 (005, 03, '08-28-2020', '10:30 PM'),
 (006, 01, '09-06-2020', '3:00 PM'),
 (007, 02, '09-12-2020', '1:00 PM')  -- I could keep adding more but the point is clear.
;

-- Matchmaking --
INSERT INTO Matchmaking (gameID, homeTeamID, awayTeamID)
VALUES
 (001, 01, 04),
 (002, 02, 03),
 (003, 05, 07),
 (004, 08, 09),
 (005, 06, 02),
 (006, 04, 05),
 (007, 09, 01)
;

-- VIEWS --
-----------
-- PlayerInfo -- Convinient way to view every stat pertaining to a player (including team & contract data)
create view PlayerInfo
as
select p.*, pl.primaryPosition, pl.secondaryPosition, pl.heightInches, pl.weightPounds, pl.shootingHand,
            f.contract_start, f.contract_end, t.location as teamCity, t.name as teamName
from People p inner join Players pl on p.pid = pl.pid
              inner join PlaysFor f on pl.pid = f.pid
              inner join Teams t    on f.teamID = t.teamID;
			  
select * from PlayerInfo;

-- PowerRankings -- Evaluates the win percentage of each team and then ranks them from best record to worst
create view PowerRankings
as
select *, cast((wins * 1.0 /(wins + losses)) as decimal(4,3)) as winPercentage
from Teams
order by winPercentage DESC;

select * from PowerRankings;


-- REPORTS --
-------------
-- Total number of players that have expiring contracts within the next 2 offseasons (up to summer 2022).
select count(pid)
from PlaysFor
where contract_end < '2022-08-01';

-- Reports the total number of players/staff who have tested positive for COVID-19.
select count(pid)
from COVIDTesting
where lastTestResult = 'positive';

-- STORED PROCEDURES --
-----------------------

-- showSchedule --
-- Function that shows all the upcoming games (with match info) for a specified team. --
create or replace function showSchedule(text, REFCURSOR) returns refcursor as 
$$
declare
   teamName  text      := $1;
   resultset REFCURSOR := $2;
begin
   open resultset for 
      select m.gameID, t.name as homeTeam, t2.name as awayTeam, g.matchDate, g.matchTime, v.name as Venue, v.streetAddress
      from Matchmaking m inner join Games g  on m.gameID   = g.gameID
	                     inner join Venues v on g.venueID  = v.venueID
						 inner join Teams t  on t.teamID   = m.homeTeamID
						 inner join Teams t2 on t2.teamID  = m.awayTeamID
      where t.name = teamName or t2.name = teamName;
   return resultset;
end;
$$ 
language plpgsql;

select showSchedule('Clippers', 'results');
fetch all from results;

-- hotelSearch --
-- Returns list of all the players staying in a specified hotel, with their room/contact info.
create or replace function hotelSearch(text, REFCURSOR) returns refcursor as 
$$
declare
   nameOfHotel  text      := $1;
   resultset    REFCURSOR := $2;
begin
   open resultset for 
      select p.*, r.roomNumber, h.hotelName, h.streetAddress
      from People p inner join Rooms r on p.pid = r.pid
	                inner join Hotels h on r.hotelID = h.hotelID
      where h.hotelName = nameOfHotel;
   return resultset;
end;
$$ 
language plpgsql;

select hotelSearch('Grand Floridian', 'results');
fetch all from results;


-- TRIGGERS --
--------------

-- isTooShort: Players that are under 5'3 do not deserve to be in the NBA. They will get deleted from
-- the database if they are that short. Sorry. You will get destroyed out there. --
create or replace function isTooShort() returns trigger as
$$
begin
   if (NEW.heightInches < 63) then
   delete from Players where heightInches = NEW.heightInches;
   end if;
   
   return new;
end;
$$ 
language plpgsql;

create trigger isTooShort
after insert on Players
for each row
execute procedure isTooShort();

-- Let's try to add John Smith (who is 4'11 = 59 inches) into the players table.
INSERT INTO Players (pid, primaryPosition, secondaryPosition, heightInches, weightPounds, shootingHand)
VALUES
 (005, 'PG', NULL, 59, 65, 'left');
select * from Players;

-- roomFull: Prevents you from adding someone to a room that's already occupied. --
create or replace function roomFull() returns trigger as
$$
begin
   if (NEW.roomNumber in (select roomNumber from Rooms)) then
   delete from Rooms where roomNumber = NEW.roomNumber;
   end if;
   
   return new;
end;
$$ 
language plpgsql;

create trigger roomFull
after insert on Rooms
for each row
execute procedure roomFull();

-- Let's try to add Thomas Thomas to Lebron's room. --
INSERT INTO Rooms (pid, hotelID, roomNumber)
VALUES
 (013, 02, 5004);
select * from Rooms
select * from People

-- SECURITY --
--------------
create role admin;  -- Admin: access to everything in database.
grant all on
all tables
in schema public
to admin;

create role frontDeskWorker; -- Front Desk: can change/update rooming information.
grant select, insert, update
on Rooms, Hotels
to frontDeskWorker;

create role coach;  -- Coach: can view most staff, player, and game information
grant select
on Players, Teams, TeamStaff, StaffType, Practice, Matchmaking, Games, Venues
to coach;

create role healthDept;     -- Health Worker: can update database with latest COVID info, but nothing else
grant select, insert, update
on COVIDTesting
to healthDept;


-- Thank you Alan for being such a great professor!!!!! ;) --