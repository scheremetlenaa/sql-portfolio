# [Active User Retention [Facebook SQL Interview Question]](https://datalemur.com/questions/user-retention)

## Table Of Contents
1. [Problem Statement](#problem-statement)
2. [Datasets used](#datasets-used)
3. [Solutions](#solutions)
4. [Result set](#result-set)

## Problem Statement

Assume you're given a table containing information on Facebook user actions. Write a query to obtain number of monthly active users (MAUs) in July 2022, including the month in numerical format "1, 2, 3".

Hint:

- An active user is defined as a user who has performed actions such as 'sign-in', 'like', or 'comment' in both the current month and the previous month.

## Datasets used

```user_actions``` Table:

|  Column Name  | Type          |
| ------------- | ------------- |
| user_id	| integer |
| event_id |	integer |
| event_type |	string ("sign-in, "like", "comment") |
| event_date |	datetime |

## Solutions

```sql
SELECT 
    EXTRACT(MONTH from event_date) AS month,
    COUNT(DISTINCT user_id) AS monthly_active_users
FROM user_actions
WHERE EXTRACT(MONTH from event_date) = 7
AND user_id IN 
(
    SELECT user_id 
    FROM user_actions 
    WHERE EXTRACT(MONTH from event_date) = 6
)
GROUP BY EXTRACT(MONTH from event_date)
ORDER BY month, monthly_active_users;
```

## Result set

| month | monthly_active_users |
| ----- | -------------------- |
| 7 | 2 |