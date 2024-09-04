-- Given 2 tables ‘Students’ and ‘Departments’. Write an SQL query to find the students who has the Lowest GPA in each of the departments. 

/* YOUR QUERY GOES HERE
   Example: SELECT * FROM EMPLOYEE; 
*/

WITH CTE AS (
    SELECT
        D.DepartmentName,
        S.Name,
        S.GPA,
        RANK() OVER(PARTITION BY D.DepartmentName ORDER BY S.GPA) AS rnk
    FROM Students S
    LEFT JOIN DEPARTMENTS D
        ON S.DepartmentId = D.DepartmentId
)

SELECT
    CONCAT(DepartmentName, ',', Name, ',', GPA) AS A
FROM CTE
WHERE rnk = 1;