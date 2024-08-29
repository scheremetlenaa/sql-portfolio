/* Write a solution to report the fraction of players that logged in again on the day after the day they first logged in, rounded to 2 decimal places.

In other words, you need to count the number of players that logged in for at least two consecutive days starting from their first login date, 
then divide that number by the total number of players. */

/* Write your T-SQL query statement below */

WITH CTE AS (
    SELECT
        player_id,
        event_date,
        games_played,
        DATEDIFF(DAY, LAG(event_date) OVER(PARTITION BY player_id ORDER BY event_date), event_date) AS days_btwn,
        RANK() OVER(PARTITION BY player_id ORDER BY event_date) AS rank
    FROM Activity
            )

SELECT
    ROUND(COUNT(DISTINCT player_id) * 1.0 / (SELECT COUNT(DISTINCT player_id) FROM Activity), 2) AS fraction
FROM CTE
WHERE days_btwn = 1
AND rank = 2; 