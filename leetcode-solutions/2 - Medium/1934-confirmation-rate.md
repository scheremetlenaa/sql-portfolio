# [1934. Confirmation Rate](https://leetcode.com/problems/confirmation-rate/description/)

## Table Of Contents
1. [Problem Statement](#problem-statement)
2. [Datasets used](#datasets-used)
3. [Solutions](#solutions)
4. [Result set](#result-set)

## Problem Statement

The confirmation rate of a user is the number of 'confirmed' messages divided by the total number of requested confirmation messages. The confirmation rate of a user that did not request any confirmation messages is 0. Round the confirmation rate to two decimal places.

Write a solution to find the confirmation rate of each user.

Return the result table in any order.

## Datasets used

```Signups``` Table:

| Column Name    | Type     |
| -------------- | -------- |
| user_id        | int      |
| time_stamp     | datetime |

user_id is the column of unique values for this table.
Each row contains information about the signup time for the user with ID user_id.

```Confirmations``` Table:

| Column Name    | Type     |
| -------------- | -------- |
| user_id        | int      |
| time_stamp     | datetime |
| action         | ENUM     |

(user_id, time_stamp) is the primary key (combination of columns with unique values) for this table.
user_id is a foreign key (reference column) to the Signups table.
action is an ENUM (category) of the type ('confirmed', 'timeout')
Each row of this table indicates that the user with ID user_id requested a confirmation message at time_stamp and that confirmation message was either confirmed ('confirmed') or expired without confirming ('timeout').

## Solutions

```sql
SELECT
    s.user_id,
    ROUND(SUM(CASE
        WHEN action = 'confirmed' THEN 1
        ELSE 0
    END) * 1.00 / COUNT(*), 2) AS confirmation_rate 
FROM Signups s
LEFT JOIN Confirmations c
    ON s.user_id = c.user_id
GROUP BY s.user_id
```

## Result set

| user_id | confirmation_rate |
| ------- | ----------------- |
| 2       | 0.5               |
| 3       | 0                 |
| 6       | 0                 |
| 7       | 1                 |