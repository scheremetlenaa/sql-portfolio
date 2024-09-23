# [262. Trips and Users](https://leetcode.com/problems/trips-and-users/description/)

## Table Of Contents
1. [Problem Statement](#problem-statement)
2. [Datasets used](#datasets-used)
3. [Solutions](#solutions)
4. [Result set](#result-set)

## Problem Statement

The cancellation rate is computed by dividing the number of canceled (by client or driver) requests with unbanned users by the total number of requests with unbanned users on that day.

Write a solution to find the cancellation rate of requests with unbanned users (both client and driver must not be banned) each day between "2013-10-01" and "2013-10-03". Round Cancellation Rate to two decimal points.

Return the result table in any order.

## Datasets used

```Trips``` Table:

| Column Name | Type     |
| ----------- | -------- |
| id          | int      |
| client_id   | int      |
| driver_id   | int      |
| city_id     | int      |
| status      | enum     |
| request_at  | varchar  |     

id is the primary key (column with unique values) for this table.
The table holds all taxi trips. Each trip has a unique id, while client_id and driver_id are foreign keys to the users_id at the Users table.
Status is an ENUM (category) type of ('completed', 'cancelled_by_driver', 'cancelled_by_client').

```Users``` Table:

| Column Name | Type     |
| ----------- | -------- |
| users_id    | int      |
| banned      | enum     |
| role        | enum     |

users_id is the primary key (column with unique values) for this table.
The table holds all users. Each user has a unique users_id, and role is an ENUM type of ('client', 'driver', 'partner').
banned is an ENUM (category) type of ('Yes', 'No').

## Solutions

```sql
WITH CTE1 AS (
    SELECT
        client_id,
        driver_id,
        role,
        banned,
        status,
        request_at
    FROM Trips t
    INNER JOIN Users u
        ON t.client_id = u.users_id
    WHERE banned = 'No'
),

CTE2 AS (
    SELECT
        client_id,
        driver_id,
        status,
        request_at
    FROM CTE1
    INNER JOIN Users
        ON CTE1.driver_id = Users.users_id
    WHERE request_at BETWEEN '2013-10-01' AND '2013-10-03'
    AND Users.banned = 'No'
)

SELECT
    request_at AS Day,
    ROUND(SUM(CASE
        WHEN status LIKE 'cancelled_by_%' THEN 1
        ELSE 0
    END) * 1.0 / COUNT(status), 2) AS 'Cancellation Rate'
FROM CTE2
GROUP BY request_at
```

## Result set

| Day        | Cancellation Rate |
| ---------- | ----------------- |
| 2013-10-01 | 0.33              |
| 2013-10-02 | 0                 |
| 2013-10-03 | 0.5               |