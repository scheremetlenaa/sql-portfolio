# [Highest-Grossing Items [Amazon SQL Interview Question]](https://datalemur.com/questions/sql-highest-grossing)

## Table Of Contents
1. [Problem Statement](#problem-statement)
2. [Datasets used](#datasets-used)
3. [Solutions](#solutions)
4. [Result set](#result-set)

## Problem Statement

Assume you're given a table containing data on Amazon customers and their spending on products in different category, write a query to identify the top two highest-grossing products within each category in the year 2022. The output should include the category, product, and total spend.

## Datasets used

```product_spend``` Table:

|  Column Name  | Type          |
| ------------- | ------------- |
| category | string |
| product | string |
| user_id |	integer |
| spend |	decimal |
| transaction_date |	timestamp |

## Solutions

```sql
SELECT
    category,
    product,
    total_spend
FROM (
    SELECT
        category,
        product,
        SUM(spend) AS total_spend,
        RANK() OVER (PARTITION BY category ORDER BY SUM(spend) DESC) AS ranking
    FROM product_spend
    WHERE EXTRACT(YEAR FROM transaction_date) = 2022
    GROUP BY category, product
) t1
WHERE ranking < 3
ORDER BY category, ranking;
```

## Result set

| category | product | total_spend |
| -------- | ------- | ----------- |
| appliance |	washing machine |	439.80 |
| appliance |	refrigerator |	299.99 |
| electronics | vacuum |	486.66 |
| electronics |	wireless headset |	467.89 |