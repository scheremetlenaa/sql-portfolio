# [Y-on-Y Growth Rate [Wayfair SQL Interview Question]](https://datalemur.com/questions/yoy-growth-rate)

## Table Of Contents
1. [Problem Statement]()
2. [Datasets used]()
3. [Solutions]()
4. [Result set]()

## Problem Statement

Assume you're given a table containing information about Wayfair user transactions for different products. Write a query to calculate the year-on-year growth rate for the total spend of each product, grouping the results by product ID.

The output should include the year in ascending order, product ID, current year's spend, previous year's spend and year-on-year growth percentage, rounded to 2 decimal places.

## Datasets used

```user_transactions``` Table:

|  Column Name  | Type          |
| ------------- | ------------- |
| transaction_id | integer |
| product_id |	integer |
| spend |	decimal |
| transaction_date |	datetime |

## Solutions

```sql
SELECT
    year,
    product_id,
    curr_year_spend,
    prev_year_spend,
    ROUND(100.0 * (curr_year_spend - prev_year_spend) / prev_year_spend, 2) AS yoy_rate
FROM (
    SELECT
        EXTRACT(YEAR FROM transaction_date) AS year,
        product_id,
        spend AS curr_year_spend,
        LAG(spend) OVER (PARTITION BY product_id ORDER BY product_id, EXTRACT(YEAR FROM transaction_date)) AS prev_year_spend
    FROM user_transactions
) t1;
```

## Result set

| year | product_id | curr_year_spend | prev_year_spend | yoy_rate |
| ---- | ---------- | --------------- | --------------- | -------- |
| 2019 | 123424     | 1500.60         | NULL            | NULL     |
| 2020 | 123424     | 1000.20         | 1500.60         | -33.35   |
| 2021 | 123424     | 1246.44         | 1000.20         | 24.62    |
| 2022 | 123424     | 2145.32         | 1246.44         | 72.12    |
| 2019 | 234412     | 1800.00         | NULL            | NULL     |
| 2020 | 234412     | 1234.00         | 1800.00         | -31.44   |
| 2021 | 234412     | 889.50          | 1234.00         | -27.92   |
| 2022 | 234412     | 2900.00         | 889.50          | 226.03   |
| 2019 | 543623     | 6450.00         | NULL            | NULL     |
| 2020 | 543623     | 5348.12         | 6450.00         | -17.08   |
| 2021 | 543623     | 2345.00         | 5348.12         | -56.15   |
| 2022 | 543623     | 5680.00         | 2345.00         | 142.22   |