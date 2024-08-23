-- Write a solution to find for each date the number of different products sold and their names.
-- The sold products names for each date should be sorted lexicographically.
-- Return the result table ordered by sell_date.

/* Write your T-SQL query statement below */

WITH CTE AS (
    SELECT DISTINCT * FROM Activities
)

SELECT
sell_date,
COUNT(product) AS num_sold,
STRING_AGG(product, ',') WITHIN GROUP (ORDER BY product) AS products
FROM CTE
GROUP BY sell_date;