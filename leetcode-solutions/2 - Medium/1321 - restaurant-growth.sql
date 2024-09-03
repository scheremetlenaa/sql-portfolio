/* You are the restaurant owner and you want to analyze a possible expansion (there will be at least one customer every day).

Compute the moving average of how much the customer paid in a seven days window (i.e., current day + 6 days before). average_amount should be rounded to two decimal places.

Return the result table ordered by visited_on in ascending order. */

/* Write your T-SQL query statement below */

WITH CTE1 AS (
    SELECT
        visited_on,
        SUM(amount) AS sum_amount
    FROM Customer
    GROUP BY visited_on
),

CTE2 AS (
    SELECT
        visited_on,
        SUM(sum_amount) OVER(ORDER BY visited_on ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS amount,
        ROUND(AVG(sum_amount * 1.00) OVER(ORDER BY visited_on ROWS BETWEEN 6 PRECEDING AND CURRENT ROW), 2) AS average_amount,
        ROW_NUMBER() OVER(ORDER BY visited_on) AS rw_nm
    FROM CTE1
)

SELECT
    visited_on,
    amount,
    average_amount
FROM CTE2
WHERE rw_nm >= 7
ORDER BY visited_on
