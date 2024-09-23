# [26 - Dynamic Pricing](https://www.namastesql.com/coding-problem/26-dynamic-pricing)

## Table Of Contents
1. [Problem Statement](#problem-statement)
2. [Datasets used](#datasets-used)
3. [Solutions](#solutions)
4. [Result set](#result-set)

## Problem Statement

You are given a products table where a new row is inserted every time the price of a product changes. Additionally, there is a transaction table containing details such as order_date and product_id for each order.

Write an SQL query to calculate the total sales value for each product, considering the cost of the product at the time of the order date, display the output in ascending order of the product_id.

## Datasets used

```products``` Table:

| COLUMN_NAME | DATA_TYPE |
| ----------- | --------- |
| product_id  | int       |
| price       | int       |
| price_date  | date      |

```orders``` Table:

| COLUMN_NAME | DATA_TYPE |
| ----------- | --------- |
| order_id    | int       |
| order_date  | date      |
| product_id  | int       |

## Solutions

```sql
WITH CTE AS (
  SELECT
    product_id,
    price,
    price_date,
    IFNULL(LEAD(price_date) OVER(PARTITION BY product_id ORDER BY price_date), CURRENT_DATE()) AS next_price_date
  FROM products
)

SELECT 
	o.product_id,
    SUM(price) AS total_sales_value
FROM orders o
INNER JOIN CTE
	ON o.product_id = CTE.product_id
   	AND order_date >= price_date 
    AND order_date < next_price_date
GROUP BY product_id
ORDER BY product_id;
```

## Result set

| product_id | total_sales_value |
| ---------- | ----------------- |
|        100 |               510 |
|        101 |              3450 |