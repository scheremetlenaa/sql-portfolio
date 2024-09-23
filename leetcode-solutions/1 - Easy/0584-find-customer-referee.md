# [584. Find Customer Referee](https://leetcode.com/problems/find-customer-referee/description/)

## Table Of Contents
1. [Problem Statement](#problem-statement)
2. [Datasets used](#datasets-used)
3. [Solutions](#solutions)
4. [Result set](#result-set)

## Problem Statement

Find the names of the customer that are not referred by the customer with id = 2.

Return the result table in any order.

## Datasets used

```Customer``` Table:

| Column Name | Type    |
| ----------- | ------- |
| id          | int     |
| name        | varchar |
| referee_id  | int     |

In SQL, id is the primary key column for this table.
Each row of this table indicates the id of a customer, their name, and the id of the customer who referred them.

## Solutions

```sql
SELECT name
FROM Customer
WHERE referee_id <> 2
OR referee_id IS NULL;
```

## Result set

| name |
| ---- |
| Will |
| Jane |
| Bill |
| Zack |