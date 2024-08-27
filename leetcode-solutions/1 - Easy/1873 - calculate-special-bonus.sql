/* Write a solution to calculate the bonus of each employee. 
The bonus of an employee is 100% of their salary if the ID of the employee is an odd number and the employee's name does not start with the character 'M'. 
The bonus of an employee is 0 otherwise.

Return the result table ordered by employee_id. */

/* Write your T-SQL query statement below */

SELECT
    employee_id,
    CASE
        WHEN employee_id % 2 = 0 OR LEFT(name, 1) = 'M' THEN 0
        ELSE salary
    END AS bonus
FROM Employees
ORDER BY employee_id;