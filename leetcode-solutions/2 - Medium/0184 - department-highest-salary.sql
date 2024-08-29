/* Write a solution to find employees who have the highest salary in each of the departments.

Return the result table in any order. */

/* Write your T-SQL query statement below */

WITH CTE AS (
    SELECT
        e.name AS Employee,
        salary,
        d.name AS Department,
        DENSE_RANK() OVER(PARTITION BY d.name ORDER BY salary DESC) AS dns_rnk
    FROM Employee e
    INNER JOIN Department d
        ON e.departmentId = d.id
)

SELECT
    Department,
    Employee,
    Salary
FROM CTE
WHERE dns_rnk = 1;