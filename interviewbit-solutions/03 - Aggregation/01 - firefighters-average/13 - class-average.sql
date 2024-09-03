/* You are given a table ‘Students’ which consists of the marks that students from different classes obtained in the final exam. 

Write an SQL query to find for each departments the number of students who managed to score above total average (average considering students of all classes) . 

The output should be sorted by ClassId . */

/* YOUR QUERY GOES HERE
   Example: SELECT * FROM EMPLOYEE; 
*/

SELECT
    COUNT(*) AS A
FROM Students
WHERE Marks > (SELECT AVG(Marks) FROM Students)
GROUP BY ClassId;