-- Part 2: Views, Users, and Privileges
CREATE VIEW high_population_cities AS 
SELECT name, countrycode, population FROM city WHERE population > 1000000;

CREATE VIEW countries_with_languages AS
SELECT c.name AS country_name, cl.language 
FROM country c 
JOIN countrylanguage cl ON c.code = cl.countrycode
WHERE cl.language <> 'English';

CREATE USER 'db_user'@'localhost' IDENTIFIED BY 'password';
GRANT SELECT ON world.city TO 'db_user'@'localhost';
GRANT SELECT ON world.country TO 'db_user'@'localhost';
GRANT INSERT, UPDATE ON world.city TO 'db_user'@'localhost';
REVOKE INSERT, UPDATE, DELETE ON world.country FROM 'db_user'@'localhost';
GRANT SELECT ON world.high_population_cities TO 'db_user'@'localhost';
