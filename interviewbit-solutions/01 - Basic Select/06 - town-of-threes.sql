-- Given a table TOWNS, query for all the Town Names and Population, such that the ID is a multiple of 3.

/* YOUR QUERY GOES HERE
   Example: SELECT * FROM EMPLOYEE; 
*/

SELECT
    TownName,
    Population
FROM TOWNS 
WHERE ID % 3 = 0;