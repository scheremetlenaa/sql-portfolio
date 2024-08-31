/* Harry Potter and his friends are at Ollivander's with Ron, finally replacing Charlie's old broken wand.

Hermione decides the best way to choose is by determining the minimum number of gold galleons needed to buy each non-evil wand of high power and age. 

Write a query to print the id, age, coins_needed, and power of the wands that Ron's interested in, sorted in order of descending power. 

If more than one wand has same power, sort the result in order of descending age. */

WITH CTE AS (
    SELECT
        id,
        age,
        coins_needed,
        power,
        ROW_NUMBER() OVER (PARTITION BY power, age ORDER BY coins_needed) AS rw_nm
    FROM Wands w
    INNER JOIN Wands_Property wp
        ON w.code = wp.code
    WHERE is_evil = 0
)

SELECT
    id,
    age,
    coins_needed,
    power
FROM CTE
WHERE rw_nm = 1
ORDER BY power DESC, age DESC;