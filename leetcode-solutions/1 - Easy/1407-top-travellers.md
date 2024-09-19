# [1407. Top Travellers](https://leetcode.com/problems/top-travellers/description/)

## Table Of Contents
1. [Problem Statement]()
2. [Datasets used]()
3. [Solutions]()
4. [Result set]()

## Problem Statement

Write a solution to report the distance traveled by each user.

Return the result table ordered by travelled_distance in descending order, if two or more users traveled the same distance, order them by their name in ascending order.

## Datasets used

```Users``` Table:

| Column Name   | Type    |
| ------------- | ------- |
| id            | int     |
| name          | varchar |

id is the column with unique values for this table.
name is the name of the user.

```Rides``` Table:

| Column Name   | Type    |
| ------------- | ------- |
| id            | int     |
| user_id       | int     |
| distance      | int     |

id is the column with unique values for this table.
user_id is the id of the user who traveled the distance "distance".

## Solutions

```sql
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
```

## Result set

| name     | travelled_distance |
| -------- | ------------------ |
| Elvis    | 450                |
| Lee      | 450                |
| Bob      | 317                |
| Jonathan | 312                |
| Alex     | 222                |
| Alice    | 120                |
| Donald   | 0                  |