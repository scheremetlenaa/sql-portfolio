# [Repeated Payments [Stripe SQL Interview Question]](https://datalemur.com/questions/repeated-payments)

## Table Of Contents
1. [Problem Statement](#problem-statement)
2. [Datasets used](#datasets-used)
3. [Solutions](#solutions)
4. [Result set](#result-set)

## Problem Statement

Sometimes, payment transactions are repeated by accident; it could be due to user error, API failure or a retry error that causes a credit card to be charged twice.

Using the transactions table, identify any payments made at the same merchant with the same credit card for the same amount within 10 minutes of each other. Count such repeated payments.

Assumptions:

- The first transaction of such payments should not be counted as a repeated payment. This means, if there are two transactions performed by a merchant with the same credit card and for the same amount within 10 minutes, there will only be 1 repeated payment.

## Datasets used

```transactions``` Table:

|  Column Name  | Type          |
| ------------- | ------------- |
| transaction_id | 	integer |
| merchant_id |	integer |
| credit_card_id |	integer |
| amount |	integer |
| transaction_timestamp |	datetime |

## Solutions

```sql
WITH CTE1 AS (
    SELECT
    *,
    LEAD(transaction_timestamp) OVER(PARTITION BY merchant_id, credit_card_id, amount) AS lead_tr_time
FROM transactions
)

SELECT 
    COUNT(*) AS payment_count
FROM CTE1
WHERE lead_tr_time IS NOT NULL
AND (DATE_PART('day', lead_tr_time::timestamp - transaction_timestamp::timestamp) * 24 + 
     DATE_PART('hour', lead_tr_time::timestamp - transaction_timestamp::timestamp)) * 60 + 
     DATE_PART('minute', lead_tr_time::timestamp - transaction_timestamp::timestamp) <= 10
```

## Result set

| payment_count |
| ------------ |
| 4 |