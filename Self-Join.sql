-- #1

SELECT count(name) FROM stops;

-- #2

SELECT id FROM stops WHERE name = 'Craiglockhart';

-- #3

SELECT id, name FROM stops JOIN route ON route.stop = stops.id WHERE route.num = '4' AND route.company = 'LRT';

-- #4

SELECT company, num, COUNT(*)
FROM route WHERE stop=149 OR stop=53
GROUP BY company, num
HAVING COUNT(*) =  2;

-- #5

SELECT a.company, a.num, a.stop, b.stop
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
WHERE a.stop=53 AND b.stop = 149;

-- #6

SELECT a.company, a.num, stopa.name, stopb.name
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
  JOIN stops stopa ON (a.stop=stopa.id)
  JOIN stops stopb ON (b.stop=stopb.id)
WHERE stopa.name='Craiglockhart' AND stopb.name='London Road';

-- #7

-- Use DISTINCT only once

SELECT DISTINCT a.company, a.num
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
WHERE a.stop=115 AND b.stop = 137;

-- #8

SELECT DISTINCT a.company, a.num
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
  JOIN stops stopa ON (a.stop=stopa.id)
  JOIN stops stopb ON (b.stop=stopb.id)
WHERE stopa.name='Craiglockhart' AND stopb.name='Tollcross';

-- #9

SELECT DISTINCT stopb.name, a.company, a.num
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
  JOIN stops stopa ON (a.stop=stopa.id)
  JOIN stops stopb ON (b.stop=stopb.id)
WHERE a.company = 'LRT' AND stopa.name='Craiglockhart';

-- #10

SELECT a.num, a.company,  stops.name,  d.num, d.company
FROM route a JOIN route b ON a.company = b.company AND a.num = b.num
JOIN stops ON b.stop = stops.id
JOIN route c ON c.stop = stops.id
JOIN route d ON c.company = d.company AND c.num = d.num
WHERE a.stop = (SELECT id FROM stops WHERE name = 'Craiglockhart')
AND d.stop = (SELECT id FROM stops WHERE name = 'Lochend')
ORDER BY a.num, stops.name, d.num;
