-- Given a table STUDENT, query for all the Names with Class 1 and SubjectCount greater than 3.

/* YOUR QUERY GOES HERE
   Example: SELECT * FROM EMPLOYEE; 
*/

SELECT
    Name
FROM STUDENT
WHERE Class = 1
AND SubjectCount > 3;