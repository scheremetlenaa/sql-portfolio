# [586. Customer Placing the Largest Number of Orders](https://leetcode.com/problems/customer-placing-the-largest-number-of-orders/description/)

## Table Of Contents
1. [Problem Statement](#problem-statement)
2. [Datasets used](#datasets-used)
3. [Solutions](#solutions)
4. [Result set](#result-set)

## Problem Statement

Write a solution to find the customer_number for the customer who has placed the largest number of orders.

The test cases are generated so that exactly one customer will have placed more orders than any other customer.

## Datasets used

```Orders``` Table:

| Column Name     | Type     |
| --------------- | -------- |
| order_number    | int      |
| customer_number | int      |

order_number is the primary key (column with unique values) for this table.
This table contains information about the order ID and the customer ID.

## Solutions

```sql
SELECT TOP 1 customer_number 
FROM Orders
GROUP BY customer_number
ORDER BY COUNT(customer_number) DESC;
```

## Result set

| customer_number |
| --------------- |
| 3               |