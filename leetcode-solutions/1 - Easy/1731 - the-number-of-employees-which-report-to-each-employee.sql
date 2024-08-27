/* For this problem, we will consider a manager an employee who has at least 1 other employee reporting to them.

Write a solution to report the ids and the names of all managers, the number of employees who report directly to them, 
and the average age of the reports rounded to the nearest integer.

Return the result table ordered by employee_id. */

/* Write your T-SQL query statement below */

SELECT
    e1.employee_id,
    e1.name,
    COUNT(e2.reports_to) AS reports_count,
    ROUND(AVG(e2.age * 1.00), 0) AS average_age
FROM Employees e1
LEFT JOIN Employees e2
    ON e1.employee_id = e2.reports_to   
WHERE e2.reports_to IS NOT NULL
GROUP BY e1.employee_id, e1.name
ORDER BY e1.employee_id;