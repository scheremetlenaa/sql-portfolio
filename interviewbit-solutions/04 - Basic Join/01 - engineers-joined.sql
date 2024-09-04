-- Given 2 tables ENGINEER and DATA, query the sum of Count of all the engineers whose Type is FrontEnd.

/* YOUR QUERY GOES HERE
   Example: SELECT * FROM EMPLOYEE; 
*/

SELECT
    SUM(Count) AS A
FROM ENGINEER e
INNER JOIN DATA d
    ON e.ID = d.ID
WHERE Type = 'FrontEnd';