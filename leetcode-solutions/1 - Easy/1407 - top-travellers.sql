-- Write a solution to report the distance traveled by each user.
-- Return the result table ordered by travelled_distance in descending order.
-- If two or more users traveled the same distance, order them by their name in ascending order.

/* Write your T-SQL query statement below */

WITH CTE AS (
    SELECT
    u.id,
    name,
    ISNULL(SUM(distance), 0) AS travelled_distance
    FROM Users u
    LEFT JOIN Rides r
        ON u.id = r.user_id
    GROUP BY u.id, name
)

SELECT
name,
travelled_distance
FROM CTE
ORDER BY travelled_distance DESC, name;