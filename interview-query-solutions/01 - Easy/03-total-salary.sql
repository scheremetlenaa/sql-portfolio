-- Using the employees table, get the total salary of all employees.

SELECT
    SUM(salary) AS total_salary
FROM employees;