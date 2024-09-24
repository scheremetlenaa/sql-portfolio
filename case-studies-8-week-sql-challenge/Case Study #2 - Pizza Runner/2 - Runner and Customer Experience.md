## Case Study Questions

1. How many runners signed up for each 1 week period? (i.e. week starts 2021-01-01)
2. What was the average time in minutes it took for each runner to arrive at the Pizza Runner HQ to pickup the order?
3. Is there any relationship between the number of pizzas and how long the order takes to prepare?
4. What was the average distance travelled for each customer?
5. What was the difference between the longest and shortest delivery times for all orders?
6. What was the average speed for each runner for each delivery and do you notice any trend for these values?
7. What is the successful delivery percentage for each runner?

---

## Solutions

---

### 1. How many runners signed up for each 1 week period?

```sql
SELECT
     EXTRACT(WEEK FROM registration_date) AS week_num,
     COUNT(*) AS runners_count
FROM pizza_runner.runners r
GROUP BY EXTRACT(WEEK FROM registration_date)
ORDER BY EXTRACT(WEEK FROM registration_date);
```
#### Result set

| week_num | runners_count |
| -------- | ------------- |
| 1        | 1             |
| 2        | 1             |
| 53       | 2             |

---

### 2. What was the average time in minutes it took for each runner to arrive at the Pizza Runner HQ to pickup the order?

```sql
SELECT
     runner_id,
     ROUND(AVG(EXTRACT(EPOCH FROM (ro.pickup_time::TIMESTAMP - co.order_time)) / 60)::NUMERIC, 2) AS avg_arrive_time 
FROM pizza_runner.runner_orders ro
INNER JOIN pizza_runner.customer_orders co
     ON ro.order_id = co.order_id
     AND cancellation IS NULL
GROUP BY runner_id
ORDER BY runner_id;
```
#### Result set

| runner_id | avg_arrive_time |
| --------- | --------------- |
| 1         | 15.68           |
| 2         | 23.72           |
| 3         | 10.47           |

---

### 3. Is there any relationship between the number of pizzas and how long the order takes to prepare?

```sql
WITH CTE AS (
  SELECT
      co.order_id,
      COUNT(*) AS pizza_count,
      EXTRACT(EPOCH FROM (pickup_time::TIMESTAMP - order_time)) / 60 AS time_to_prepare
  FROM pizza_runner.runner_orders ro
  INNER JOIN pizza_runner.customer_orders co
      ON ro.order_id = co.order_id
      AND cancellation IS NULL
  GROUP BY co.order_id, ro.pickup_time, co.order_time
)

SELECT
     pizza_count,
     ROUND(AVG(time_to_prepare)::NUMERIC, 2) AS avg_prep_time
FROM CTE
GROUP BY pizza_count
ORDER BY pizza_count;
```
#### Result set

| pizza_count | avg_prep_time |
| ----------- | ------------- |
| 1           | 12.36         |
| 2           | 18.38         |
| 3           | 29.28         |

---

### 4. What was the average distance travelled for each customer?

```sql
SELECT
     customer_id,
     ROUND(AVG(distance::NUMERIC), 2) AS avg_distance
FROM pizza_runner.customer_orders co
INNER JOIN pizza_runner.runner_orders ro
     ON co.order_id = ro.order_id
     AND cancellation IS NULL
GROUP BY customer_id
ORDER BY customer_id;
```
#### Result set

| customer_id | avg_distance |
| ----------- | ------------ |
| 101         | 20.00        |
| 102         | 16.73        |
| 103         | 23.40        |
| 104         | 10.00        |
| 105         | 25.00        |

---

