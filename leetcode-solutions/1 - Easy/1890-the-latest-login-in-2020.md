# [1890. The Latest Login in 2020](https://leetcode.com/problems/the-latest-login-in-2020/description/)

## Table Of Contents
1. [Problem Statement]()
2. [Datasets used]()
3. [Solutions]()
4. [Result set]()

## Problem Statement

Write a solution to report the latest login for all users in the year 2020. Do not include the users who did not login in 2020.

Return the result table in any order.

## Datasets used

```Logins``` Table:

| Column Name    | Type     |
| -------------- | -------- |
| user_id        | int      |
| time_stamp     | datetime |

(user_id, time_stamp) is the primary key (combination of columns with unique values) for this table.
Each row contains information about the login time for the user with ID user_id.

## Solutions

```sql
SELECT
    user_id,
    MAX(time_stamp) as last_stamp
FROM Logins
WHERE YEAR(time_stamp) = 2020
GROUP BY user_id;
```

## Result set

| user_id | last_stamp          |
| ------- | ------------------- |
| 2       | 2020-01-16 02:49:50 |
| 6       | 2020-06-30 15:06:07 |
| 8       | 2020-12-30 00:46:50 |