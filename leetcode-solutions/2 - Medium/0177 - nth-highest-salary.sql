/* Write a solution to find the nth highest salary from the Employee table. If there is no nth highest salary, return null. */

CREATE FUNCTION getNthHighestSalary(@N INT) RETURNS INT AS
BEGIN
    RETURN (
            SELECT
                MAX(salary)
            FROM (
                SELECT
                    id,
                    salary,
                    DENSE_RANK() OVER(ORDER BY salary DESC) AS rnk
                FROM Employee
                ) t1
            WHERE rnk = @N
    )
END