/* Write a solution to find managers with at least five direct reports.

Return the result table in any order. */

/* Write your T-SQL query statement below */

SELECT
    name
FROM Employee
WHERE id IN (
    SELECT
        managerId
    FROM Employee
    GROUP BY managerId
    HAVING COUNT(*) >= 5
);