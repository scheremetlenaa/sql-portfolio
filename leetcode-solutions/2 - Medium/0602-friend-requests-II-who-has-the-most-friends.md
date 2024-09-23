# [602. Friend Requests II: Who Has the Most Friends](https://leetcode.com/problems/friend-requests-ii-who-has-the-most-friends/description/)

## Table Of Contents
1. [Problem Statement](#problem-statement)
2. [Datasets used](#datasets-used)
3. [Solutions](#solutions)
4. [Result set](#result-set)

## Problem Statement

Write a solution to find the people who have the most friends and the most friends number.

The test cases are generated so that only one person has the most friends.

## Datasets used

```RequestAccepted``` Table:

| Column Name    | Type    |
| -------------- | ------- |
| requester_id   | int     |
| accepter_id    | int     |
| accept_date    | date    |

(requester_id, accepter_id) is the primary key (combination of columns with unique values) for this table.
This table contains the ID of the user who sent the request, the ID of the user who received the request, and the date when the request was accepted.

## Solutions

```sql
WITH CTE AS (
    SELECT
        requester_id
    FROM RequestAccepted
    UNION ALL
    SELECT
        accepter_id
    FROM RequestAccepted
)

SELECT TOP 1 requester_id AS id, COUNT(*) AS num
FROM CTE
GROUP BY requester_id
ORDER BY num DESC;
```

## Result set

| id | num |
| -- | --- |
| 3  | 3   |