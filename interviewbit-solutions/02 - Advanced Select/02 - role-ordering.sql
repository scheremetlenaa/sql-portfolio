/* Given a table GAMERS, pivot the table in such a manner that the Player is sorted in alphabetical order and displayed under its corresponding Role. 

Print NULL if no more players are associated with the corresponding role. The roles are Healer, Attacker, Defender, Tactician. */

/* YOUR QUERY GOES HERE
   Example: SELECT * FROM EMPLOYEE; 
*/

SELECT
    MAX(CASE WHEN Role = 'Healer' THEN Player ELSE NULL END) AS "MIN(Healer)",
    MAX(CASE WHEN Role = 'Attacker' THEN Player ELSE NULL END) AS "MIN(Attacker)"   ,
    MAX(CASE WHEN Role = 'Defender' THEN Player ELSE NULL END) AS "MIN(Defender)",
    MAX(CASE WHEN Role = 'Tactician' THEN Player ELSE NULL END) AS "MIN(Tactician)"

FROM (
    SELECT
        Player,
        Role,
        (SELECT COUNT(*) FROM GAMERS g2 WHERE g2.Role = g1.Role AND g2.Player <= g1.Player) AS row_num
    FROM GAMERS g1
) AS t
GROUP BY row_num;