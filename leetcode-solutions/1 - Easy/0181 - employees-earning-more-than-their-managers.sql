-- Write a solution to find the employees who earn more than their managers.
-- Return the result table in any order.

SELECT e.name AS Employee
FROM Employee m
INNER JOIN Employee e
    ON m.id = e.managerId
    WHERE e.salary > m.salary