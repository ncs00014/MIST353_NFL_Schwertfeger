if(OBJECT_ID('Team') is not null)
    drop table Team;
if(OBJECT_ID('ConferenceDivision') is not null)
    drop table ConferenceDivision;
if(OBJECT_ID('AppUser') is not NULL)
    drop table AppUser;

-- Create tables for first iteration
go

create TABLE ConferenceDivision ( 
    ConferenceDivisionID INT identity(1,1) 
        constraint PK_ConferenceDivision PRIMARY KEY,
    Conference NVARCHAR(50) NOT NULL
        constraint CK_ConferenceNames CHECK (Conference IN ('AFC', 'NFC')),
    Division NVARCHAR(50) NOT NULL
        constraint CK_DivisionNames CHECK (Division IN ('East', 'North', 'South', 'West')),
    constraint UK_ConferenceDivision UNIQUE (Conference, Division)
);

/*
alter table ConferenceDivision
    NOCHECK CONSTRAINT CK_ConferenceNames;

alter table ConferenceDivision
    CHECK CONSTRAINT CK_ConferenceNames;
*/

go

create TABLE Team ( 
    TeamID INT identity(1,1) 
        constraint PK_Team PRIMARY KEY,
    TeamName NVARCHAR(50) NOT NULL,
    TeamCityState NVARCHAR(50) NOT NULL,
    TeamColors NVARCHAR(100) NOT NULL,
    ConferenceDivisionID INT NOT NULL
        constraint FK_Team_ConferenceDivision FOREIGN KEY REFERENCES ConferenceDivision(ConferenceDivisionID)
);

GO

-- Create Tables for Second Iteration

CREATE TABLE AppUser(
    AppUserID INT IDENTITY(1,1)
        CONSTRAINT PK_AppUser PRIMARY KEY,
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    Email NVARCHAR(100) NOT NULL
        CONSTRAINT UK_AppUserEmail UNIQUE,
    PasswordHash VARBINARY(200) NOT NULL,
    Phone NVARCHAR(20) NOT NULL,
    UserRole NVARCHAR(20) NOT NULL
        CONSTRAINT CK_AppUserRole CHECK (UserRole In (N'NFL Admin', N'NFL Fan'))
);

create table NFLFan(
    NFLFanID INT identity(1,1)
        constraint PK_NFLFan PRIMARY KEY,
    AppUserID INT NOT NULL
        constraint FK_NFLFan_AppUser FOREIGN KEY REFERENCES AppUser (AppUserID),
FavoriteTeamID INT NOT NULL
constraint FK_NFLFan_Team FOREIGN KEY REFERENCES Team (TeamID)

);