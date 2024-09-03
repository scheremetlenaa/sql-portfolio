/* Given a table Students. Write an SQL qurey to find for all students the marks which are immediately greater than the student’s marks . 

The output should have 1 column ‘Next’ and should contain the marks which are immediately greater than the student’s marks for each student which are Sorted by their Name. */

/* YOUR QUERY GOES HERE
   Example: SELECT * FROM EMPLOYEE; 
*/

SELECT 
    LEAD(Marks) OVER (ORDER BY Marks) AS Next
FROM Students
ORDER BY Name;