# [73 - Category Product Count](https://www.namastesql.com/coding-problem/73-category-product-count)

## Table Of Contents
1. [Problem Statement](#problem-statement)
2. [Datasets used](#datasets-used)
3. [Solutions](#solutions)
4. [Result set](#result-set)

## Problem Statement

You are provided with a table that lists various product categories, each containing a comma-separated list of products. Your task is to write a SQL query to count the number of products in each category. Sort the result by product count.

## Datasets used

```categories``` Table:

| COLUMN_NAME | DATA_TYPE   |
| ----------- | ----------- |
| category    | varchar(15) |
| products    | varchar(30) |

## Solutions

```sql
SELECT
  category,
  (LENGTH(REPLACE(products, ' ', '')) - LENGTH(REPLACE(products, ', ', ''))) + 1 AS product_count
FROM categories;
```

## Result set

| category    | product_count |
| ----------- | ------------- | 
| Electronics |             3 |
| Furniture   |             1 |
| Clothing    |             4 |
| Groceries   |             2 |