-- Given a table FIREFIGHTERS, query the average of all the people saved by the Firefighters whose CountryCode is PM.

/* YOUR QUERY GOES HERE
   Example: SELECT * FROM EMPLOYEE; 
*/

SELECT
    AVG(PeopleSaved)
FROM FIREFIGHTERS 
WHERE CountryCode = 'PM';