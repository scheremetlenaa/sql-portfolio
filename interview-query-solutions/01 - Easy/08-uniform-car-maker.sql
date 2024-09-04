-- Given a table of cars with columns id and make, write a query that outputs a random manufacturer’s name with an equal probability of selecting any name.

SELECT 
    DISTINCT make
FROM cars
ORDER BY RAND()
LIMIT 1;