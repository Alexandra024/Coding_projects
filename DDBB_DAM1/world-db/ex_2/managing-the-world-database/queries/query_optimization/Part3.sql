-- Part 3: Operators and Comparisons
SELECT name FROM country WHERE population BETWEEN 50000000 AND 200000000;
SELECT name FROM country WHERE population IN (20000000, 30000000, 40000000, 50000000);
SELECT name FROM city WHERE population BETWEEN 1000000 AND 10000000 
AND countrycode NOT IN (SELECT code FROM country WHERE region = 'Asia');