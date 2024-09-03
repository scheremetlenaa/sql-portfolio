-- Given the ‘STUDENTS’ table. Write an SQL query to find the 5’th highest marks in the students table.

/* YOUR QUERY GOES HERE
   Example: SELECT * FROM EMPLOYEE; 
*/

SELECT 
    MARKS
FROM (SELECT MARKS FROM STUDENTS ORDER BY MARKS DESC LIMIT 5) t1
ORDER BY MARKS
LIMIT 1;