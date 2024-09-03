/* You are given a table ‘Students’ which consists of the student information of every student along with the marks that they obtained in a test out of 100. 

However there were students who were Absent for the test, their marks section would contain ‘Absent’ word. 

Help the teacher arrange the students first based on their marks and second based on their first name.

(You just have to output the names of the students). */

/* YOUR QUERY GOES HERE
   Example: SELECT * FROM EMPLOYEE; 
*/

UPDATE Students
SET Marks = NULL
WHERE Marks = 'Absent';

SELECT
   Name
FROM Students
ORDER BY Marks DESC, Name;