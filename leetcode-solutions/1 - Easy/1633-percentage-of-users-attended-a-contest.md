# [1633. Percentage of Users Attended a Contest](https://leetcode.com/problems/percentage-of-users-attended-a-contest/description/)

## Table Of Contents
1. [Problem Statement](#problem-statement)
2. [Datasets used](#datasets-used)
3. [Solutions](#solutions)
4. [Result set](#result-set)

## Problem Statement

Write a solution to find the percentage of the users registered in each contest rounded to two decimals.

Return the result table ordered by percentage in descending order. In case of a tie, order it by contest_id in ascending order.

## Datasets used

```Users``` Table:

| Column Name | Type    |
| ----------- | ------- |
| user_id     | int     |
| user_name   | varchar |

user_id is the primary key (column with unique values) for this table.
Each row of this table contains the name and the id of a user.

```Register``` Table:

| Column Name | Type    |
| ----------- | ------- |
| contest_id  | int     |
| user_id     | int     |

(contest_id, user_id) is the primary key (combination of columns with unique values) for this table.
Each row of this table contains the id of a user and the contest they registered into.

## Solutions

```sql
SELECT
    contest_id,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(user_id) FROM Users), 2) AS percentage
FROM Register r
INNER JOIN Users u
    ON r.user_id = u.user_id
GROUP BY contest_id
ORDER BY percentage DESC, contest_id ASC;
```

## Result set

| contest_id | percentage |
| ---------- | ---------- |
| 208        | 100        |
| 209        | 100        |
| 210        | 100        |
| 215        | 66.67      |
| 207        | 33.33      |