-- Write a solution to find all dates' Id with higher temperatures compared to its previous dates (yesterday).
-- Return the result table in any order.

SELECT w1.id
FROM weather w1
INNER JOIN weather w2
    ON w1.recordDate = DATEADD(DAY, 1, w2.recordDate)
WHERE w1.temperature > w2.temperature;