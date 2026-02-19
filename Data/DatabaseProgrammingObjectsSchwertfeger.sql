SELECT *
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
