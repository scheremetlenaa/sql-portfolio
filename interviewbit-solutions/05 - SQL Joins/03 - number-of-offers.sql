/* Given 2 tables ‘Students’ and ‘Jobs’, write an SQL query to find for every student the number of offers they got in the month of November. 

The output should contain 1 coloumn by the name ‘Job_Offers’ which should contain the number of jobs received by each of the student in the month of November. 

Also it should be sorted by the Id of the students. */

/* YOUR QUERY GOES HERE
   Example: SELECT * FROM EMPLOYEE; 
*/

SELECT 
    COUNT(IF(MONTH(j.Date) = 11, j.id, NULL)) AS Job_Offers 
FROM Students s
LEFT JOIN Jobs j on 
    s.Id = j.Id
GROUP BY s.id
ORDER BY s.Id;