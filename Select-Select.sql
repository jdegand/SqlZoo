-- #1

SELECT name FROM world WHERE population > (SELECT population FROM world WHERE name = 'Russia');

-- #2

SELECT name FROM world WHERE gdp / population > 
(SELECT gdp / population FROM world WHERE name = 'United Kingdom') AND continent = 'Europe';

-- #3

SELECT name, continent FROM world WHERE continent IN (SELECT continent FROM world WHERE name = 'Argentina' UNION SELECT continent FROM world WHERE name = 'Australia');

-- #4

SELECT name, population FROM WORLD WHERE population > (SELECT population FROM world WHERE name  = 'United Kingdom') AND population < (SELECT population FROM world WHERE name = 'Germany');

-- #5

-- MySql

SELECT 
  name, 
  CONCAT(ROUND((population*100)/(SELECT population 
                                 FROM world WHERE name='Germany'), 0), '%') as percentage
FROM world WHERE continent = 'Europe';

-- #6

SELECT name FROM WORLD WHERE gdp > ALL(SELECT gdp FROM world WHERE continent = 'Europe');

-- #7

SELECT continent, name, area FROM world x
  WHERE area >= ALL
    (SELECT area FROM world y
        WHERE y.continent=x.continent);

-- #8

SELECT continent,name FROM world x
WHERE x.name <= ALL(SELECT y.name FROM world y
                    WHERE x.continent = y.continent)
ORDER BY continent;

-- #9

SELECT name, continent, population 
FROM world x 
WHERE population = ALL(SELECT population 
                        FROM world y 
                        WHERE y.continent = x.continent 
                        AND population <= 25000000);

-- #10

-- MySQL

SELECT x.name, x.continent
  FROM world x
  WHERE x.population > ALL(SELECT population*3
                            FROM world y
                            WHERE y.continent = x.continent
                            AND x.name != y.name)