# [Supercloud Customer [Microsoft SQL Interview Question]](https://datalemur.com/questions/supercloud-customer)

## Table Of Contents
1. [Problem Statement](#problem-statement)
2. [Datasets used](#datasets-used)
3. [Solutions](#solutions)
4. [Result set](#result-set)

## Problem Statement

A Microsoft Azure Supercloud customer is defined as a customer who has purchased at least one product from every product category listed in the products table.

Write a query that identifies the customer IDs of these Supercloud customers.

## Datasets used

```customer_contracts``` Table:

|  Column Name  | Type          |
| ------------- | ------------- |
| customer_id | integer |
| product_id | 	integer |
| amount |	integer |

```products``` Table:

| Column Name | Type |
| ----------- | ---- |
| product_id |	integer |
| product_category |	string |
| product_name |	string |

## Solutions

```sql
SELECT
    customer_id
FROM (
    SELECT
        DISTINCT customer_id,
        product_category
    FROM customer_contracts
    INNER JOIN products
        ON customer_contracts.product_id = products.product_id
    GROUP BY customer_id, product_category
) t1
GROUP BY customer_id
HAVING COUNT(*) = (SELECT COUNT(DISTINCT product_category) FROM products)
```

## Result set

| customer_id |
| ------------ |
| 7 |