/* Employees can belong to multiple departments. When the employee joins other departments, they need to decide which department is their primary department. 
Note that when an employee belongs to only one department, their primary column is 'N'.

Write a solution to report all the employees with their primary department. For employees who belong to one department, report their only department.

Return the result table in any order. */

/* Write your T-SQL query statement below */

WITH CTE AS (
    SELECT
        *,
        CASE
            WHEN COUNT(employee_id) OVER (PARTITION BY employee_id) = 1 AND primary_flag = 'N' 
            THEN department_id
            WHEN COUNT(employee_id) OVER (PARTITION BY employee_id) > 1 AND primary_flag = 'Y' 
            THEN department_id
            ELSE 0
        END AS dpt
    FROM Employee
)

SELECT
    employee_id,
    MAX(dpt) AS department_id
FROM CTE
GROUP BY employee_id;