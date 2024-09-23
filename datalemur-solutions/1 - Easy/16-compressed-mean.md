# [Compressed Mean [Alibaba SQL Interview Question]](https://datalemur.com/questions/alibaba-compressed-mean)

## Table Of Contents
1. [Problem Statement](#problem-statement)
2. [Datasets used](#datasets-used)
3. [Solutions](#solutions)
4. [Result set](#result-set)

## Problem Statement

You're trying to find the mean number of items per order on Alibaba, rounded to 1 decimal place using tables which includes information on the count of items in each order (```item_count``` table) and the corresponding number of orders for each item count (```order_occurrences``` table).

## Datasets used

```items_per_order``` Table:

|  Column Name  | Type          |
| ------------- | ------------- |
| item_count | integer |
| order_occurrences |	integer |

## Solutions

```sql
SELECT
  ROUND(SUM(item_count::DECIMAL * order_occurrences) / SUM(order_occurrences), 1) AS mean
FROM items_per_order;
```

## Result set

| round |
| ------------ |
| 3.9 |