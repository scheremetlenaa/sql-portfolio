-- determine the second highest salary among all employees

SELECT
  MAX(salary) AS second_max_salary
FROM employee
WHERE salary < (
  SELECT
    MAX(salary) AS max_salary
  FROM employee
);