## Case Study Questions

1. What are the standard ingredients for each pizza?
2. What was the most commonly added extra?
3. What was the most common exclusion?
4. Generate an order item for each record in the customers_orders table in the format of one of the following:
     - Meat Lovers
     - Meat Lovers - Exclude Beef
     - Meat Lovers - Extra Bacon
     - Meat Lovers - Exclude Cheese, Bacon - Extra Mushroom, Peppers
5. Generate an alphabetically ordered comma separated ingredient list for each pizza order from the customer_orders table and add a 2x in front of any relevant ingredients
6. What is the total quantity of each ingredient used in all delivered pizzas sorted by most frequent first?
---

## Solutions

---

### 1. What are the standard ingredients for each pizza?

```sql
SELECT
    pr.pizza_id,
    pn.pizza_name,
    pt.topping_id,
    pt.topping_name
FROM pizza_runner.pizza_recipes pr
INNER JOIN LATERAL UNNEST(STRING_TO_ARRAY(pr.toppings, ',')::INTEGER[]) AS t(topping_id) 
	ON TRUE
INNER JOIN pizza_runner.pizza_toppings pt
	ON t.topping_id = pt.topping_id
INNER JOIN pizza_runner.pizza_names pn
	ON pn.pizza_id = pn.pizza_id;
```
#### Result set

| pizza_id | pizza_name | topping_id | topping_name |
| -------- | ---------- | ---------- | ------------ |
| 1        | Meatlovers | 1          | Bacon        |
| 1        | Vegetarian | 1          | Bacon        |
| 1        | Meatlovers | 2          | BBQ Sauce    |
| 1        | Vegetarian | 2          | BBQ Sauce    |
| 1        | Meatlovers | 3          | Beef         |
| 1        | Vegetarian | 3          | Beef         |
| 2        | Meatlovers | 4          | Cheese       |
| 2        | Vegetarian | 4          | Cheese       |
| 1        | Meatlovers | 4          | Cheese       |
| 1        | Vegetarian | 4          | Cheese       |
| 1        | Meatlovers | 5          | Chicken      |
| 1        | Vegetarian | 5          | Chicken      |
| 1        | Meatlovers | 6          | Mushrooms    |
| 1        | Vegetarian | 6          | Mushrooms    |
| 2        | Meatlovers | 6          | Mushrooms    |
| 2        | Vegetarian | 6          | Mushrooms    |
| 2        | Meatlovers | 7          | Onions       |
| 2        | Vegetarian | 7          | Onions       |
| 1        | Meatlovers | 8          | Pepperoni    |
| 1        | Vegetarian | 8          | Pepperoni    |
| 2        | Meatlovers | 9          | Peppers      |
| 2        | Vegetarian | 9          | Peppers      |
| 1        | Meatlovers | 10         | Salami       |
| 1        | Vegetarian | 10         | Salami       |
| 2        | Meatlovers | 11         | Tomatoes     |
| 2        | Vegetarian | 11         | Tomatoes     |
| 2        | Meatlovers | 12         | Tomato Sauce |
| 2        | Vegetarian | 12         | Tomato Sauce |

---

### 2. What was the most commonly added extra?

```sql
WITH CTE AS (  
SELECT
    UNNEST(STRING_TO_ARRAY(extras, ',')::INTEGER[]) AS extra_id
FROM pizza_runner.customer_orders
),

CTE1 AS (
  SELECT
    extra_id,
    COUNT(*) AS extras_count
  FROM CTE
  GROUP BY extra_id
  ORDER BY extras_count DESC
  LIMIT 1
)

SELECT
    extra_id,
    topping_name,
    extras_count
FROM CTE1
INNER JOIN pizza_runner.pizza_toppings pt
	ON CTE1.extra_id = pt.topping_id;
```
#### Result set

| extra_id | topping_name | extras_count |
| -------- | ------------ | ------------ |
| 1        | Bacon        | 4            |

---

### 3. What was the most common exclusion?

