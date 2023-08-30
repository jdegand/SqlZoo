-- #1

SELECT A_STRONGLY_AGREE
FROM nss
WHERE question='Q01'
AND institution='Edinburgh Napier University'
AND subject='(8) Computer Science';

-- #2

SELECT institution, subject
  FROM nss
 WHERE question='Q15'
   AND score >= 100;

-- #3

SELECT institution,score
  FROM nss
 WHERE question='Q15'
   AND score < 50
   AND subject='(8) Computer Science';

-- #4

/* This doesn't work 

SELECT subject, SUM(response)
  FROM nss
 WHERE question='Q22'
   AND subject='(8) Computer Science'
   AND subject ='(H) Creative Arts and Design'
   GROUP BY subject;
*/

-- Need to use IN - probably other ways - CASE ?   

SELECT subject, SUM(response)
  FROM nss
 WHERE question='Q22'
   AND subject IN ('(8) Computer Science','(H) Creative Arts and Design')
   GROUP BY subject;

-- #5

SELECT subject, SUM(A_STRONGLY_AGREE * response / 100)
  FROM nss
 WHERE question='Q22'
   AND subject IN ('(8) Computer Science','(H) Creative Arts and Design')
   GROUP BY subject;

-- #6

SELECT subject, ROUND(SUM(A_STRONGLY_AGREE * response) / SUM(response), 0)
  FROM nss
  WHERE question='Q22'
    AND subject IN ('(8) Computer Science',
                    '(H) Creative Arts and Design')
  GROUP BY subject;

-- #7

SELECT institution, ROUND(SUM(score * response) / SUM(response), 0)
  FROM nss
 WHERE question='Q22'
   AND (institution LIKE '%Manchester%')
GROUP BY institution

-- #8

-- if you narrow down too quickly, you can't get the total sample

/*
SELECT institution, SUM(sample) as comp
  FROM nss
 WHERE question='Q01'
   AND (institution LIKE '%Manchester%')
   AND subject = '(8) Computer Science'
   GROUP BY institution;
*/

SELECT institution, SUM(sample) as comp, SUM(CASE WHEN subject = '(8) Computer Science' THEN sample ELSE 0 END) as comp
  FROM nss
 WHERE question='Q01'
   AND (institution LIKE '%Manchester%')
   GROUP BY institution;
