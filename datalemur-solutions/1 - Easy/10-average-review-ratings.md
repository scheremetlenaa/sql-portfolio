# [Average Review Ratings [Amazon SQL Interview Question]](https://datalemur.com/questions/sql-avg-review-ratings)

## Table Of Contents
1. [Problem Statement](#problem-statement)
2. [Datasets used](#datasets-used)
3. [Solutions](#solutions)
4. [Result set](#result-set)

## Problem Statement

Given the reviews table, write a query to retrieve the average star rating for each product, grouped by month. The output should display the month as a numerical value, product ID, and average star rating rounded to two decimal places. Sort the output first by month and then by product ID.

## Datasets used

```reviews``` Table:

|  Column Name  | Type          |
| ------------- | ------------- |
| review_id	| integer |
| user_id | integer |
| submit_date | datetime |
| product_id | integer |
| stars | integer (1-5) |

## Solutions

```sql
SELECT
    EXTRACT(month FROM submit_date) AS mth,
    product_id AS product,
    ROUND(AVG(stars), 2) AS avg_stars
FROM reviews
GROUP BY product_id, EXTRACT(month FROM submit_date)
ORDER BY EXTRACT(month FROM submit_date), product_id;
```

## Result set

| mth | product | avg_stars |
| --- | ------- | --------- |
| 5	| 25255 | 4.00 |
| 5 | 25600 | 4.33 |
| 6 | 12580 | 4.50 |
| 6 | 50001 | 3.50 |
| 6 | 69852 | 4.00 |
| 7 | 11223 | 5.00 |
| 7 | 69852 | 2.50 |