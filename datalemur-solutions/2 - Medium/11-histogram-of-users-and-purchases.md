# [Histogram of Users and Purchases [Walmart SQL Interview Question]](https://datalemur.com/questions/histogram-users-purchases)

## Table Of Contents
1. [Problem Statement](#problem-statement)
2. [Datasets used](#datasets-used)
3. [Solutions](#solutions)
4. [Result set](#result-set)

## Problem Statement

Assume you're given a table on Walmart user transactions. Based on their most recent transaction date, write a query that retrieve the users along with the number of products they bought.

Output the user's most recent transaction date, user ID, and the number of products, sorted in chronological order by the transaction date.

## Datasets used

```user_transactions``` Table:

|  Column Name  | Type          |
| ------------- | ------------- |
| product_id | integer |
| user_id |	integer |
| spend |	decimal |
| transaction_date |	timestamp |

## Solutions

```sql
SELECT
    transaction_date,
    user_id,
    COUNT(product_id) AS purchase_count
FROM (
    SELECT
        transaction_date,
        user_id,
        product_id,
        RANK() OVER(PARTITION BY user_id ORDER BY transaction_date DESC) AS transaction_rank
    FROM user_transactions
) t1
WHERE transaction_rank = 1
GROUP BY user_id, transaction_date
ORDER BY transaction_date;
```

## Result set

| transaction_date | user_id | purchase_count |
| ---------------- | ------- | -------------- |
| 07/11/2022 10:00:00 |	123 |	1 |
| 07/12/2022 10:00:00 |	115 |	1 |
| 07/12/2022 10:00:00 | 159 |	2 |