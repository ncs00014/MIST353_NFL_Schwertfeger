if(OBJECT_ID( 'FanTeam') is not null)
    drop table FanTeam;
if(OBJECT_ID('NFLFan') is not null)
    drop table NFLFan;
if(OBJECT_ID('NFLAdmin') is not null)
    drop table NFLAdmin;
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
        CONSTRAINT CK_AppUserRole CHECK (UserRole In (N'NFLAdmin', N'NFLFan'))
);

CREATE TABLE NFLFan(
    NFLFanID INT
        CONSTRAINT PK_NFLFan PRIMARY KEY
        CONSTRAINT FK_NFLFan_AppUser FOREIGN KEY REFERENCES AppUser(AppUserID)
);

GO

CREATE TABLE NFLAdmin(
    NFLAdminID INT
        CONSTRAINT PK_NFLAdmin PRIMARY KEY
        CONSTRAINT FK_NFLAdmin_AppUser FOREIGN KEY REFERENCES AppUser(AppUserID)
);

GO

create table FanTeam(
    FanTeamID INT identity(1,1)
        constraint PK_FanTeam PRIMARY KEY,
    NFLFanID INT NOT NULL
        constraint FK_FanTeam_NFLFan FOREIGN KEY REFERENCES NFLFan (NFLFanID),
    TeamID INT NOT NULL
        constraint FK_FanTeam_Team FOREIGN KEY REFERENCES Team(TeamID),
    constraint UK_FanTeam UNIQUE (NFLFanID, TeamID),
    PrimaryTeam BIT NOT NULL

);