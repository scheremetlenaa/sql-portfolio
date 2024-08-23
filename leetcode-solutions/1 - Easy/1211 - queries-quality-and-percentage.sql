` We define query quality as:
- The average of the ratio between query rating and its position.
We also define poor query percentage as:
- The percentage of all queries with rating less than 3.
Write a solution to find each query_name, the quality and poor_query_percentage.
Both quality and poor_query_percentage should be rounded to 2 decimal places.
Return the result table in any order `

/* Write your T-SQL query statement below */

SELECT
query_name,
ROUND(SUM(CAST(rating AS DECIMAL)/position) / COUNT(*), 2) AS quality,
ROUND(COUNT(CASE WHEN rating<3 THEN 1 ELSE NULL END) * 100.0 / COUNT(rating), 2) AS poor_query_percentage
FROM Queries
GROUP BY query_name
HAVING query_name IS NOT NULL;