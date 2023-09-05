-- #1

SELECT name, DAY(whn),
 confirmed, deaths, recovered
 FROM covid
WHERE name = 'Spain'
AND MONTH(whn) = 3 AND YEAR(whn) = 2020
ORDER BY whn;

-- #2

SELECT name, DAY(whn), confirmed,
   LAG(confirmed, 1) OVER (partition by name ORDER BY whn) AS lag
 FROM covid
WHERE name = 'Italy'
AND MONTH(whn) = 3
ORDER BY whn

-- #3

SELECT name, DAY(whn),
  (confirmed - LAG(confirmed) OVER (PARTITION BY name ORDER BY whn)) AS new
FROM covid
WHERE (name = 'Italy') AND (MONTH(whn) = 3)
ORDER BY whn;

-- #4

-- MySql

SELECT name, DATE_FORMAT(whn,'%Y-%m-%d'), (confirmed - LAG(confirmed) OVER (PARTITION BY name ORDER BY whn)) as new
 FROM covid
WHERE name = 'Italy'
AND WEEKDAY(whn) = 0 AND YEAR(whn) = 2020
ORDER BY whn;


-- #5

SELECT tw.name, DATE_FORMAT(tw.whn,'%Y-%m-%d'), 
 tw.confirmed - lw.confirmed
 FROM covid tw LEFT JOIN covid lw ON 
  DATE_ADD(lw.whn, INTERVAL 1 WEEK) = tw.whn
   AND tw.name=lw.name
WHERE tw.name = 'Italy'
AND WEEKDAY(tw.whn) = 0
ORDER BY tw.whn;

-- #6

SELECT 
   name,
   confirmed,
   RANK() OVER (ORDER BY confirmed DESC) rc,
   deaths,
   RANK() OVER (ORDER BY deaths DESC)
  FROM covid
WHERE whn = '2020-04-20'
ORDER BY confirmed DESC;

-- #7

-- MySQL

/*

-- This is close.  
-- This is tough to spot - need to use diffchecker.  
-- Problem with ranking of Sudan and Nepal.  Both were 1 rank short.  Tie?

SELECT 
   world.name,
   ROUND(100000*confirmed/population,2) as cases, 
   RANK() OVER (order by cases)
  FROM covid JOIN world ON covid.name=world.name
WHERE whn = '2020-04-20' AND population >= 10000000
ORDER BY population DESC;

*/

SELECT 
   world.name,
   ROUND(100000*confirmed/population,2) as cases, 
   RANK() OVER(ORDER BY 100000*confirmed/population) AS rank
  FROM covid JOIN world ON covid.name=world.name
WHERE whn = '2020-04-20' AND population >= 10000000
ORDER BY population DESC;

-- #8

-- Starter code and hints would have been helpful 
-- I started by mixing approaches from #4 and #5 solutions
-- Eventually I gave up 
-- Looked at few solutions and most have problem where a few dates are off by 1 
-- Another solution had 3 countries in the wrong order
-- Hard to find one solution where there isn't something off

-- I think using DATE_ADD makes sense but some solutions don't use it. 

select t2.name,DATE_FORMAT(t3.whn,'%Y-%m-%d'),t2.peakNewCases
from
    (select a.name, max(a.confirmed-b.confirmed) as peakNewCases
     from covid a 
     join covid b
     on DATE_ADD(b.whn, interval 24 hour)=a.whn -- 1 DAY 
     and 
     a.name=b.name
     where a.confirmed-b.confirmed>999
     group by name
    ) t2 
join 
    (select name, whn, confirmed-lag(confirmed,1) over (partition by name order by confirmed) as peakNewCases
     from covid
    ) t3 
on t2.peakNewCases=t3.peakNewCases 
and 
t2.name=t3.name
order by t3.whn 