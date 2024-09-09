# [Sending vs. Opening Snaps [Snapchat SQL Interview Question]](https://datalemur.com/questions/time-spent-snaps)

## Table Of Contents
1. [Problem Statement]()
2. [Datasets used]()
3. [Solutions]()
4. [Result set]()

## Problem Statement

Assume you're given tables with information on Snapchat users, including their ages and time spent sending and opening snaps.

Write a query to obtain a breakdown of the time spent sending vs. opening snaps as a percentage of total time spent on these activities grouped by age group. Round the percentage to 2 decimal places in the output.

Notes:

- Calculate the following percentages:
    + time spent sending / (Time spent sending + Time spent opening)
    + Time spent opening / (Time spent sending + Time spent opening)
- To avoid integer division in percentages, multiply by 100.0 and not 100.

## Datasets used

```activities``` Table:

|  Column Name  | Type          |
| ------------- | ------------- |
| activity_id |	integer |
| user_id |	integer |
| activity_type |	string ('send', 'open', 'chat') |
| time_spent |	float |
| activity_date |	datetime |

```age_breakdown``` Table:

| Column Name | Type |
| ----------- | ---- |
| user_id |	integer |
| age_bucket |	string ('21-25', '26-30', '31-25') |

## Solutions

```sql
SELECT
    age_bucket,
    ROUND(100.0 * SUM(send), 2) AS send_perc,
    ROUND(100.0 * SUM(open), 2) AS open_perc 
FROM (
    SELECT
        age_bucket,
        CASE
            WHEN activity_type = 'open' THEN sum_by_activity / total_sum
            ELSE 0
        END AS open,
        CASE
            WHEN activity_type = 'send' THEN sum_by_activity / total_sum
            ELSE 0
        END AS send
    FROM (
        SELECT
            age_bucket,
            activity_type,
            SUM(time_spent) OVER(PARTITION BY age_bucket, activity_type) AS sum_by_activity,
            SUM(time_spent) OVER(PARTITION BY age_bucket) AS total_sum
        FROM activities
        INNER JOIN age_breakdown
            ON activities.user_id = age_breakdown.user_id
            AND activity_type IN ('send', 'open')
    ) t1
    GROUP BY age_bucket, 
    CASE
        WHEN activity_type = 'open' THEN sum_by_activity / total_sum
        ELSE 0
    END,
    CASE
        WHEN activity_type = 'send' THEN sum_by_activity / total_sum
    ELSE 0
    END
) t2
GROUP BY age_bucket;
```

## Result set

| age_bucket | send_perc | open_perc |
| ---------- | --------- | --------- |
| 21-25 |	54.31 |	45.69 |
| 26-30 |	82.26 |	17.74 |
| 31-35 |	37.84 |	62.16 |