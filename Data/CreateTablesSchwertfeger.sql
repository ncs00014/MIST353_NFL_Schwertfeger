-- Create a database for the NFL app

use MIST353_NFL_Schwertfeger
GO

-- if(OBJECT_ID('Team') IS NOT NULL) -- this is a check to see if the Team table already exists, if it does, it will drop the table before creating it again (this is useful)
--drop table Team;
--if(OBJECT_ID('ConferenceDivision') IS NOT NULL) -- this is a check to see if the ConferenceDivision table already exists, if it does, it will drop the table before creating
--drop table ConferenceDivision;

-- Create table for first iteration
GO

Create TABLE ConferenceDivision (
    ConferenceDivisionID INT IDENTITY (1,1)
    constraint PK_ConferenceDivision Primary Key,
    Conference NVARCHAR(50) NOT NULL
    CONSTRAINT CK_Conferences CHECK (Conference IN ('AFC', 'NFC')),
    Division NVARCHAR(50) NOT NULL
    CONSTRAINT CK_DivisionNames CHECK (Division IN ('North','South', 'East', 'West')),
    CONSTRAINT UK_ConferenceDivision UNIQUE (Conference, Division)
);

--alter table ConferenceDivision
--NOCHECK CONSTRAINT CK_ConferenceNames;

--alter table ConferenceDivision
--CHECK CONSTRAINT CK_DivisionNames;

CREATE TABLE Team (
    TeamID INT IDENTITY (1,1)
    constraint PK_Team Primary Key,
    TeamName NVARCHAR(50) NOT NULL,
    TeamCityState NVARCHAR(50) NOT NULL,
    TeamColors NVARCHAR(100) NOT NULL,
    ConferenceDivisionID INT NOT NULL,
    constraint FK_Team_ConferenceDivision FOREIGN KEY (ConferenceDivisionID) REFERENCES ConferenceDivision
);

