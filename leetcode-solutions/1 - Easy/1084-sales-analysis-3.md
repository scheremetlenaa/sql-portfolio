# [1084. Sales Analysis III](https://leetcode.com/problems/sales-analysis-iii/description/)

## Table Of Contents
1. [Problem Statement]()
2. [Datasets used]()
3. [Solutions]()
4. [Result set]()

## Problem Statement

Write a solution to report the products that were only sold in the first quarter of 2019. That is, between 2019-01-01 and 2019-03-31 inclusive.

Return the result table in any order.

## Datasets used

```Product``` Table:

| Column Name  | Type    |
| ------------ | ------- |
| product_id   | int     |
| product_name | varchar |
| unit_price   | int     |

product_id is the primary key (column with unique values) of this table.
Each row of this table indicates the name and the price of each product.

```Sales``` Table:

| Column Name | Type    |
| ----------- | ------- |
| seller_id   | int     |
| product_id  | int     |
| buyer_id    | int     |
| sale_date   | date    |
| quantity    | int     |
| price       | int     |

This table can have duplicate rows.
product_id is a foreign key (reference column) to the Product table.
Each row of this table contains some information about one sale.

## Solutions

```sql
SELECT 
    p.product_id,
    product_name
FROM Product p
INNER JOIN Sales s
    ON p.product_id = s.product_id
GROUP BY p.product_id, product_name
HAVING MIN(sale_date) >= '2019-01-01' AND MAX(sale_date) <= '2019-03-31';
```

## Result set

| product_id | product_name |
| ---------- | ------------ |
| 1          | S8           |