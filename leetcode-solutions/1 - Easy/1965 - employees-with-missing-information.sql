/* Write a solution to report the IDs of all the employees with missing information. The information of an employee is missing if:
- The employee's name is missing, or
- The employee's salary is missing.

Return the result table ordered by employee_id in ascending order. */

/* Write your T-SQL query statement below */

SELECT
    CASE
        WHEN name IS NULL THEN s.employee_id
        WHEN salary IS NULL THEN e.employee_id
    END AS employee_id
FROM Employees e
FULL OUTER JOIN Salaries s
    ON e.employee_id = s.employee_id
WHERE name IS NULL OR salary IS NULL
ORDER BY employee_id;