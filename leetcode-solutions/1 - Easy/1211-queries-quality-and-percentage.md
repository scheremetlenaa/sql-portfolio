# [1211. Queries Quality and Percentage](https://leetcode.com/problems/queries-quality-and-percentage/description/)

## Table Of Contents
1. [Problem Statement]()
2. [Datasets used]()
3. [Solutions]()
4. [Result set]()

## Problem Statement

We define query quality as:

- The average of the ratio between query rating and its position.

We also define poor query percentage as:

- The percentage of all queries with rating less than 3.

Write a solution to find each query_name, the quality and poor_query_percentage.

Both quality and poor_query_percentage should be rounded to 2 decimal places.

Return the result table in any order.

## Datasets used

```Queries``` Table:

| Column Name | Type    |
| ----------- | ------- |
| query_name  | varchar |
| result      | varchar |
| position    | int     |
| rating      | int     |

This table may have duplicate rows.
This table contains information collected from some queries on a database.
The position column has a value from 1 to 500.
The rating column has a value from 1 to 5. Query with rating less than 3 is a poor query.

## Solutions

```sql
SELECT
    query_name,
    ROUND(SUM(CAST(rating AS DECIMAL)/position) / COUNT(*), 2) AS quality,
    ROUND(COUNT(CASE WHEN rating<3 THEN 1 ELSE NULL END) * 100.0 / COUNT(rating), 2) AS poor_query_percentage
FROM Queries
GROUP BY query_name
HAVING query_name IS NOT NULL;
```

## Result set

| query_name | quality | poor_query_percentage |
| ---------- | ------- | --------------------- |
| Cat        | 0.66    | 33.33                 |
| Dog        | 2.5     | 33.33                 |