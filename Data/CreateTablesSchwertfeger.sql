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

-- Create Team table
CREATE TABLE Team (
    TeamID INT IDENTITY(1,1),
    TeamName NVARCHAR(50) NOT NULL,
    City NVARCHAR(50) NOT NULL,
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
