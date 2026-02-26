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

/*
Execute procGetTeamsByConferenceDivision
@ConferenceName = 'NFC',
@DivisionName = 'North'
*/

GO

select * from Team;

declare @myTeamName NVARCHAR(50) = 'Steelers';

select OtherTeam.TeamName
from Team MyTeam inner join Team OtherTeam
on MyTeam.ConferenceDivisionID = OtherTeam.ConferenceDivisionID
where MyTeam.TeamName != @myTeamName and OtherTeam.TeamName != @myTeamName;

--Find all teams in my Division