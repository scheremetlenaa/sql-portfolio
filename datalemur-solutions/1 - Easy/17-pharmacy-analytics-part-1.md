# [Pharmacy Analytics (Part 1) [CVS Health SQL Interview Question]](https://datalemur.com/questions/top-profitable-drugs)

## Table Of Contents
1. [Problem Statement](#problem-statement)
2. [Datasets used](#datasets-used)
3. [Solutions](#solutions)
4. [Result set](#result-set)

## Problem Statement

CVS Health is trying to better understand its pharmacy sales, and how well different products are selling. Each drug can only be produced by one manufacturer.

Write a query to find the top 3 most profitable drugs sold, and how much profit they made. Assume that there are no ties in the profits. Display the result from the highest to the lowest total profit.

Definition:

- ```cogs``` stands for Cost of Goods Sold which is the direct cost associated with producing the drug.
- Total Profit = Total Sales - Cost of Goods Sold

## Datasets used

```pharmacy_sales``` Table:

|  Column Name  | Type          |
| ------------- | ------------- |
| product_id |	integer |
| units_sold |	integer |
| total_sales |	decimal |
| cogs |	decimal |
| manufacturer |	varchar |
| drug |	varchar |

## Solutions

```sql
SELECT
    drug,
    total_sales - cogs AS total_profit
FROM pharmacy_sales
ORDER BY total_profit DESC
LIMIT 3;
```

## Result set

| drug | total_profit |
| ---- | ------------ |
| Humira |	81515652.55 |
| Keytruda |	11622022.02 |
| Dupixent |	11217052.34 |