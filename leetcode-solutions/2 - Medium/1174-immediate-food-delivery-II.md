# [1174. Immediate Food Delivery II](https://leetcode.com/problems/immediate-food-delivery-ii/description/)

## Table Of Contents
1. [Problem Statement](#problem-statement)
2. [Datasets used](#datasets-used)
3. [Solutions](#solutions)
4. [Result set](#result-set)

## Problem Statement

If the customer's preferred delivery date is the same as the order date, then the order is called immediate; otherwise, it is called scheduled.

The first order of a customer is the order with the earliest order date that the customer made. It is guaranteed that a customer has precisely one first order.

Write a solution to find the percentage of immediate orders in the first orders of all customers, rounded to 2 decimal places.

## Datasets used

```Delivery``` Table:

| Column Name                 | Type    |
| --------------------------- | ------- |
| delivery_id                 | int     |
| customer_id                 | int     |
| order_date                  | date    |
| customer_pref_delivery_date | date    |

delivery_id is the column of unique values of this table.
The table holds information about food delivery to customers that make orders at some date and specify a preferred delivery date (on the same order date or after it).

## Solutions

```sql
WITH delivery_with_types AS (
    SELECT
        *,
        CASE
            WHEN customer_pref_delivery_date = order_date THEN 'immediate'
            ELSE 'scheduled'
        END AS order_type
    FROM Delivery
),

first_order_types AS (
    SELECT
        DISTINCT customer_id,
        FIRST_VALUE(order_type) OVER (PARTITION BY customer_id ORDER BY order_date) AS first_order_type
    FROM delivery_with_types
)

SELECT
    ROUND(SUM(CASE WHEN first_order_type = 'immediate' THEN 1 ELSE 0 END) * 100.0 / (SELECT COUNT(*) FROM first_order_types), 2) AS immediate_percentage 
FROM first_order_types
```

## Result set

| immediate_percentage |
| -------------------- |
| 50                   |