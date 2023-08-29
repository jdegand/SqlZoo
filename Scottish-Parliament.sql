-- #1

SELECT name FROM msp WHERE party IS NULL;

-- #2

SELECT name, leader FROM party;

-- #3

SELECT name, leader FROM party WHERE leader IS NOT NULL; 

-- #4

SELECT DISTINCT party.name
FROM party
JOIN msp
ON party.code = msp.party
WHERE party.name IS NOT NULL;

-- #5

SELECT msp.name, party.name FROM msp LEFT JOIN party ON party.code = msp.Party ORDER BY msp.name;

-- #6

SELECT party.name, COUNT(msp.name) FROM msp JOIN party ON party.code = msp.Party GROUP BY party.name;

-- #7

SELECT party.name, COUNT(msp.name) FROM msp RIGHT JOIN party ON party.code = msp.Party GROUP BY party.name;