/* You are given 3 tables namely ‘Students’ , ‘Departments’ and ‘Jobs’.

Write an SQL query to find for each student their name and the date of the job offer. 

The output should be sorted by Department Names. 

Note that there might be students who did not receive a single offer, in such cases you should not include them in the output table. */

/* YOUR QUERY GOES HERE
   Example: SELECT * FROM EMPLOYEE; 
*/

SELECT
    CONCAT(s.Name, ',', j.Date) AS Offers
FROM Students s
INNER JOIN Jobs j
    ON s.Id = j.Id
INNER JOIN Departments d
    ON s.DepartmentId = d.DepartmentId
ORDER BY DepartmentName;