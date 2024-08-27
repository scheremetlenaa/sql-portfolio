/* Write a solution to find the second highest salary from the Employee table. If there is no second highest salary, return null */

/* Write your T-SQL query statement below */

SELECT
    MAX(salary) AS SecondHighestSalary
FROM (
    SELECT
        id,
        salary,
        DENSE_RANK() OVER(ORDER BY salary DESC) AS rnk
    FROM Employee
    ) t1
WHERE rnk = 2;