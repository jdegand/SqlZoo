-- MySQL

-- #1

SELECT title, artist
  FROM album JOIN track
         ON (album.asin=track.album)
 WHERE song = 'Alison';

 -- #2

 SELECT artist FROM album JOIN track ON (album.asin = track.album) WHERE song = 'Exodus';

-- #3

SELECT song FROM track JOIN album ON album.asin = track.album WHERE album.title = 'Blur';

-- #4

SELECT title, COUNT(*)
  FROM album JOIN track ON (asin=album)
 GROUP BY title;

-- #5

SELECT album.title, COUNT(*) FROM album JOIN track ON track.album = album.asin WHERE track.song LIKE '%Heart%' GROUP BY album.title;

-- #6

SELECT track.song FROM album JOIN track ON track.album = album.asin WHERE track.song = album.title; 

-- #7

SELECT album.artist FROM album WHERE album.artist = album.title;

-- #8

-- problem validating answer ?

SELECT track.song, COUNT(DISTINCT album.title)
FROM album INNER JOIN track ON (album.asin = track.album)
GROUP BY track.song
HAVING COUNT(DISTINCT album.title) > 2;

-- #9

-- started solving this problem by reusing #4 solution

/*

SELECT title, COUNT(*)
  FROM album JOIN track ON (asin=album)
 GROUP BY title;

*/

SELECT title, price, COUNT(song)
  FROM album JOIN track ON (asin=album)
 GROUP BY title, price HAVING price / COUNT(song) < .50;

-- #10

/*

-- once again reused #4 as a base to solve question
-- doesn't validate as correct -> need use asin for count?
-- no, it works if you add title to the order by

SELECT title, COUNT(song)
  FROM album JOIN track ON (asin=album)
 GROUP BY title, price ORDER BY COUNT(song) DESC; -- ,title

*/

SELECT title, COUNT(asin)
  FROM album JOIN track ON (asin=album)
 GROUP BY title, asin ORDER BY COUNT(asin) DESC, title;
 