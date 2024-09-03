/* You are given one table ‘Students’ which consists of Id,Name and Birthdate of students. 

Write an SQL query to find for each date the number of students having their birthday on that day and their names (seperated by commas). 

Also the Dates should be ordered in ascending order. */

/* YOUR QUERY GOES HERE
   Example: SELECT * FROM EMPLOYEE; 
*/

SELECT
    GROUP_CONCAT(Name) AS Names
FROM Students
GROUP BY BirthDate
ORDER BY BirthDate;