-- #1

SELECT yr, subject, winner FROM nobel WHERE yr = 1950;

-- #2

SELECT winner FROM nobel WHERE yr = 1962 AND subject = 'literature';

-- #3

SELECT yr, subject FROM nobel WHERE winner = 'Albert Einstein';

-- #4 

SELECT winner FROM nobel WHERE yr >= 2000 AND subject='peace';

-- #5

SELECT * FROM nobel WHERE yr >= 1980 AND yr <= 1989 AND subject='literature';

-- #6

SELECT * FROM nobel 
WHERE winner IN ('Theodore Roosevelt',
                  'Woodrow Wilson',
                  'Jimmy Carter',
                  'Barack Obama');

-- #7

SELECT winner FROM nobel WHERE winner LIKE 'John%';

-- #8

SELECT * FROM nobel WHERE subject = 'physics' AND yr = '1980' OR subject = 'chemistry' AND yr = '1984';

-- #9

SELECT *
FROM nobel
WHERE yr = 1980 AND winner NOT IN (SELECT winner
FROM nobel
WHERE
subject = 'Chemistry' OR subject = 'Medicine' );

-- #10

SELECT *
FROM nobel
WHERE yr < 1910 AND 
subject = 'Medicine'
UNION
SELECT *
FROM nobel
WHERE yr >= 2004 AND 
subject = 'Literature';

-- #11

SELECT * FROM nobel WHERE winner LIKE '%Gr[uü]nberg%';

-- #12

SELECT * FROM nobel WHERE winner =  'Eugene O''Neill';

-- #13

SELECT winner, yr, subject FROM nobel WHERE winner LIKE 'Sir%' ORDER BY yr DESC, winner;

-- #14

-- Microsoft Sql

SELECT winner, subject FROM nobel
WHERE yr = 1984
ORDER BY
    case
        when subject in ('Physics', 'Chemistry') then 1
        else 0
    end
    , subject
    , winner;
