# [1587. Bank Account Summary II](https://leetcode.com/problems/bank-account-summary-ii/description/)

## Table Of Contents
1. [Problem Statement](#problem-statement)
2. [Datasets used](#datasets-used)
3. [Solutions](#solutions)
4. [Result set](#result-set)

## Problem Statement

Write a solution to report the name and balance of users with a balance higher than 10000. The balance of an account is equal to the sum of the amounts of all transactions involving that account.

Return the result table in any order.

## Datasets used

```Users``` Table:

| Column Name  | Type    |
| ------------ | ------- |
| account      | int     |
| name         | varchar |

account is the primary key (column with unique values) for this table.
Each row of this table contains the account number of each user in the bank.
There will be no two users having the same name in the table.

```Transactions``` Table:

| Column Name   | Type    |
| ------------- | ------- |
| trans_id      | int     |
| account       | int     |
| amount        | int     |
| transacted_on | date    |

trans_id is the primary key (column with unique values) for this table.
Each row of this table contains all changes made to all accounts.
amount is positive if the user received money and negative if they transferred money.
All accounts start with a balance of 0.

## Solutions

```sql
SELECT
    name,
    SUM(amount) AS balance
FROM Users u
LEFT JOIN Transactions t
    ON u.account = t.account
GROUP BY name
HAVING SUM(amount) > 10000;
```

## Result set

| name  | balance |
| ----- | ------- |
| Alice | 11000   |