# [1070. Product Sales Analysis III](https://leetcode.com/problems/product-sales-analysis-iii/description/)

## Table Of Contents
1. [Problem Statement]()
2. [Datasets used]()
3. [Solutions]()
4. [Result set]()

## Problem Statement

Write a solution to select the product id, year, quantity, and price for the first year of every product sold.

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
WITH CTE AS (
    SELECT
        product_id,
        year,
        RANK() OVER (PARTITION BY product_id ORDER BY year ASC) AS rnk,
        quantity,
        price
    FROM Sales
)

SELECT
    product_id,
    year AS first_year,
    quantity,
    price
FROM CTE
WHERE rnk = 1;
```

## Result set

| product_id | first_year | quantity | price |
| ---------- | ---------- | -------- | ----- |
| 100        | 2008       | 10       | 5000  |
| 200        | 2011       | 15       | 9000  |