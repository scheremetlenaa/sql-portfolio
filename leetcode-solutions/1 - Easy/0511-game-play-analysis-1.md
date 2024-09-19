# [511. Game Play Analysis I](https://leetcode.com/problems/game-play-analysis-i/description/)

## Table Of Contents
1. [Problem Statement]()
2. [Datasets used]()
3. [Solutions]()
4. [Result set]()

## Problem Statement

Write a solution to find the first login date for each player.

Return the result table in any order.

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
```

## Result set

| player_id | first_login |
| --------- | ----------- |
| 1         | 2016-03-01  |
| 2         | 2017-06-25  |
| 3         | 2016-03-02  |