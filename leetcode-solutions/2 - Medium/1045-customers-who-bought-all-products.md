# [1045. Customers Who Bought All Products](https://leetcode.com/problems/customers-who-bought-all-products/description/)

## Table Of Contents
1. [Problem Statement]()
2. [Datasets used]()
3. [Solutions]()
4. [Result set]()

## Problem Statement

Write a solution to report the customer ids from the Customer table that bought all the products in the Product table.

Return the result table in any order.

## Datasets used

```Customer``` Table:

| Column Name | Type    |
| ------------| --------|
| customer_id | int     |
| product_key | int     |

This table may contain duplicates rows. 
customer_id is not NULL.
product_key is a foreign key (reference column) to Product table.

```Product``` Table:

| Column Name | Type    |
| ----------- | ------- |
| product_key | int     |

product_key is the primary key (column with unique values) for this table.

## Solutions

```sql
SELECT
    customer_id
FROM Customer
GROUP BY customer_id
HAVING COUNT(DISTINCT product_key) = (SELECT COUNT(DISTINCT product_key) FROM Product); 
```

## Result set

| customer_id |
| ----------- |
| 1           |
| 3           |