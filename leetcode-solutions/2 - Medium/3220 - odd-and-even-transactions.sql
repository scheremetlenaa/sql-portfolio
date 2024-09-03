/* Write a solution to find the sum of amounts for odd and even transactions for each day. If there are no odd or even transactions for a specific date, display as 0.

Return the result table ordered by transaction_date in ascending order. */

/* Write your T-SQL query statement below */

SELECT
    transaction_date,
    SUM(CASE
        WHEN amount % 2 = 1 THEN amount
        ELSE 0
    END) AS odd_sum,
    SUM(CASE
        WHEN amount % 2 = 0 THEN amount
        ELSE 0
    END) AS even_sum
FROM transactions
GROUP BY transaction_date
ORDER BY transaction_date;