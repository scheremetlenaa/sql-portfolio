# [1795. Rearrange Products Table](https://leetcode.com/problems/rearrange-products-table/description/)

## Table Of Contents
1. [Problem Statement](#problem-statement)
2. [Datasets used](#datasets-used)
3. [Solutions](#solutions)
4. [Result set](#result-set)

## Problem Statement

Write a solution to rearrange the Products table so that each row has (product_id, store, price). If a product is not available in a store, do not include a row with that product_id and store combination in the result table.

Return the result table in any order.

## Datasets used

```Products``` Table:

| Column Name | Type    |
| ----------- | ------- |
| product_id  | int     |
| store1      | int     |
| store2      | int     |
| store3      | int     |

product_id is the primary key (column with unique values) for this table.
Each row in this table indicates the product's price in 3 different stores: store1, store2, and store3.
If the product is not available in a store, the price will be null in that store's column.

## Solutions

```sql
SELECT 
    product_id, 
    'store1' AS store, 
    store1 AS price
FROM Products
WHERE store1 IS NOT NULL
UNION
SELECT 
    product_id, 
    'store2' AS store, 
    store2 AS price
FROM Products
WHERE store2 IS NOT NULL
UNION
SELECT 
    product_id, 
    'store3' AS store, 
    store3 AS price
FROM Products
WHERE store3 IS NOT NULL
```

## Result set

| product_id | store  | price |
| ---------- | ------ | ----- |
| 0          | store1 | 95    |
| 0          | store2 | 100   |
| 0          | store3 | 105   |
| 1          | store1 | 70    |
| 1          | store3 | 80    |