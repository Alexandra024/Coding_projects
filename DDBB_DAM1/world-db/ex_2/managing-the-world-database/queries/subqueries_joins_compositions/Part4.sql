-- Part 4: Subqueries and Joins
SELECT name FROM country WHERE code IN (
    SELECT countrycode FROM city WHERE population > 1000000 GROUP BY countrycode HAVING COUNT(*) > 5
);
SELECT name FROM country WHERE code IN (
    SELECT countrycode FROM countrylanguage WHERE isofficial = 'T' GROUP BY countrycode HAVING COUNT(*) > 3
);