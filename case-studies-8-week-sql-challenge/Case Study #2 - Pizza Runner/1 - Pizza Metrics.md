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
     co.pizza_id,
     COUNT(*) AS delivered_pizza_count
FROM pizza_runner.customer_orders co
INNER JOIN pizza_runner.runner_orders ro
     ON co.order_id = ro.order_id
     AND ro.cancellation IS NULL
GROUP BY pizza_id;
```

#### Result set

| pizza_id | delivered_pizza_count |
| -------- | --------------------- |
| 1        | 9                     |
| 2        | 3                     |

---

