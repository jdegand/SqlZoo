-- #1

SELECT id, title
FROM movie
WHERE yr=1962

-- #2

SELECT yr FROM movie WHERE title = 'Citizen Kane';

-- #3

SELECT id, title, yr FROM movie WHERE title LIKE 'Star Trek%' ORDER BY yr;

-- #4

SELECT DISTINCT id FROM casting JOIN actor ON casting.actorid = actor.id WHERE actor.name = 'Glenn Close';

-- #5

SELECT id FROM movie WHERE title = 'Casablanca';

-- #6

SELECT name FROM actor JOIN casting ON actor.id = casting.actorid WHERE casting.movieid = 27;

-- #7

SELECT name FROM actor JOIN casting ON actor.id = casting.actorid JOIN movie ON movie.id = casting.movieid WHERE movie.title = 'Alien';

-- #8

SELECT title FROM movie JOIN casting ON casting.movieid = movie.id JOIN actor ON casting.actorid = actor.id WHERE actor.name = 'Harrison Ford'; 

-- #9

SELECT title FROM movie JOIN casting ON casting.movieid = movie.id JOIN actor ON casting.actorid = actor.id WHERE actor.name = 'Harrison Ford' AND casting.ord != 1;

-- #10

SELECT title, name FROM movie JOIN casting ON casting.movieid = movie.id JOIN actor ON casting.actorid = actor.id WHERE movie.yr = 1962 AND casting.ord = 1;

-- #11

-- This question doesn't validate solutions correctly?

-- This may be close?

SELECT movie.yr, COUNT(movie.title) FROM movie JOIN casting ON movie.id = casting.movieid JOIN actor ON actor.id = casting.actorid 
WHERE actor.name = 'Rock Hudson' GROUP BY movie.yr HAVING COUNT(movie.title) > 2;

-- #12

SELECT movie.title, actor.name FROM movie JOIN casting ON movie.id = casting.movieid JOIN actor ON actor.id = casting.actorid WHERE
movie.id IN(
SELECT movieid FROM casting
WHERE actorid IN (
  SELECT id FROM actor
  WHERE name='Julie Andrews')) AND casting.ord = 1;

-- #13

SELECT actor.name FROM actor JOIN casting ON actor.id = casting.actorid 
WHERE casting.ord = 1 GROUP BY actor.name HAVING COUNT(*)>=15;

-- #14

SELECT movie.title, COUNT(casting.actorid) FROM movie JOIN casting ON casting.movieid = movie.id JOIN actor ON actor.id = casting.actorid WHERE movie.yr = 1978 GROUP BY movie.title ORDER BY COUNT(casting.actorid) DESC, title;

-- #15

-- Works with / without DISTINCT 
SELECT actor.name
FROM actor JOIN casting ON actor.id = casting.actorid
WHERE casting.movieid IN (SELECT movieid FROM casting JOIN actor ON casting.actorid=actor.id AND actor.name = 'Art Garfunkel') AND actor.name != 'Art Garfunkel'
GROUP BY actor.name;
