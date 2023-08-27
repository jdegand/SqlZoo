-- #1

SELECT matchid, player FROM goal WHERE teamid = 'GER';

-- #2

-- returns 3

SELECT id,stadium,team1,team2
FROM game JOIN goal ON goal.matchid = game.id WHERE game.id = 1012;

-- don't even need JOIN

SELECT id,stadium,team1,team2
FROM game WHERE id = 1012;

-- #3

SELECT player,teamid,stadium, mdate
FROM game JOIN goal ON (id=matchid) WHERE teamid = 'GER';

-- #4

SELECT team1, team2, player
FROM game JOIN goal ON (id=matchid) WHERE player LIKE 'Mario%';

-- #5

SELECT player, teamid, coach, gtime
FROM goal JOIN eteam on teamid=id 
WHERE gtime <= 10;

-- #6

SELECT mdate, teamname FROM game JOIN eteam ON (team1=eteam.id) WHERE coach = 'Fernando Santos';

-- #7

SELECT player
FROM game JOIN goal ON (id=matchid) WHERE stadium = 'National Stadium, Warsaw';

-- #8

SELECT DISTINCT player
  FROM game JOIN goal ON matchid = id 
    WHERE (team1='GER' OR team2='GER') AND goal.teamid != 'GER';

-- #9

SELECT teamname, COUNT(*)
FROM eteam JOIN goal ON id=teamid
GROUP BY teamname;

-- #10

SELECT stadium, COUNT(*) FROM game JOIN goal ON game.id = goal.matchid
GROUP BY stadium;

-- #11

SELECT matchid, mdate, COUNT(player)
FROM goal JOIN game ON matchid = id 
WHERE (team1 = 'POL' OR team2 = 'POL')
GROUP BY matchid, mdate;

-- #12

SELECT matchid, mdate, COUNT(player)
FROM goal JOIN game ON matchid = id 
WHERE (team1 = 'GER' OR team2 = 'GER') AND teamid = 'GER'
GROUP BY matchid, mdate;

-- #13

-- Need LEFT JOIN to get 0-0 games 
-- Not mentioned in directions

SELECT game.mdate, game.team1, 
SUM(CASE WHEN goal.teamid = game.team1 THEN 1 ELSE 0 END) AS score1,
game.team2,
SUM(CASE WHEN goal.teamid = game.team2 THEN 1 ELSE 0 END) AS score2
FROM game LEFT JOIN goal ON matchid = id
GROUP BY game.id,game.mdate, game.team1, game.team2
ORDER BY mdate,team1,team2
