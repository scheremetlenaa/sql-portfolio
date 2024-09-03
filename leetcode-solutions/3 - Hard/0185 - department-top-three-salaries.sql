/* A company's executives are interested in seeing who earns the most money in each of the company's departments. 

A high earner in a department is an employee who has a salary in the top three unique salaries for that department.

Write a solution to find the employees who are high earners in each of the departments.

Return the result table in any order. */

/* Write your T-SQL query statement below */

WITH CTE1 AS (
    SELECT
        d.name AS Department,
        e.name AS Employee,
        salary
    FROM Employee e
    INNER JOIN Department d
        ON e.departmentId = d.id
),

CTE2 AS (
    SELECT
        Department,
        Employee,
        Salary,
        DENSE_RANK() OVER(PARTITION BY Department ORDER BY Salary DESC) AS dns_rnk
    FROM CTE1
)

SELECT
    Department,
    Employee,
    Salary
FROM CTE2
WHERE dns_rnk <= 3