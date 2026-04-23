-- 3 queries
-- 1 each for ConferenceDivision and Team tables, and 1 join query

/*
1. User searches for teams using Conference name (optional) and / or Division name (optional)
To show: TeamName, ConferenceName, DivisionName
*/

go


create or alter procedure procGetTeamsByConferenceDivision
(
    @ConferenceName NVARCHAR(50) = null,
    @DivisionName NVARCHAR(50) = null
)
AS
begin
    select TeamName, TeamColors, Conference, Division
    from Team T inner join ConferenceDivision C
        on T.ConferenceDivisionID = C.ConferenceDivisionID
    where Conference = IsNull(@ConferenceName, Conference)
        and Division = IsNull(@DivisionName, Division)
end
/*
execute procGetTeamsByConferenceDivision
    @ConferenceName = 'AFC',
    @DivisionName = 'North';
*/


go

create OR alter procedure procGetTeamsInSameConferenceDivisionAsSpecifiedTeam
(
    @TeamName NVARCHAR(50)
)
AS
BEGIN
    select OtherTeam.TeamName, CD.Conference, CD.Division
    from Team MyTeam inner join Team OtherTeam
        on MyTeam.ConferenceDivisionID = OtherTeam.ConferenceDivisionID
        inner join ConferenceDivision CD
        on MyTeam.ConferenceDivisionID = CD.ConferenceDivisionID
    where MyTeam.TeamName = @TeamName and
        OtherTeam.TeamName != @TeamName;
END
-- execute procGetTeamsInSameConferenceDivisionAsSpecifiedTeam @TeamName = 'Baltimore Ravens';

GO

CREATE or alter PROCEDURE procValidateUser
(
    @Email NVARCHAR(100),
    @PasswordHash NVARCHAR(200)
)
AS
BEGIN
    SELECT AppUserID, FirstName + ' ' + LastName as Fullname, UserRole
    from AppUser
    where Email = @Email AND
    PasswordHash = Convert(VARBINARY(200), @PasswordHash, 1);
END

--execute procValidateUser @Email = 'tom.brady@example.com', @PasswordHash = '0x01';
-- select * from AppUser

go

create or alter procedure procGetTeamsForSpecifiedFan
(
    @NFLFanID INT
)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        T.TeamName,
        T.TeamColors,
        CD.Conference,
        CD.Division,
        FT.PrimaryTeam
    FROM FanTeam FT
    INNER JOIN Team T
        ON FT.TeamID = T.TeamID
    INNER JOIN ConferenceDivision CD
        ON T.ConferenceDivisionID = CD.ConferenceDivisionID
    WHERE FT.NFLFanID = @NFLFanID
    ORDER BY FT.PrimaryTeam DESC, T.TeamName;
END

--execute procGetTeamsForSpecifiedFan @NFLFanID = 1;
--execute procGetTeamsForSpecifiedFan @NFLFanID = 2;

go

create or alter procedure procScheduleGame
(
    @HomeTeamID INT,
    @AwayTeamID INT,
    @GameRound NVARCHAR (50),
    @GameDate DATE,
    @GameStartTime TIME,
    @StadiumID INT,
    @NFLAdminID INT -- the logged-in admin who is scheduling the game
)
AS
BEGIN
    -- Store the NFLAdminID in context so that the trigger can access it when inserting into AdminChangesTracker
    declare @context VARBINARY (128) = cast(@NFLAdminID as VARBINARY(128));
    SET context_info @context;

    insert into Game(HomeTeamID, AwayTeamID, GameRound, GameDate, GameStartTime, StadiumID)
    values (@HomeTeamID, @AwayTeamID, @GameRound, @GameDate, @GameStartTime, @StadiumID);
END

/*

GameRound: 'Wild Card', HomeTeamID: 22, AwayTeamID: 30, GameDate: '2026-01-10', GameStartTime: '16:30', StadiumID: 22, 
NFLAdminID for scheduling: 5 (Bill Belichick)

execute procScheduleGame
    @HomeTeamID = 22,
    @AwayTeamID = 30,
    @GameRound = 'Wild Card',
    @GameDate = '2026-01-10',
    @GameStartTime = '16:30',
    @StadiumID = 22,
    @NFLAdminID = 5;

GameRound: 'Wild Card', HomeTeamID: 17, AwayTeamID: 19, GameDate: '2026-01-10', GameStartTime: '20:00', StadiumID: 17,
NFLAdminID for scheduling: 6 (Sean McVay)

execute procScheduleGame
    @HomeTeamID = 17,
    @AwayTeamID = 19,
    @GameRound = 'Wild Card',
    @GameDate = '2026-01-10',
    @GameStartTime = '20:00',
    @StadiumID = 17,
    @NFLAdminID = 6;

select * from Game order by GameID desc;
select * from AdminChangesTracker order by AdminChangesTrackerID desc;

*/

GO

-- trigger to track changes made NFLAdmin to the Game table
-- 1. triggering event (insert, update, delete) on Game table
-- 2. action: insert a record into AdminChangesTracker with NFLAdminID, GameID, ChangeType, ChangeDescription

create or alter trigger trgTrackChangesOnSchedulingGame 
on Game 
after insert 
as 
BEGIN

    declare @NFLAdminID INT;
    declare @GameID INT;
    declare @ChangeType NVARCHAR (50);
    declare @ChangeDescription NVARCHAR(500);
    DECLARE @GameRound NVARCHAR(50);
    DECLARE @GameDate DATE;
    DECLARE @GameStartTime TIME;
    DECLARE @HomeTeamID INT;
    DECLARE @AwayTeamID INT;
    DECLARE @HomeTeamName NVARCHAR(50);
    DECLARE @AwayTeamName NVARCHAR(50);
    DECLARE @StadiumID INT;
    DECLARE @StadiumName NVARCHAR(100);
    DECLARE @AdminFullName NVARCHAR(100);

    -- get the NFLAdminID from context
    set @NFLAdminID = convert(int, convert(binary(4),context_info()));

  SELECT 
        @GameID = GameID, 
        @GameRound = GameRound, 
        @GameDate = GameDate,
        @GameStartTime = GameStartTime, 
        @StadiumID = StadiumID,
        @HomeTeamID = HomeTeamID,
        @AwayTeamID = AwayTeamID
    FROM inserted;

    -- get the GameID of the newly inserted game
    select @GameID = GameID, @GameRound = GameRound, @GameDate = GameDate,
        @GameStartTime = GameStartTime, @StadiumID = StadiumID
    from inserted;
    SELECT @HomeTeamName = TeamName from Team where TeamID = @HomeTeamID;
    SELECT @AwayTeamName = TeamName from Team where TeamID = @AwayTeamID;
    SELECT @StadiumName = StadiumName from  Stadium where StadiumID = @StadiumID;
    SELECT @AdminFullName = Firstname + ' ' + Lastname from AppUser WHERE AppUserID = @NFLAdminID;

    set @ChangeType = 'Insert';
    set @ChangeDescription = @AdminFullName + 'scheduled a new game with GameID ' + cast(@GameID as NVARCHAR(50))
        + ': ' + @HomeTeamName + ' vs ' + @AwayTeamName + ' on ' + cast(@GameDate as nvarchar(50))
        + ' at ' + cast(@GameStartTime as NVARCHAR(50)) + ' in stadium ' +@StadiumName
        + '. Game round: ' +@GameRound;

    insert into AdminChangesTracker (NFLAdminID, GameID, ChangeType, ChangeDescription)
    values (@NFLAdminID, @GameID, @ChangeType, @ChangeDescription);
END