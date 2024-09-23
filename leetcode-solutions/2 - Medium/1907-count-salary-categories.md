# [1907. Count Salary Categories](https://leetcode.com/problems/count-salary-categories/description/)

## Table Of Contents
1. [Problem Statement](#problem-statement)
2. [Datasets used](#datasets-used)
3. [Solutions](#solutions)
4. [Result set](#result-set)

## Problem Statement

Write a solution to calculate the number of bank accounts for each salary category. The salary categories are:

- "Low Salary": All the salaries strictly less than $20000.
- "Average Salary": All the salaries in the inclusive range [$20000, $50000].
- "High Salary": All the salaries strictly greater than $50000.

The result table must contain all three categories. If there are no accounts in a category, return 0.

Return the result table in any order.

## Datasets used

```Accounts``` Table:

| Column Name | Type |
| ----------- | ---- |
| account_id  | int  |
| income      | int  |

account_id is the primary key (column with unique values) for this table.
Each row contains information about the monthly income for one bank account.

## Solutions

```sql
SELECT
    'Low Salary' AS category,
    COUNT(*) AS accounts_count 
FROM Accounts
WHERE income < 20000

UNION ALL

SELECT
    'Average Salary' AS category,
    COUNT(*) AS accounts_count 
FROM Accounts
WHERE income >= 20000 AND income <= 50000

UNION ALL

SELECT
    'High Salary' AS category,
    COUNT(*) AS accounts_count 
FROM Accounts
WHERE income > 50000;
```

## Result set

| category       | accounts_count |
| -------------- | -------------- |
| Low Salary     | 1              |
| Average Salary | 0              |
| High Salary    | 3              |