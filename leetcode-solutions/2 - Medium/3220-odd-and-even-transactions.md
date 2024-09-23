# [3220. Odd and Even Transactions](https://leetcode.com/problems/odd-and-even-transactions/description/)

## Table Of Contents
1. [Problem Statement](#problem-statement)
2. [Datasets used](#datasets-used)
3. [Solutions](#solutions)
4. [Result set](#result-set)

## Problem Statement

Write a solution to find the sum of amounts for odd and even transactions for each day. If there are no odd or even transactions for a specific date, display as 0.

Return the result table ordered by transaction_date in ascending order.

## Datasets used

```transactions``` Table:

| Column Name      | Type | 
| ---------------- | ---- |
| transaction_id   | int  |
| amount           | int  |
| transaction_date | date |

The transactions_id column uniquely identifies each row in this table.
Each row of this table contains the transaction id, amount and transaction date.

## Solutions

```sql
SELECT
    transaction_date,
    SUM(CASE
        WHEN amount % 2 = 1 THEN amount
        ELSE 0
    END) AS odd_sum,
    SUM(CASE
        WHEN amount % 2 = 0 THEN amount
        ELSE 0
    END) AS even_sum
FROM transactions
GROUP BY transaction_date
ORDER BY transaction_date;
```

## Result set

| transaction_date | odd_sum | even_sum |
| ---------------- | ------- | -------- |
| 2024-07-01       | 75      | 350      |
| 2024-07-02       | 0       | 350      |
| 2024-07-03       | 0       | 120      |