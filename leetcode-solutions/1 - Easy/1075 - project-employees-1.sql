-- Write an SQL query that reports the average experience years of all the employees for each project, rounded to 2 digits.
-- Return the result table in any order.

/* Write your T-SQL query statement below */

SELECT
project_id,
ROUND(AVG(CAST(experience_years AS DECIMAL)), 2) AS average_years
FROM Project p
INNER JOIN Employee e
    ON p.employee_id = e.employee_id
GROUP BY project_id;