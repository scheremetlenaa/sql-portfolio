# [1164. Product Price at a Given Date](https://leetcode.com/problems/product-price-at-a-given-date/description/)

## Table Of Contents
1. [Problem Statement](#problem-statement)
2. [Datasets used](#datasets-used)
3. [Solutions](#solutions)
4. [Result set](#result-set)

## Problem Statement

Write a solution to find the prices of all products on 2019-08-16. Assume the price of all products before any change is 10.

Return the result table in any order.

## Datasets used

```Products``` Table:

| Column Name   | Type    |
| ------------- | ------- |
| product_id    | int     |
| new_price     | int     |
| change_date   | date    |

(product_id, change_date) is the primary key (combination of columns with unique values) of this table.
Each row of this table indicates that the price of some product was changed to a new price at some date.

## Solutions

```sql
WITH price AS (
    SELECT DISTINCT
      product_id,
      FIRST_VALUE (new_price) OVER (PARTITION BY product_id ORDER BY change_date DESC) AS price
    FROM Products
    WHERE change_date <= '2019-08-16'
),

distinct_products AS (
    SELECT
        DISTINCT product_id
    FROM Products
)

SELECT
    dp.product_id,
    ISNULL(price, 10) AS price
FROM distinct_products dp
LEFT JOIN price p
    ON dp.product_id = p.product_id
```

## Result set

| product_id | price |
| ---------- | ----- |
| 1          | 35    |
| 2          | 50    |
| 3          | 10    |