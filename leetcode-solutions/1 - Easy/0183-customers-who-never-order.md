# [183. Customers Who Never Order](https://leetcode.com/problems/customers-who-never-order/description/)

## Table Of Contents
1. [Problem Statement](#problem-statement)
2. [Datasets used](#datasets-used)
3. [Solutions](#solutions)
4. [Result set](#result-set)

## Problem Statement

Write a solution to find all customers who never order anything.

Return the result table in any order.

## Datasets used

```Customers``` Table:

| Column Name | Type    |
| ----------- | ------- |
| id          | int     |
| name        | varchar |

id is the primary key (column with unique values) for this table.
Each row of this table indicates the ID and name of a customer.

```Orders``` Table:

| Column Name | Type |
| ----------- | ---- |
| id          | int  |
| customerId  | int  |

id is the primary key (column with unique values) for this table.
customerId is a foreign key (reference columns) of the ID from the Customers table.
Each row of this table indicates the ID of an order and the ID of the customer who ordered it.

## Solutions

```sql
SELECT c.name AS Customers
FROM Customers c
LEFT JOIN Orders o
    ON o.customerId = c.id
    WHERE o.id IS NULL
```

## Result set

| Customers |
| --------- |
| Henry     |
| Max       |