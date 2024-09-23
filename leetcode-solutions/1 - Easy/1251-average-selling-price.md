# [1251. Average Selling Price](https://leetcode.com/problems/average-selling-price/description/)

## Table Of Contents
1. [Problem Statement](#problem-statement)
2. [Datasets used](#datasets-used)
3. [Solutions](#solutions)
4. [Result set](#result-set)

## Problem Statement

Write a solution to find the average selling price for each product. average_price should be rounded to 2 decimal places. If a product does not have any sold units, its average selling price is assumed to be 0.

Return the result table in any order.

## Datasets used

```Prices``` Table:

| Column Name   | Type    |
| ------------- | ------- | 
| product_id    | int     |
| start_date    | date    |
| end_date      | date    |
| price         | int     |

(product_id, start_date, end_date) is the primary key (combination of columns with unique values) for this table.
Each row of this table indicates the price of the product_id in the period from start_date to end_date.
For each product_id there will be no two overlapping periods. That means there will be no two intersecting periods for the same product_id.

```UnitsSold``` Table:

| Column Name   | Type    |
| ------------- | ------- |
| product_id    | int     |
| purchase_date | date    |
| units         | int     |

This table may contain duplicate rows.
Each row of this table indicates the date, units, and product_id of each product sold.

## Solutions

```sql
SELECT 
    p.product_id,
    ISNULL(ROUND(SUM(price*1.0*units) / SUM(units), 2), 0) AS average_price 
FROM UnitsSold us
RIGHT JOIN Prices p
    ON us.product_id = p.product_id
    AND purchase_date BETWEEN start_date AND end_date
GROUP BY p.product_id;
```

## Result set

| product_id | average_price |
| ---------- | ------------- |
| 1          | 6.96          |
| 2          | 16.96         |