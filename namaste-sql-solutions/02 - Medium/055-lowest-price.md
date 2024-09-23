# [55 - Lowest Price](https://www.namastesql.com/coding-problem/55-lowest-price)

## Table Of Contents
1. [Problem Statement]()
2. [Datasets used]()
3. [Solutions]()
4. [Result set]()

## Problem Statement

You own a small online store, and want to analyze customer ratings for the products that you're selling. After doing a data pull, you have a list of products and a log of purchases. Within the purchase log, each record includes the number of stars (from 1 to 5) as a customer rating for the product.

For each category, find the lowest price among all products that received at least one 4-star or above rating from customers.
If a product category did not have any products that received at least one 4-star or above rating, the lowest price is considered to be 0. The final output should be sorted by product category in alphabetical order.

## Datasets used

```products``` Table:

| COLUMN_NAME | DATA_TYPE   |
| ----------- | ----------- |
| category    | varchar(10) |
| id          | int         |
| name        | varchar(20) |
| price       | int         |

```purchases``` Table:

| COLUMN_NAME | DATA_TYPE |
| ----------- | --------- | 
| id          | int       |
| product_id  | int       |
| stars       | int       |

## Solutions

```sql
WITH CTE AS (
  SELECT
      id,
      product_id,
      stars
  FROM purchases
  WHERE stars >= 4
),

CTE1 AS (
  SELECT
      category,
      product_id,
      stars,
      price
  FROM products pr
  INNER JOIN CTE
      ON pr.id = CTE.product_id
)

SELECT
	pr.category,
	IFNULL(MIN(CTE1.price), 0) AS lowest_price
FROM products pr
LEFT JOIN CTE1
	ON CTE1.category = pr.category
GROUP BY pr.category;
    AND CTE1.price = pr.price;
```

## Result set

| category | lowest_price |
| -------- | ------------ | 
| apple    |            0 |
| orange   |           14 |
| grape    |            0 |
| cherry   |           36 |