/* You are given 3 tables namely ‘Students’ , ‘Departments’ and ‘Jobs’.

Write an SQL query to find sum of Distinct salaries obtained by students from ‘CSE’ department. The output should be sorted by the Department names.

Note: There might be students who have got multiple job offers. */

/* YOUR QUERY GOES HERE
   Example: SELECT * FROM EMPLOYEE; 
*/

SELECT
    SUM(DISTINCT Salary) AS Salary
FROM Students s
INNER JOIN Departments d
    ON s.DepartmentId = d.DepartmentId
    AND DepartmentName = 'CSE'
INNER JOIN Jobs j
    ON s.Id = j.Id;