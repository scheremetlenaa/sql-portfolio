/* Julia asked her students to create some coding challenges. 

Write a query to print the hacker_id, name, and the total number of challenges created by each student. 

Sort your results by the total number of challenges in descending order. 

If more than one student created the same number of challenges, then sort the result by hacker_id. 

If more than one student created the same number of challenges and the count is less than the maximum number of challenges created, 
then exclude those students from the result. */

WITH CTE AS (
    SELECT
        h.hacker_id,
        name,
        COUNT(challenge_id) AS cnt
    FROM Hackers h
    INNER JOIN Challenges c
        ON h.hacker_id = c.hacker_id
    GROUP BY h.hacker_id, name
)

SELECT
    hacker_id,
    name,
    cnt
FROM CTE
WHERE cnt IN (SELECT cnt FROM CTE GROUP BY cnt HAVING COUNT(*) = 1)
OR cnt = (SELECT MAX(cnt) FROM CTE)
ORDER BY cnt DESC, hacker_id