# [72 - Product Sales](https://www.namastesql.com/coding-problem/72-product-sales)

## Table Of Contents
1. [Problem Statement](#problem-statement)
2. [Datasets used](#datasets-used)
3. [Solutions](#solutions)
4. [Result set](#result-set)

## Problem Statement

You are provided with two tables: Products and Sales. The Products table contains information about various products, including their IDs, names, and prices. The Sales table contains data about sales transactions, including the product IDs, quantities sold, and dates of sale. Your task is to write a SQL query to find the total sales amount for each product. Display product name and total sales . Sort the result by product name.

## Datasets used

```products``` Table:

| COLUMN_NAME  | DATA_TYPE   |
| ------------ | ----------- |
| product_id   | int         |
| product_name | varchar(10) |
| price        | int         |

```sales``` Table:

| COLUMN_NAME | DATA_TYPE |
| ----------- | --------- |
| sale_id     | int       |
| product_id  | int       |
| quantity    | int       |
| sale_date   | date      |

## Solutions

```sql
SELECT
	product_name,
    IFNULL(SUM(price*quantity), 0) AS total_sales_amount
FROM products p
LEFT JOIN sales s
	ON p.product_id = s.product_id
GROUP BY product_name
ORDER BY product_name;
```

## Result set

| product_name | total_sales_amount |
| ------------ | ------------------ |
| Headphones   |                850 |
| Laptop       |              13600 |
| Smartphone   |               9000 |
| Tablet       |               2800 |