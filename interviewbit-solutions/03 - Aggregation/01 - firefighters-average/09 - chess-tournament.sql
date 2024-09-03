/* A chess tournament is being held which consists of several matches between a player and a computer. 

After every match one player is declared as the winner.

You are given two tables, One table consists of the players that will be playing the tournament while the other table consists of the matches that will be played in the tournament and its Result. 

The Result would be 1 if the player won the match, 0 otherwise. You have to output the names of the players who have won atleast one match and lost atmost one match. */

/* YOUR QUERY GOES HERE
   Example: SELECT * FROM EMPLOYEE; 
*/

SELECT
    p.Name
FROM Players p
INNER JOIN Matches m
    ON p.Id = m.Id
GROUP BY p.Id
HAVING SUM(m.Result) >= 1
AND COUNT(m.Result) - SUM(m.Result) <= 1;