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

use [mist353-server-schwertfeger];

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

GO
/*
Execute procGetTeamsByConferenceDivision
@ConferenceName = 'NFC',
@DivisionName = 'North'
*/

CREATE OR ALTER PROCEDURE procGetOtherTeamsInDivision
(
    @TeamName VARCHAR(50)
)
AS
BEGIN

    SELECT 
        OtherTeam.TeamName
    FROM Team AS MyTeam
        INNER JOIN Team AS OtherTeam
            ON MyTeam.ConferenceDivisionID = OtherTeam.ConferenceDivisionID
    WHERE 
        MyTeam.TeamName = @TeamName
        AND OtherTeam.TeamName <> @TeamName;

END;
GO