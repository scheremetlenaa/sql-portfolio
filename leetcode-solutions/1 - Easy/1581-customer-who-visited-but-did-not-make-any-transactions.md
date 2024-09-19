# [1581. Customer Who Visited but Did Not Make Any Transactions](https://leetcode.com/problems/customer-who-visited-but-did-not-make-any-transactions/description/)

## Table Of Contents
1. [Problem Statement]()
2. [Datasets used]()
3. [Solutions]()
4. [Result set]()

## Problem Statement

Write a solution to find the IDs of the users who visited without making any transactions and the number of times they made these types of visits.

Return the result table sorted in any order.

## Datasets used

```Visits``` Table:

| Column Name | Type    |
| ----------- | ------- |
| visit_id    | int     |
| customer_id | int     |

visit_id is the column with unique values for this table.
This table contains information about the customers who visited the mall.

```Transactions``` Table:

| Column Name    | Type    |
| -------------- | ------- |
| transaction_id | int     |
| visit_id       | int     |
| amount         | int     |

transaction_id is column with unique values for this table.
This table contains information about the transactions made during the visit_id.

## Solutions

```sql
SELECT
    customer_id,
    COUNT(*) AS count_no_trans
FROM Visits v
LEFT JOIN Transactions t
    ON v.visit_id = t.visit_id
WHERE t.visit_id IS NULL
GROUP BY customer_id;
```

## Result set

| customer_id | count_no_trans |
| ----------- | -------------- |
| 30          | 1              |
| 54          | 2              |
| 96          | 1              |