-- Write a solution to find the percentage of the users registered in each contest rounded to two decimals.
-- Return the result table ordered by percentage in descending order. In case of a tie, order it by contest_id in ascending order.

/* Write your T-SQL query statement below */

SELECT
contest_id,
ROUND(COUNT(*) * 100.0 / (SELECT COUNT(user_id) FROM Users), 2) AS percentage
FROM Register r
INNER JOIN Users u
    ON r.user_id = u.user_id
GROUP BY contest_id
ORDER BY percentage DESC, contest_id ASC;