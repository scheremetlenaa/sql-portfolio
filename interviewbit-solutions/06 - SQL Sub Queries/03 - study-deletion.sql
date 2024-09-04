-- Given a table STUDY, delete all the entries in the table where the AGE of the students lies between 19-22. Then print the new table.

/* YOUR QUERY GOES HERE
   Example: SELECT * FROM EMPLOYEE; 
*/

DELETE FROM STUDY
WHERE Age BETWEEN 19 AND 22;

SELECT * FROM STUDY;