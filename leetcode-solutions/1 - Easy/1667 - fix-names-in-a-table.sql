/* Write a solution to fix the names so that only the first character is uppercase and the rest are lowercase.
Return the result table ordered by user_id. */

/* Write your T-SQL query statement below */

SELECT
user_id,
UPPER(LEFT(name, 1)) + LOWER(SUBSTRING(name, 2, LEN(name))) AS name
FROM Users
ORDER BY user_id;