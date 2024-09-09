# [App Click-through Rate (CTR) [Facebook SQL Interview Question]](https://datalemur.com/questions/click-through-rate)

## Table Of Contents
1. [Problem Statement]()
2. [Datasets used]()
3. [Solutions]()
4. [Result set]()

## Problem Statement

Assume you have an events table on Facebook app analytics. Write a query to calculate the click-through rate (CTR) for the app in 2022 and round the results to 2 decimal places.

Definition and note:

- Percentage of click-through rate (CTR) = 100.0 * Number of clicks / Number of impressions
- To avoid integer division, multiply the CTR by 100.0, not 100.

## Datasets used

```events``` Table:

|  Column Name  | Type          |
| ------------- | ------------- |
| app_id | integer |
| event_type |	string |
| timestamp |	datetime |

## Solutions

```sql
SELECT
    app_id,
    ROUND(100.0 * 
    SUM(CASE WHEN event_type = 'click' THEN 1 ELSE 0 END) / 
    SUM(CASE WHEN event_type = 'impression' THEN 1 ELSE 0 END), 2) AS ctr
FROM events
WHERE EXTRACT(year FROM timestamp) = '2022'
GROUP BY app_id;
```

## Result set

| app_id | ctr |
| ------ | --- |
| 123 | 66.67 |
| 234 |	33.33 |