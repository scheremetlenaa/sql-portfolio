-- Given a table PLACES, count the number of Countries which end with a vowel.

/* YOUR QUERY GOES HERE
   Example: SELECT * FROM EMPLOYEE; 
*/

SELECT
    COUNT(Country)
FROM PLACES
WHERE Country REGEXP '[aeiou]$';