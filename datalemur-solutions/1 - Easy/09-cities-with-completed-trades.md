# [Cities With Completed Trades [Robinhood SQL Interview Question]](https://datalemur.com/questions/completed-trades)

## Table Of Contents
1. [Problem Statement]()
2. [Datasets used]()
3. [Solutions]()
4. [Result set]()

## Problem Statement

Assume you're given the tables containing completed trade orders and user details in a Robinhood trading system.

Write a query to retrieve the top three cities that have the highest number of completed trade orders listed in descending order. Output the city name and the corresponding number of completed trade orders.

## Datasets used

```trades``` Table:

|  Column Name  | Type          |
| ------------- | ------------- |
| order_id | integer |
| user_id | integer |
| quantity | integer |
| status | string ('Completed', 'Cancelled') |
| date | timestamp |
| price | decimal (5, 2) |

```users``` Table:

| Column Name | Type |
| ----------- | ---- |
| user_id | integer |
| city | string |
| email | string |
| signup_date | datetime |

## Solutions

```sql
SELECT
    city,
    COUNT(*) AS total_orders
FROM trades
INNER JOIN users ON trades.user_id = users.user_id
WHERE status = 'Completed'
GROUP BY city
ORDER BY COUNT(*) DESC
LIMIT 3;
```

## Result set

| city | total_orders |
| ---- | ------------ |
| San Francisco | 4 |
| Boston | 3 |
| Denver | 2 |
