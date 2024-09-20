# [2 - Product Category](https://www.namastesql.com/coding-problem/2-product-category)

## Table Of Contents
1. [Problem Statement]()
2. [Datasets used]()
3. [Solutions]()
4. [Result set]()

## Problem Statement

You are provided with a table named Products containing information about various products, including their names and prices. Write a SQL query to count number of products in each category based on its price into three categories below. Display the output in descending order of no of products.

1. "Low Price" for products with a price less than 100
2. "Medium Price" for products with a price between 100 and 500 (inclusive)
3. "High Price" for products with a price greater than 500.

## Datasets used

```Products``` Table:

| COLUMN_NAME  | DATA_TYPE   |
| ------------ | ----------- | 
| product_id   | int         |
| product_name | varchar(20) |
| price        | int         |


## Solutions

```sql
WITH Categories AS (
  SELECT
      product_name,
      CASE
          WHEN price < 100 THEN 'Low Price'
          WHEN price BETWEEN 100 AND 500 THEN 'Medium Price'
          WHEN price > 500 THEN 'High Price'
      END AS price_category
  FROM products
)

SELECT
	price_category,
    COUNT(*) AS cnt
FROM Categories
GROUP BY price_category
ORDER BY cnt DESC;
```

## Result set

| price_category | cnt |
| -------------- | --- |
| Low Price      | 9   |
| Medium Price   | 4   |
| High Price     | 2   |
