/*
USE master;
GO

-- Drop database if it already exists
IF DB_ID('MIST353_NFL_Schwertfeger') IS NOT NULL
BEGIN
    ALTER DATABASE MIST353_NFL_Schwertfeger SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE MIST353_NFL_Schwertfeger;
END
GO

-- Recreate database
CREATE DATABASE MIST353_NFL_Schwertfeger;
GO
*/

USE [mist353-server-schwertfeger];
GO


-- CREATE TABLES


CREATE TABLE ConferenceDivision (
    ConferenceDivisionID INT PRIMARY KEY IDENTITY(1,1),
    Conference VARCHAR(3) NOT NULL,
    Division VARCHAR(10) NOT NULL
);
GO

CREATE TABLE Team (
    TeamID INT PRIMARY KEY IDENTITY(1,1),
    TeamName VARCHAR(50) NOT NULL,
    TeamCityState VARCHAR(50) NOT NULL,
    TeamColors VARCHAR(50) NOT NULL,
    ConferenceDivisionID INT NOT NULL,
    CONSTRAINT FK_Team_ConferenceDivision
        FOREIGN KEY (ConferenceDivisionID)
        REFERENCES ConferenceDivision(ConferenceDivisionID)
);
GO
