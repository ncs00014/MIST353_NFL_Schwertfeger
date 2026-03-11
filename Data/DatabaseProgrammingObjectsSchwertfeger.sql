/* SELECT *
FROM ConferenceDivision
WHERE Conference = 'NFC';

SELECT TeamName, TeamCityState, TeamColors
FROM Team
WHERE ConferenceDivisionID = 1
ORDER BY TeamName;

SELECT 
    t.TeamName,
    t.TeamCityState,
    cd.Conference,
    cd.Division
FROM Team t
JOIN ConferenceDivision cd
    ON t.ConferenceDivisionID = cd.ConferenceDivisionID
ORDER BY cd.Conference, cd.Division, t.TeamName;
*/

-- use master;

-- CREATE LOGIN APILogin
-- WITH PASSWORD = 'MIST353Instructor'

-- GO

-- use master;

/*
USE master;


CREATE LOGIN NanadaSurendra
WITH PASSWORD = 'MIST353Instructor';



USE [mist353-server-schwertfeger];
GO

CREATE USER NanadaSurendra
FOR LOGIN NanadaSurendra;
GO

GRANT EXECUTE TO NanadaSurendra;
GRANT SELECT TO NanadaSurendra;
*/

/*
CREATE USER APIUser
For LOGIN APILogin;

GRANT EXECUTE to APIUser;
Grant SELECT to APIUser;
*/


/*use [mist353-server-schwertfeger];

GO

create or alter procedure procGetTeamsByConferenceDivision
(
    @ConferenceName NVARCHAR(50) = NULL,
    @DivisionName NVARCHAR(50) =NULL
)
AS
BEGIN
   
    SELECT TeamName, TeamColors, Conference, Division
    FROM Team T
    INNER JOIN ConferenceDivision C
        ON T.ConferenceDivisionID = C.ConferenceDivisionID
    WHERE C.Conference = ISNULL(@ConferenceName, Conference)
    AND C.Division = ISNULL(@DivisionName, Division)

END
*/

/*
Execute procGetTeamsByConferenceDivision
@ConferenceName = 'NFC',
@DivisionName = 'North'
*/

USE [mist353-server-schwertfeger];
GO

CREATE OR ALTER PROCEDURE procGetTeamsInSameConferenceDivisionAsSpecifiedTeam
(
    @TeamName VARCHAR(50)
)
AS
BEGIN
    SELECT OtherTeam.TeamName
    FROM Team MyTeam
    INNER JOIN Team OtherTeam
        ON MyTeam.ConferenceDivisionID = OtherTeam.ConferenceDivisionID
    WHERE MyTeam.TeamName = @TeamName
      AND OtherTeam.TeamName != @TeamName;
END;
GO

EXEC procGetTeamsInSameConferenceDivisionAsSpecifiedTeam
    @TeamName = 'Pittsburgh Steelers';