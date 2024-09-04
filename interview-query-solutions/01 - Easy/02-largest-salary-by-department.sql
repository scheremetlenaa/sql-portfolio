-- Given a table called employees, get the largest salary of any employee by department

SELECT
    department,
    MAX(salary) AS largest_salary
FROM employees
GROUP BY department;