-- List all tables in the "world" database
SHOW TABLES;

-- View the structure of the tables country, city, and countrylanguage
DESCRIBE country;
DESCRIBE city;
DESCRIBE countrylanguage;

-- Add a boolean column to city
ALTER TABLE city ADD COLUMN is_population_large BOOLEAN GENERATED ALWAYS AS (population > 1000000) STORED;

-- Add a column with a default value in country
ALTER TABLE country ADD COLUMN region_code CHAR(3) DEFAULT 'NA';

-- Add a CHECK constraint to ensure population is not negative
ALTER TABLE city ADD CONSTRAINT chk_population CHECK (population >= 0);

-- Ensure the country code in country is unique
ALTER TABLE country ADD CONSTRAINT unique_country_code UNIQUE (code);

-- Create an index on the name column of city
CREATE INDEX idx_city_name ON city(name);

-- Analyze the impact of the index
EXPLAIN SELECT * FROM city WHERE name = 'Madrid';

-- Create a view with cities having more than 1 million inhabitants
CREATE VIEW high_population_cities AS 
SELECT name, countrycode, population FROM city WHERE population > 1000000;

-- Create a view that joins country and countrylanguage (excluding English)
CREATE VIEW countries_with_languages AS
SELECT c.name AS country_name, cl.language 
FROM country c 
JOIN countrylanguage cl ON c.code = cl.countrycode
WHERE cl.language <> 'English';

-- Create a user with specific privileges
CREATE USER 'db_user'@'localhost' IDENTIFIED BY 'password';
GRANT SELECT ON world.city TO 'db_user'@'localhost';
GRANT SELECT ON world.country TO 'db_user'@'localhost';
GRANT INSERT, UPDATE ON world.city TO 'db_user'@'localhost';
REVOKE INSERT, UPDATE, DELETE ON world.country FROM 'db_user'@'localhost';
GRANT SELECT ON world.high_population_cities TO 'db_user'@'localhost';

-- Countries with a population between 50M and 200M
SELECT name FROM country WHERE population BETWEEN 50000000 AND 200000000;

-- Countries with a population between 20M and 50M using IN
SELECT name FROM country WHERE population IN (20000000, 30000000, 40000000, 50000000);

-- Cities with a population between 1M and 10M, excluding Asia
SELECT name FROM city WHERE population BETWEEN 1000000 AND 10000000 
AND countrycode NOT IN (SELECT code FROM country WHERE region = 'Asia');

-- Countries with more than 5 cities having a population >1M
SELECT name FROM country WHERE code IN (
    SELECT countrycode FROM city WHERE population > 1000000 GROUP BY countrycode HAVING COUNT(*) > 5
);

-- Countries with more than 3 official languages
SELECT name FROM country WHERE code IN (
    SELECT countrycode FROM countrylanguage WHERE isofficial = 'T' GROUP BY countrycode HAVING COUNT(*) > 3
);

-- Get the 10 most populated cities
SELECT name, population FROM city ORDER BY population DESC LIMIT 10;

-- Evaluate optimization with EXPLAIN
EXPLAIN SELECT name, population FROM city ORDER BY population DESC LIMIT 10;

-- Create an index to optimize search
CREATE INDEX idx_city_population ON city(population);

-- Start a transaction and perform a rollback
START TRANSACTION;
INSERT INTO city (name, countrycode, district, population) VALUES ('TestCity', 'ESP', 'Madrid', 500000);
SELECT * FROM city WHERE name = 'TestCity';
ROLLBACK;

-- Start a transaction with commit if everything is successful
START TRANSACTION;
INSERT INTO city (name, countrycode, district, population) VALUES ('NewCity', 'FRA', 'Paris', 600000);
UPDATE country SET population = population + 600000 WHERE code = 'FRA';
COMMIT;