```sql
WITH CTE AS (  
SELECT
    UNNEST(STRING_TO_ARRAY(exclusions, ',')::INTEGER[]) AS exclusion_id
FROM pizza_runner.customer_orders
),

CTE1 AS (
  SELECT
    exclusion_id,
    COUNT(*) AS exclusions_count
  FROM CTE
  GROUP BY exclusion_id
  ORDER BY exclusions_count DESC
  LIMIT 1
)

SELECT
    exclusion_id,
    topping_name,
    exclusions_count
FROM CTE1
INNER JOIN pizza_runner.pizza_toppings pt;
	ON CTE1.exclusion_id = pt.topping_id;
```
#### Result set

| exclusion_id | topping_name | exclusions_count |
| ------------ | ------------ | ---------------- |
| 4            | Cheese       | 4                |

---

#### 4. Generate an order item for each record in the customers_orders table in the format of one of the following:
- Meat Lovers
- Meat Lovers - Exclude Beef
- Meat Lovers - Extra Bacon
- Meat Lovers - Exclude Cheese, Bacon - Extra Mushroom, Peppers

```sql
WITH exclusions_cte AS (
SELECT
    order_id,
    customer_id,
    pizza_id,
    exclusions,
    extras,
    STRING_AGG(topping_name, ', ') AS exclusions_name
FROM pizza_runner.customer_orders as t
LEFT JOIN pizza_runner.pizza_toppings as f
    ON t.exclusions LIKE CONCAT('%', f.topping_id, '%')
GROUP BY 1, 2, 3, 4, 5
ORDER BY 1, 2, 3, 4, 5
),

extras_cte AS (
SELECT
    order_id,
    customer_id,
    pizza_id,
    exclusions,
    extras,
    STRING_AGG(topping_name, ', ') AS extras_name
FROM pizza_runner.customer_orders as t
LEFT JOIN pizza_runner.pizza_toppings as f
    ON t.extras LIKE CONCAT('%', f.topping_id, '%')
GROUP BY 1, 2, 3, 4, 5
ORDER BY 1, 2, 3, 4, 5
)

SELECT
    excc.order_id,
    excc.customer_id,
    excc.pizza_id,
    CONCAT(pn.pizza_name, CASE WHEN excc.exclusions IS NOT NULL THEN ' - Exclude ' ELSE '' END, exclusions_name, CASE WHEN extc.extras IS NOT NULL THEN ' - Extra ' ELSE '' END, extras_name) AS description
FROM exclusions_cte excc
LEFT JOIN extras_cte extc
    ON excc.order_id = extc.order_id
    AND excc.customer_id = extc.customer_id
    AND excc.pizza_id = extc.pizza_id
    AND excc.exclusions = extc.exclusions
    AND excc.extras = extc.extras
LEFT JOIN pizza_runner.pizza_names pn
    ON excc.pizza_id = pn.pizza_id
ORDER BY 1, 2, 3;
```
#### Result set

| order_id | customer_id | pizza_id | description                                                     |
| -------- | ----------- | -------- | --------------------------------------------------------------- |
| 1        | 101         | 1        | Meatlovers                                                      |
| 2        | 101         | 1        | Meatlovers                                                      |
| 3        | 102         | 1        | Meatlovers                                                      |
| 3        | 102         | 2        | Vegetarian                                                      |
| 4        | 103         | 1        | Meatlovers - Exclude Cheese, Cheese                             |
| 4        | 103         | 2        | Vegetarian - Exclude Cheese                                     |
| 5        | 104         | 1        | Meatlovers                                                      |
| 6        | 101         | 2        | Vegetarian                                                      |
| 7        | 105         | 2        | Vegetarian                                                      |
| 8        | 102         | 1        | Meatlovers                                                      |
| 9        | 103         | 1        | Meatlovers - Exclude Cheese - Extra Bacon, Chicken              |
| 10       | 104         | 1        | Meatlovers - Exclude BBQ Sauce, Mushrooms - Extra Bacon, Cheese |
| 10       | 104         | 1        | Meatlovers                                                      |

---
