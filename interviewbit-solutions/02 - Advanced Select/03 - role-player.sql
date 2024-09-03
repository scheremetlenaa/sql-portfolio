/* Given a table GAMERS, query for a list sorted by alphabetical order of all the Players in the table, 

followed by the First letter of the Role each player plays in the game enclosed in braces (). Example: Ram(H) */

/* YOUR QUERY GOES HERE
   Example: SELECT * FROM EMPLOYEE; 
*/

SELECT
    CONCAT(Player, '(', LEFT(Role, 1), ')') AS N
FROM GAMERS
ORDER BY N;