-- Part 6: Transactions
START TRANSACTION;
INSERT INTO city (name, countrycode, district, population) VALUES ('TestCity', 'ESP', 'Madrid', 500000);
SELECT * FROM city WHERE name = 'TestCity';
ROLLBACK;

START TRANSACTION;
INSERT INTO city (name, countrycode, district, population) VALUES ('NewCity', 'FRA', 'Paris', 600000);
UPDATE country SET population = population + 600000 WHERE code = 'FRA';
COMMIT;