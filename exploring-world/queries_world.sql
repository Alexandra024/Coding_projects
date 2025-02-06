USE world; -- database

SHOW TABLES;
-- preview tables
SELECT * FROM countrylanguages;
SELECT * FROM country;
SELECT * FROM city;


-- Retrieve all country names and their official languages.  
SELECT name , language FROM country
JOIN countrylanguage 
ON country.code = countrylanguage.countrycode; 

-- List all cities in Germany along with their population.  
SELECT ci.Name AS CityName, ci.Population
FROM city ci
JOIN country co ON ci.CountryCode = co.Code
WHERE co.Name = 'Germany';

-- Find the five smallest countries by surface area.  
SELECT Name AS CountryName, SurfaceArea
FROM country
ORDER BY SurfaceArea ASC
LIMIT 5;

-- Find all countries with a population greater than 50 million and sort them in descending order of population.
SELECT Name AS CountryName, Population
FROM country
WHERE Population > 50000000
ORDER BY Population DESC;
  
-- Retrieve the average life expectancy per continent.  
SELECT Continent, AVG(LifeExpectancy) AS AvgLifeExpectancy
FROM country
GROUP BY Continent;

-- Calculate the total population per region.  
SELECT Region, SUM(Population) AS TotalPopulation
FROM country
GROUP BY Region;

-- Count the number of cities in each country and sort by the highest count.  
SELECT co.Name AS CountryName, COUNT(ci.ID) AS CityCount
FROM country co
JOIN city ci ON co.Code = ci.CountryCode
GROUP BY co.Name
ORDER BY CityCount DESC;

-- Display the top 10 largest cities along with their country name.  
SELECT ci.Name AS CityName, co.Name AS CountryName, ci.Population
FROM city ci
JOIN country co ON ci.CountryCode = co.Code
ORDER BY ci.Population DESC
LIMIT 10;

-- Retrieve the names of all countries that have an official language of French.  
SELECT co.Name AS CountryName
FROM country co
JOIN countrylanguage cl ON co.Code = cl.CountryCode
WHERE cl.Language = 'French' AND cl.IsOfficial = 'T';

-- Find all countries where English is spoken, but it is not the official language.  
SELECT co.Name AS CountryName
FROM country co
JOIN countrylanguage cl ON co.Code = cl.CountryCode
WHERE cl.Language = 'English' AND cl.IsOfficial = 'F';


--                            /*Aqui tiene q haber algo histórico*/

-- Find countries where the population tripled in the past 50 years (if historical data is available).  
SELECT Name AS CountryName
FROM country
WHERE Population >= 3 * (SELECT Population FROM historical_population WHERE Year = YEAR(CURDATE()) - 50);



-- List the richest and poorest countries in each continent based on GNP (Gross National Product).  
SELECT Continent, 
       MAX(GNP) AS RichestCountryGNP, 
       MIN(GNP) AS PoorestCountryGNP
FROM country
GROUP BY Continent;

-- Identify countries with a life expectancy below the global average.  
SELECT Name AS CountryName, LifeExpectancy
FROM country
WHERE LifeExpectancy < (SELECT AVG(LifeExpectancy) FROM country);

-- Retrieve the capital cities of countries with a population above 100 million.  
SELECT ci.Name AS CapitalCity, co.Name AS CountryName
FROM country co
JOIN city ci ON co.Capital = ci.ID
WHERE co.Population > 100000000;

-- Find the continent with the highest number of countries.
SELECT Continent, COUNT(*) AS NumberOfCountries
FROM country
GROUP BY Continent
ORDER BY NumberOfCountries DESC
LIMIT 1;