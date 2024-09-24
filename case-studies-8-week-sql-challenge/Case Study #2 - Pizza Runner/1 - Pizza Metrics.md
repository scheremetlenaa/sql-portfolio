## Case Study Questions

1. How many pizzas were ordered?
2. How many unique customer orders were made?
3. How many successful orders were delivered by each runner?
4. How many of each type of pizza was delivered?
5. How many Vegetarian and Meatlovers were ordered by each customer?
6. What was the maximum number of pizzas delivered in a single order?
7. For each customer, how many delivered pizzas had at least 1 change and how many had no changes?
8. How many pizzas were delivered that had both exclusions and extras?
9. What was the total volume of pizzas ordered for each hour of the day?
10. What was the volume of orders for each day of the week?

---

## Solutions

---

### 1. How many pizzas were ordered?

```sql
SELECT
     COUNT(pizza_id) AS pizza_order_count
FROM pizza_runner.customer_orders;
```
#### Result set

| pizza_order_count |
| ----------------- |
| 14                |

---

### 2. How many unique customer orders were made?

```sql
SELECT
     COUNT(DISTINCT order_id) AS unique_order_count
FROM pizza_runner.customer_orders;
```
#### Result set

| unique_order_count |
| ------------------ |
| 10                 |

---

### 3. How many successful orders were delivered by each runner?

```sql
SELECT
     runner_id,
     COUNT(*) AS successful_orders_count
FROM pizza_runner.runner_orders
WHERE cancellation IS NULL
GROUP BY runner_id;
```

#### Result set

| runner_id | successful_orders_count |
| --------- | ----------------------- |
| 1         | 4                       |
| 2         | 3                       |
| 3         | 1                       |

---

### 4. How many of each type of pizza was delivered?

```sql
SELECT
     pn.pizza_name,
     COUNT(*) AS delivered_pizza_count
FROM pizza_runner.customer_orders co
INNER JOIN pizza_runner.runner_orders ro
     ON co.order_id = ro.order_id
     AND ro.cancellation IS NULL
INNER JOIN pizza_runner.pizza_names pn
     ON co.pizza_id = pn.pizza_id
GROUP BY pizza_name
ORDER BY pizza_name;
```

#### Result set

| pizza_name | delivered_pizza_count |
| ---------- | --------------------- |
| Meatlovers | 9                     |
| Vegetarian | 3                     |

---

### 5. How many Vegetarian and Meatlovers were ordered by each customer?

```sql
SELECT
     co.customer_id,
     pn.pizza_name,
     COUNT(*) AS order_count_by_type
FROM pizza_runner.customer_orders co
INNER JOIN pizza_runner.pizza_names pn
     ON co.pizza_id = pn.pizza_id
GROUP BY customer_id, pizza_name
ORDER BY customer_id, pizza_name;
```
#### Result set

| customer_id | pizza_name | order_count_by_type |
| ----------- | ---------- | ------------------- |
| 101         | Meatlovers | 2                   |
| 101         | Vegetarian | 1                   |
| 102         | Meatlovers | 2                   |
| 102         | Vegetarian | 1                   |
| 103         | Meatlovers | 3                   |
| 103         | Vegetarian | 1                   |
| 104         | Meatlovers | 3                   |
| 105         | Vegetarian | 1                   |

---

