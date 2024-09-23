# [Compressed Mode [Alibaba SQL Interview Question]](https://datalemur.com/questions/alibaba-compressed-mode)

## Table Of Contents
1. [Problem Statement](#problem-statement)
2. [Datasets used](#datasets-used)
3. [Solutions](#solutions)
4. [Result set](#result-set)

## Problem Statement

You're given a table containing the item count for each order on Alibaba, along with the frequency of orders that have the same item count. Write a query to retrieve the mode of the order occurrences. Additionally, if there are multiple item counts with the same mode, the results should be sorted in ascending order.

Clarifications:

- ```item_count```: Represents the number of items sold in each order.
- ```order_occurrences```: Represents the frequency of orders with the corresponding number of items sold per order.
- For example, if there are 800 orders with 3 items sold in each order, the record would have an item_count of 3 and an order_occurrences of 800.

## Datasets used

```items_per_order``` Table:

|  Column Name  | Type          |
| ------------- | ------------- |
| item_count | integer |
| order_occurrences |	integer |

## Solutions

```sql
SELECT item_count
FROM items_per_order
WHERE order_occurrences = (
    SELECT
        MODE() WITHIN GROUP (ORDER BY order_occurrences DESC)
    FROM items_per_order
)
ORDER BY item_count;
```

## Result set

| item_count |
| ------------ |
| 2 |
| 4 |