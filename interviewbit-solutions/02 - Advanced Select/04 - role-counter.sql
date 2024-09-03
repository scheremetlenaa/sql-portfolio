/* Given a table GAMERS, query for the count of each Role of the Players in the given table. 

Sort the result based on ascending order of the count and print the result in the following format:

[Role] Count is [Role_Count] */

/* YOUR QUERY GOES HERE
   Example: SELECT * FROM EMPLOYEE; 
*/

SELECT
    CONCAT(Role, ' Count is ', COUNT(*)) AS COUNT
FROM GAMERS
GROUP BY Role
ORDER BY COUNT(*);