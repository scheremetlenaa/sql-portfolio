# [1158. Market Analysis I](https://leetcode.com/problems/market-analysis-i/description/)

## Table Of Contents
1. [Problem Statement](#problem-statement)
2. [Datasets used](#datasets-used)
3. [Solutions](#solutions)
4. [Result set](#result-set)

## Problem Statement

Write a solution to find for each user, the join date and the number of orders they made as a buyer in 2019.

Return the result table in any order.

## Datasets used

```Users``` Table:

| Column Name    | Type    |
| -------------- | ------- |
| user_id        | int     |
| join_date      | date    |
| favorite_brand | varchar |

user_id is the primary key (column with unique values) of this table.
This table has the info of the users of an online shopping website where users can sell and buy items.

```Orders``` Table:

| Column Name   | Type    |
| ------------- | ------- |
| order_id      | int     |
| order_date    | date    |
| item_id       | int     |
| buyer_id      | int     |
| seller_id     | int     |

order_id is the primary key (column with unique values) of this table.
item_id is a foreign key (reference column) to the Items table.
buyer_id and seller_id are foreign keys to the Users table.

```Items``` Table:

| Column Name   | Type    |
| ------------- | ------- |
| item_id       | int     |
| item_brand    | varchar |

item_id is the primary key (column with unique values) of this table.

## Solutions

```sql
SELECT
    user_id AS buyer_id,
    join_date,
    SUM(CASE WHEN order_id IS NOT NULL THEN 1 ELSE 0 END) AS orders_in_2019 
FROM Users u
LEFT JOIN Orders o
    ON u.user_id = o.buyer_id
    AND YEAR(order_date) = 2019
GROUP BY user_id, join_date
ORDER BY user_id
```

## Result set

| buyer_id | join_date  | orders_in_2019 |
| -------- | ---------- | -------------- |
| 1        | 2018-01-01 | 1              |
| 2        | 2018-02-09 | 2              |
| 3        | 2018-01-19 | 0              |
| 4        | 2018-05-21 | 0              |