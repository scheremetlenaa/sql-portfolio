-- identify all employees who earn more than their direct managers

SELECT
  emp.employee_id AS employee_id,
  emp.name AS employee_name
FROM employee mn
INNER JOIN employee emp
  ON mn.employee_id = emp.manager_id
WHERE emp.salary > mn.salary;