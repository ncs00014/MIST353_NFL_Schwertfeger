-- Drop database if it already exists
USE master;
GO

DROP DATABASE IF EXISTS MIST353_NFL_Schwertfeger;
GO

-- Create database
CREATE DATABASE MIST353_NFL_Schwertfeger;
GO

-- Use the database
USE MIST353_NFL_Schwertfeger;
GO

if(OBJECT_ID('Team') is NOT NULL)
    drop TABLE Team;
if(OBJECT_ID('ConferenceDivision') is NOT NULL)
    drop table ConferenceDivision;

CREATE TABLE ConferenceDivision (
    ConferenceDivisionID INT IDENTITY(1,1)
        CONSTRAINT PK_ConferenceDivision PRIMARY KEY,
    Conference NVARCHAR(50) NOT NULL
        constraint CK_ConferenceNames CHECK (Division IN ('East', 'North', 'South', 'West')),
    CONSTRAINT UK_ConferenceDivision UNIQUE (Conference, Division)        

);

/*
alter table ConferenceDivision
  NOCHECK constraint CK_ConferenceNames;

alter table ConferenceDivision
    CHECK CONSTRAINT CK_ConferenceNames;
*/


-- Create Team table
CREATE TABLE Team (
    TeamID INT IDENTITY(1,1),
        CONSTRAINT PK_Team PRIMARY KEY,
    TeamName NVARCHAR(50) NOT NULL,
    TeamCityState NVARCHAR(50) NOT NULL,
    TeamColors NVARCHAR(50) NOT NULL,
    CONSTRAINT PK_Team PRIMARY KEY (TeamID)
);
GO

-- Create Player table
CREATE TABLE Player (
    PlayerID INT IDENTITY(1,1),
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    Position NVARCHAR(50) NOT NULL,
    TeamID INT NOT NULL,
    CONSTRAINT PK_Player PRIMARY KEY (PlayerID),
    CONSTRAINT FK_Player_Team
        FOREIGN KEY (TeamID) REFERENCES Team(TeamID)
);
GO
