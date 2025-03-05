-- Part 5: Query Optimization
SELECT name, population FROM city ORDER BY population DESC LIMIT 10;
EXPLAIN SELECT name, population FROM city ORDER BY population DESC LIMIT 10;
CREATE INDEX idx_city_population ON city(population);