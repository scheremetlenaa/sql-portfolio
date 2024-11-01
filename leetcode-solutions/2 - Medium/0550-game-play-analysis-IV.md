# [550. Game Play Analysis IV](https://leetcode.com/problems/game-play-analysis-iv/description/)

## Table Of Contents
1. [Problem Statement](#problem-statement)
2. [Datasets used](#datasets-used)
3. [Solutions](#solutions)
4. [Result set](#result-set)

## Problem Statement

Write a solution to report the fraction of players that logged in again on the day after the day they first logged in, rounded to 2 decimal places. In other words, you need to count the number of players that logged in for at least two consecutive days starting from their first login date, then divide that number by the total number of players.

## Datasets used

```Activity``` Table:

| Column Name  | Type    |
| ------------ | ------- |
| player_id    | int     |
| device_id    | int     |
| event_date   | date    |
| games_played | int     |

(player_id, event_date) is the primary key (combination of columns with unique values) of this table.
This table shows the activity of players of some games.
Each row is a record of a player who logged in and played a number of games (possibly 0) before logging out on someday using some device.

## Solutions

```sql
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
```

## Result set

| fraction |
| -------- |
| 0.33     |