# [Patient Support Analysis (Part 1) [UnitedHealth SQL Interview Question]](https://datalemur.com/questions/frequent-callers)

## Table Of Contents
1. [Problem Statement]()
2. [Datasets used]()
3. [Solutions]()
4. [Result set]()

## Problem Statement

UnitedHealth Group (UHG) has a program called Advocate4Me, which allows policy holders (or, members) to call an advocate and receive support for their health care needs – whether that's claims and benefits support, drug coverage, pre- and post-authorisation, medical records, emergency assistance, or member portal services.

Write a query to find how many UHG policy holders made three, or more calls, assuming each call is identified by the ```case_id``` column.

## Datasets used

```callers``` Table:

|  Column Name  | Type          |
| ------------- | ------------- |
| policy_holder_id	| integer |
| case_id |	varchar |
| call_category |	varchar |
| call_date |	timestamp |
| call_duration_secs |	integer |

## Solutions

```sql
SELECT
    COUNT(*) AS policy_holder_count
FROM (
    SELECT
        policy_holder_id,
        COUNT(*) AS calls_count
    FROM callers
    GROUP BY policy_holder_id
    HAVING COUNT(*) >= 3
) t1;
```

## Result set

| policy_holder_count |
| ------------ |
| 38 |