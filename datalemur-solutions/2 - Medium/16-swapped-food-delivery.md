# [Swapped Food Delivery [Zomato SQL Interview Question]](https://datalemur.com/questions/sql-swapped-food-delivery)

## Table Of Contents
1. [Problem Statement]()
2. [Datasets used]()
3. [Solutions]()
4. [Result set]()

## Problem Statement

Zomato is a leading online food delivery service that connects users with various restaurants and cuisines, allowing them to browse menus, place orders, and get meals delivered to their doorsteps.

Recently, Zomato encountered an issue with their delivery system. Due to an error in the delivery driver instructions, each item's order was swapped with the item in the subsequent row. As a data analyst, you're asked to correct this swapping error and return the proper pairing of order ID and item.

If the last item has an odd order ID, it should remain as the last item in the corrected data. For example, if the last item is Order ID 7 Tandoori Chicken, then it should remain as Order ID 7 in the corrected data.

In the results, return the correct pairs of order IDs and items.

## Datasets used

```orders``` Table:

|  Column Name  | Type          | Description |
| ------------- | ------------- | ----------- |
| order_id	| integer |	The ID of each Zomato order. |
| item |	string |	The name of the food item in each order. |

## Solutions

```sql
SELECT
    CASE
        WHEN order_id % 2 != 0 AND order_id != total_orders THEN order_id + 1
        WHEN order_id % 2 != 0 AND order_id = total_orders THEN order_id
        ELSE order_id - 1
    END AS corrected_order_id,
    item
FROM orders
CROSS JOIN (SELECT COUNT(*) AS total_orders FROM orders) total_orders
ORDER BY corrected_order_id;
```

## Result set

| corrected_order_id | item |
| ------------------ | ---- |
| 1 |	Pizza |
| 2 |	Chow Mein |
| 3 |	Butter Chicken |
| 4 |	Pad Thai |
| 5 |	Burger |
| 6 |	Eggrolls |
| 7 |	Sushi |
| 8 |	Tandoori Chicken |
| 9 |	Ramen |
| 10 |	Tacos |
| 11 |	Lasagna |
| 12 |	Burrito |
| 13 |	Steak |
| 14 |	Salad |
| 15 |	Spaghetti |