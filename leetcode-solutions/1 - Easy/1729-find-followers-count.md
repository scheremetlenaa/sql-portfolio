# [1729. Find Followers Count](https://leetcode.com/problems/find-followers-count/description/)

## Table Of Contents
1. [Problem Statement](#problem-statement)
2. [Datasets used](#datasets-used)
3. [Solutions](#solutions)
4. [Result set](#result-set)

## Problem Statement

Write a solution that will, for each user, return the number of followers.

Return the result table ordered by user_id in ascending order.

## Datasets used

```Followers``` Table:

| Column Name | Type |
| ----------- | ---- |
| user_id     | int  |
| follower_id | int  |

(user_id, follower_id) is the primary key (combination of columns with unique values) for this table.
This table contains the IDs of a user and a follower in a social media app where the follower follows the user.

## Solutions

```sql
SELECT
    user_id,
    COUNT(follower_id) AS followers_count
FROM Followers
GROUP BY user_id
ORDER BY user_id;
```

## Result set

| user_id | followers_count |
| ------- | --------------- |
| 0       | 1               |
| 1       | 1               |
| 2       | 2               |