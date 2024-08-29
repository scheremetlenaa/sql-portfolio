/* Write a solution to find the people who have the most friends and the most friends number.

The test cases are generated so that only one person has the most friends. */

/* Write your T-SQL query statement below */

WITH CTE AS (
    SELECT
        requester_id
    FROM RequestAccepted
    UNION ALL
    SELECT
        accepter_id
    FROM RequestAccepted
)

SELECT TOP 1 requester_id AS id, COUNT(*) AS num
FROM CTE
GROUP BY requester_id
ORDER BY num DESC;