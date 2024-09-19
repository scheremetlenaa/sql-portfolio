# [1068. Product Sales Analysis I](https://leetcode.com/problems/product-sales-analysis-i/description/)

## Table Of Contents
1. [Problem Statement]()
2. [Datasets used]()
3. [Solutions]()
4. [Result set]()

## Problem Statement

Write a solution to report the product_name, year, and price for each sale_id in the Sales table.

Return the resulting table in any order.

## Datasets used

```Sales``` Table:

| Column Name | Type  |
| ----------- | ----- |
| sale_id     | int   |
| product_id  | int   |
| year        | int   |
| quantity    | int   |
| price       | int   |

(sale_id, year) is the primary key (combination of columns with unique values) of this table.
product_id is a foreign key (reference column) to Product table.
Each row of this table shows a sale on the product product_id in a certain year.
Note that the price is per unit.

```Product``` Table:

| Column Name  | Type    |
| ------------ | ------- |
| product_id   | int     |
| product_name | varchar |

product_id is the primary key (column with unique values) of this table.
Each row of this table indicates the product name of each product.

## Solutions

```sql
/* Write your T-SQL query statement below */

SELECT
    product_name,
    year,
    price
FROM Sales s
INNER JOIN Product p
    ON s.product_id = p.product_id;
```

## Result set

| product_name | year | price |
| ------------ | ---- | ----- |
| Nokia        | 2008 | 5000  |
| Nokia        | 2009 | 5000  |
| Apple        | 2011 | 9000  |