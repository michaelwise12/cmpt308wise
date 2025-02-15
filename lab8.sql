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

-- ZIPAddress --
CREATE TABLE ZIPAddress (
   zip     text not null,
   city    text,
   state   text,
 primary key(zip)
);

-- People --
CREATE TABLE People (
   pid              int not null,
   firstName        text,
   lastName         text,
   address          text,
   zip              text not null references ZIPAddress(zip),
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

-- #4: Write a query to show all directors with whom "Roger Moore" has worked. --
select firstName, lastName
from People
where pid in (select pid
              from MovieDirectors
              where mid in (select mid -- this line finds actors and directors that were in the same movie
                            from MovieActors
                            where pid in (select pid -- find actors named Roger Moore
                                          from Actors
                                          where pid in (select pid
                                                        from People
                                                        where firstName = 'Roger'
                                                          and lastName  = 'Moore')
                                         )
                           )
             );

-- A more fitting query would be for directors Sean Connery has worked with. --
-- R.I.P. Aug. 25 1930 - Oct. 31 2020 --