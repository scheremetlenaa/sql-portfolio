# [User's Third Transaction [Uber SQL Interview Question]](https://datalemur.com/questions/sql-third-transaction)

## Table Of Contents
1. [Problem Statement](#problem-statement)
2. [Datasets used](#datasets-used)
3. [Solutions](#solutions)
4. [Result set](#result-set)

## Problem Statement

Assume you are given the table below on Uber transactions made by users. Write a query to obtain the third transaction of every user. Output the user id, spend and transaction date.

## Datasets used

```transactions``` Table:

|  Column Name  | Type          |
| ------------- | ------------- |
| user_id |	integer |
| spend |	decimal |
| transaction_date |	timestamp |

## Solutions

```sql
SELECT
    user_id,
    spend,
    transaction_date
FROM (
    SELECT
        user_id,
        spend,
        transaction_date,
        ROW_NUMBER() OVER(PARTITION BY user_id ORDER BY transaction_date) AS rn 
    FROM transactions
) t1
WHERE rn = 3;
```

## Result set

| user_id | spend | transaction_date |
| ------- | ----- | ---------------- |
| 111	| 89.60 |	02/05/2022 12:00:00 |
| 121 |	67.90 |	04/03/2022 12:00:00 |
| 263 |	100.00 |	07/12/2022 12:00:00 |