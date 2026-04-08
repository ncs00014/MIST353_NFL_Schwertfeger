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