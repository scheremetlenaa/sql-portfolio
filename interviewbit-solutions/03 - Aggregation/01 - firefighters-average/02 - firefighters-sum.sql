-- Given a table FIREFIGHTERS, query the sum of all the people saved by the Firefighters whose CountryCode is PG.

/* YOUR QUERY GOES HERE
   Example: SELECT * FROM EMPLOYEE; 
*/

SELECT
    SUM(PeopleSaved)
FROM FIREFIGHTERS 
WHERE CountryCode = 'PG';