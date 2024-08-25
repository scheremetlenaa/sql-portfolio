-- Write a solution to report the name and balance of users with a balance higher than 10000. The balance of an account is equal to the sum of the amounts of all transactions involving that account.
-- Return the result table in any order.

/* Write your T-SQL query statement below */

SELECT
name,
SUM(amount) AS balance
FROM Users u
LEFT JOIN Transactions t
    ON u.account = t.account
GROUP BY name
HAVING SUM(amount) > 10000;