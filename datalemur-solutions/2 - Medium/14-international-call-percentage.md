# [International Call Percentage [Verizon SQL Interview Question]](https://datalemur.com/questions/international-call-percentage)

## Table Of Contents
1. [Problem Statement]()
2. [Datasets used]()
3. [Solutions]()
4. [Result set]()

## Problem Statement

A phone call is considered an international call when the person calling is in a different country than the person receiving the call.

What percentage of phone calls are international? Round the result to 1 decimal.

Assumption:

- The ```caller_id``` in ```phone_info``` table refers to both the caller and receiver.

## Datasets used

```phone_calls``` Table:

|  Column Name  | Type          |
| ------------- | ------------- |
| caller_id	| integer |
| receiver_id |	integer |
| call_time |	timestamp |

```phone_info``` Table:

| Column Name | Type |
| ----------- | ---- |
| caller_id |	integer |
| country_id |	integer |
| network |	integer |
| phone_number |	string |

## Solutions

```sql
SELECT
    ROUND(100.0 * SUM(CASE
    WHEN caller_country != receiver_country THEN 1
    ELSE 0
    END) / COUNT(*), 1) AS international_calls_pct
FROM (
    SELECT
        caller.country_id AS caller_country,
        receiver.country_id AS receiver_country
    FROM phone_calls
    LEFT JOIN phone_info caller
        ON phone_calls.caller_id = caller.caller_id
    LEFT JOIN phone_info receiver
        ON phone_calls.receiver_id = receiver.caller_id
) t1;
```

## Result set

| international_calls_pct |
| ------------ |
| 54.5 |