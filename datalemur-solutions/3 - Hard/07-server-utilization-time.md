# [Server Utilization Time [Amazon SQL Interview Question]](https://datalemur.com/questions/total-utilization-time)

## Table Of Contents
1. [Problem Statement]()
2. [Datasets used]()
3. [Solutions]()
4. [Result set]()

## Problem Statement

Amazon Web Services (AWS) is powered by fleets of servers. Senior management has requested data-driven solutions to optimize server usage.

Write a query that calculates the total time that the fleet of servers was running. The output should be in units of full days.

Assumptions:

- Each server might start and stop several times.
- The total time in which the server fleet is running can be calculated as the sum of each server's uptime.

## Datasets used

```server_utilization``` Table:

|  Column Name  | Type          |
| ------------- | ------------- |
| server_id	| integer |
| status_time |	timestamp |
| session_status |	string |

## Solutions

```sql
WITH CTE AS (
    SELECT
        server_id,
        session_status,
        status_time AS start_time,
        LEAD(status_time) OVER(PARTITION BY server_id ORDER BY status_time) AS stop_time
    FROM server_utilization
)

SELECT
    DATE_PART('days', JUSTIFY_HOURS(SUM(stop_time - start_time))) AS total_uptime_days
FROM CTE
WHERE session_status = 'start'
AND stop_time IS NOT NULL;
```

## Result set

| total_uptime_days |
| ------------ |
| 26 |