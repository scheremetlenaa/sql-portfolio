-- Write a query to display the employee's name along with their department name and salary. 
-- In case of duplicates, sort the results of department name in ascending order, then by salary in descending order. 
-- If multiple employees have the same salary, then order them alphabetically.

SELECT
  department_name,
  name,
  salary
FROM (
  SELECT
    department_name,
    name,
    salary,
    DENSE_RANK() OVER (PARTITION BY department_name
                ORDER BY salary DESC) AS ranking
  FROM employee
  INNER JOIN department
    ON department.department_id = employee.department_id
) t1
WHERE ranking <= 3
ORDER BY department_name, salary DESC, name;