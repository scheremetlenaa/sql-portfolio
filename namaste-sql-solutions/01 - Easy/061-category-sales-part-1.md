# [61 - Category Sales (Part 1)](https://www.namastesql.com/coding-problem/61-category-sales-part-1)

## Table Of Contents
1. [Problem Statement]()
2. [Datasets used]()
3. [Solutions]()
4. [Result set]()

## Problem Statement

Write an SQL query to retrieve the total sales amount for each product category in the month of February 2022, only including sales made on weekdays (Monday to Friday). Display the output in ascending order of total sales.

## Datasets used

```sales``` Table:

| COLUMN_NAME | DATA_TYPE   |
| ----------- | ----------- |
| id          | int         |
| product_id  | int         |
| category    | varchar(12) |
| amount      | int         |
| order_date  | date        |

## Solutions

```sql
SELECT
	category,
    SUM(amount)
FROM sales
WHERE order_date BETWEEN '2022-02-01' AND '2022-02-28'
AND DAYOFWEEK(order_date) <> 1
AND DAYOFWEEK(order_date) <> 7
GROUP BY category;
```

## Result set

| category    | SUM(amount) |
| ----------- | ----------- | 
| Electronics |        2000 |
| Clothing    |         500 |
| Books       |         400 |