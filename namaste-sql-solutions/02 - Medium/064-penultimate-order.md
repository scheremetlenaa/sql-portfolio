# [64 - Penultimate Order](https://www.namastesql.com/coding-problem/64-penultimate-order)

## Table Of Contents
1. [Problem Statement]()
2. [Datasets used]()
3. [Solutions]()
4. [Result set]()

## Problem Statement

You are a data analyst working for an e-commerce company, responsible for analysing customer orders to gain insights into their purchasing behaviour. Your task is to write a SQL query to retrieve the details of the penultimate order for each customer. However, if a customer has placed only one order, you need to retrieve the details of that order instead, display the output in ascending order of customer name.

## Datasets used

```orders``` Table:

| COLUMN_NAME   | DATA_TYPE   |
| ------------- | ----------- |
| order_id      | int         |
| order_date    | date        |
| customer_name | varchar(10) |
| product_name  | varchar(10) |
| sales         | int         |

## Solutions

```sql
WITH CTE AS (
  SELECT
      *,
      ROW_NUMBER() OVER(PARTITION BY customer_name ORDER BY order_date DESC) AS rw_nm
  FROM orders
),

CTE1 AS (
  SELECT
      order_id,
      order_date,
      customer_name,
      product_name,
      sales
  FROM CTE
  WHERE rw_nm = 2

  UNION ALL

  SELECT
      order_id,
      order_date,
      customer_name,
      product_name,
      sales
  FROM orders
  WHERE customer_name IN (
                          SELECT customer_name
                          FROM orders
                          GROUP BY customer_name
                          HAVING COUNT(*) = 1
                         )
)

SELECT
	*
FROM CTE1
ORDER BY customer_name;
```

## Result set

| order_id | order_date | customer_name | product_name | sales |
| -------- | ---------- | ------------- | ------------ | ----- | 
|        2 | 2023-01-02 | Alexa         | boAt         |   300 |
|        6 | 2023-01-03 | Neha          | Dress        |   100 |
|        4 | 2023-01-01 | Ramesh        | Titan        |   200 |