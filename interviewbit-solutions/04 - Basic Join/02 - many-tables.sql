-- Given 2 tables ENGINEER and DATA, query for the total count of each Type in the ENGINEER table. Print the result in alphabetical order of the Type.

/* YOUR QUERY GOES HERE
   Example: SELECT * FROM EMPLOYEE; 
*/

SELECT
    SUM(Count) AS A
FROM ENGINEER e
INNER JOIN DATA d
    ON e.ID = d.ID
GROUP BY Type;