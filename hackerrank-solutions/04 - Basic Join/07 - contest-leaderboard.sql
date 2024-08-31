/* The total score of a hacker is the sum of their maximum scores for all of the challenges. 

Write a query to print the hacker_id, name, and total score of the hackers ordered by the descending score. 

If more than one hacker achieved the same total score, then sort the result by ascending hacker_id. 

Exclude all hackers with a total score of 0 from your result. */

WITH CTE AS (
    SELECT
        h.hacker_id,
        s.challenge_id,
        name,
        MAX(score) AS max_score
    FROM Hackers h
    INNER JOIN Submissions s
        ON h.hacker_id = s.hacker_id
    GROUP BY h.hacker_id, s.challenge_id, name
)

SELECT
    hacker_id,
    name,
    SUM(max_score) AS total_score
FROM CTE
GROUP BY hacker_id, name
HAVING SUM(max_score) > 0
ORDER BY total_score DESC, hacker_id;