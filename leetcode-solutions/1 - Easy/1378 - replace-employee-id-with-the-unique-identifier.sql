-- Write a solution to show the unique ID of each user, If a user does not have a unique ID replace just show null.
-- Return the result table in any order.

/* Write your T-SQL query statement below */

SELECT
unique_id,
name
FROM Employees em
LEFT JOIN EmployeeUNI emu
    ON em.id = emu.id;