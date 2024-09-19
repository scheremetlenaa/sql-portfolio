# [1327. List the Products Ordered in a Period](https://leetcode.com/problems/list-the-products-ordered-in-a-period/description/)

## Table Of Contents
1. [Problem Statement]()
2. [Datasets used]()
3. [Solutions]()
4. [Result set]()

## Problem Statement

Write a solution to get the names of products that have at least 100 units ordered in February 2020 and their amount.

Return the result table in any order.

## Datasets used

```Products``` Table:

| Column Name      | Type    |
| ---------------- | ------- |
| product_id       | int     |
| product_name     | varchar |
| product_category | varchar |

product_id is the primary key (column with unique values) for this table.
This table contains data about the company's products.

```Orders``` Table:

| Column Name   | Type    |
| ------------- | ------- |
| product_id    | int     |
| order_date    | date    |
| unit          | int     |

This table may have duplicate rows.
product_id is a foreign key (reference column) to the Products table.
unit is the number of products ordered in order_date.

## Solutions

```sql
/* Write your T-SQL query statement below */

SELECT
product_name,
SUM(unit) AS unit
FROM Products p
INNER JOIN Orders o
    ON p.product_id = o.product_id
    AND o.order_date BETWEEN '2020-02-01' AND '2020-02-29'
GROUP BY product_name
HAVING SUM(unit) >= 100;
```

## Result set

| product_name       | unit |
| ------------------ | ---- |
| Leetcode Kit       | 100  |
| Leetcode Solutions | 130  |