-- Write a solution to find all the pairs (actor_id, director_id) where the actor has cooperated with the director at least three times.
-- Return the result table in any order.

/* Write your T-SQL query statement below */

SELECT actor_id, director_id
FROM ActorDirector
GROUP BY actor_id, director_id
HAVING COUNT(*) >= 3;