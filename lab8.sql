------------------------------------------------------------------------------------------------------
-- Author: Michael Wise
--
-- Date: 12 November 2020
--
-- Class: CMPT308 Database Management
--
-- Professor: Dr. Alan Labouseur
-- 
-- Lab #8: Normalization Two
------------------------------------------------------------------------------------------------------

-- #2: SQL create statements for each table of our movie database. --

-- People --
CREATE TABLE People (
   pid              int not null,
   firstName        text,
   lastName         text,
   address          text,
   spouseFirstName  text,
   spouseLastName   text,
 primary key(pid)
);

-- Actors --
CREATE TABLE Actors (
   pid           int not null references People(pid),
   birthDate     date,
   hairColor     text,
   eyeColor      text,
   heightInches  int,
   weight        int,
   favoriteColor text,
   sagaDate      date,
 primary key(pid)
);

-- Directors --
CREATE TABLE Directors (
   pid           int not null references People(pid),
   filmSchool    text,
   dgaDate       date,
   favLensMaker  text,
 primary key(pid)
);

-- Movies --
CREATE TABLE Movies (
  mid              int not null,
  title            text,
  yearReleased     text,
  boxOfficeDom     money,
  boxOfiiceForeign money,
  salesDVDBR       money,
 primary key(mid)
);

-- MovieActors --
-- Associative entity to resolve many-to-many relationship between Movies and Actors. --
CREATE TABLE MovieActors (
  mid   int not null references Movies(mid),
  pid   int not null references Actors(pid),
 primary key(mid, pid)
);

-- MovieDirectors --
-- Associative entity to resolve many-to-many relationship between Movies and Directors. --
CREATE TABLE MovieDirectors (
  mid   int not null references Movies(mid),
  pid   int not null references Directors(pid),
 primary key(mid, pid)
);
