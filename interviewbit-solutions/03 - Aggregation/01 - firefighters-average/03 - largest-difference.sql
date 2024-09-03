-- Given a table FIREFIGHTERS, find the largest difference between the number of people saved by 2 firefighters.

/* YOUR QUERY GOES HERE
   Example: SELECT * FROM EMPLOYEE; 
*/

SELECT
    MAX(PeopleSaved) - MIN(PeopleSaved) AS A
FROM FIREFIGHTERS;