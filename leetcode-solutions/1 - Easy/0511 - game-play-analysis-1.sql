-- Write a solution to find the first login date for each player.
-- Return the result table in any order.

SELECT
player_id,
event_date AS first_login
FROM (
    SELECT
    player_id,
    event_date,
    ROW_NUMBER() OVER (PARTITION BY player_id ORDER BY event_date) AS rw_nm
    FROM Activity
) t1
WHERE rw_nm = 1;