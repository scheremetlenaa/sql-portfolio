# [1321. Restaurant Growth](https://leetcode.com/problems/restaurant-growth/description/)

## Table Of Contents
1. [Problem Statement]()
2. [Datasets used]()
3. [Solutions]()
4. [Result set]()

## Problem Statement

You are the restaurant owner and you want to analyze a possible expansion (there will be at least one customer every day).

Compute the moving average of how much the customer paid in a seven days window (i.e., current day + 6 days before). average_amount should be rounded to two decimal places.

Return the result table ordered by visited_on in ascending order.

## Datasets used

```Customer``` Table:

| Column Name   | Type    |
| ------------- | ------- |
| customer_id   | int     |
| name          | varchar |
| visited_on    | date    |
| amount        | int     |

In SQL,(customer_id, visited_on) is the primary key for this table.
This table contains data about customer transactions in a restaurant.
visited_on is the date on which the customer with ID (customer_id) has visited the restaurant.
amount is the total paid by a customer.

## Solutions

```sql
WITH CTE1 AS (
    SELECT
        visited_on,
        SUM(amount) AS sum_amount
    FROM Customer
    GROUP BY visited_on
),

CTE2 AS (
    SELECT
        visited_on,
        SUM(sum_amount) OVER(ORDER BY visited_on ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS amount,
        ROUND(AVG(sum_amount * 1.00) OVER(ORDER BY visited_on ROWS BETWEEN 6 PRECEDING AND CURRENT ROW), 2) AS average_amount,
        ROW_NUMBER() OVER(ORDER BY visited_on) AS rw_nm
    FROM CTE1
)

SELECT
    visited_on,
    amount,
    average_amount
FROM CTE2
WHERE rw_nm >= 7
ORDER BY visited_on

```

## Result set

| visited_on | amount | average_amount |
| ---------- | ------ | -------------- |
| 2019-01-07 | 860    | 122.86         |
| 2019-01-08 | 840    | 120            |
| 2019-01-09 | 840    | 120            |
| 2019-01-10 | 1000   | 142.86         |