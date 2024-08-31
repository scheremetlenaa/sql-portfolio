/* Julia just finished conducting a coding contest, and she needs your help assembling the leaderboard! 

Write a query to print the respective hacker_id and name of hackers who achieved full scores for more than one challenge. 

Order your output in descending order by the total number of challenges in which the hacker earned a full score. 

If more than one hacker received full scores in same number of challenges, then sort them by ascending hacker_id. */

WITH CTE AS (
    SELECT
        h.hacker_id,
        h.name,
        c.challenge_id,
        d.difficulty_level,
        d.score AS highest_lvl_score,
        s.score AS hacker_score
    FROM Hackers h
    INNER JOIN Submissions s
        ON h.hacker_id = s.hacker_id
    INNER JOIN Challenges c
        ON s.challenge_id = c.challenge_id
    INNER JOIN Difficulty d
        ON c.difficulty_level = d.difficulty_level
    WHERE d.score = s.score
)

SELECT
    hacker_id,
    name
FROM CTE
GROUP BY hacker_id, name
HAVING COUNT(*) > 1
ORDER BY COUNT(*) DESC, hacker_id;