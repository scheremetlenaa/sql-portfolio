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

### 5. What was the difference between the longest and shortest delivery times for all orders?

```sql
SELECT
     MAX(duration::NUMERIC) - MIN(duration::NUMERIC) AS difference_max_min_time
FROM pizza_runner.runner_orders
WHERE duration IS NOT NULL;
```
#### Result set

| difference_max_min_time |
| ----------------------- |
| 30                      |

---

### 6. What was the average speed for each runner for each delivery and do you notice any trend for these values?

```sql
SELECT
     runner_id,
     order_id,
     distance::NUMERIC AS distance_in_km,
     ROUND(duration::NUMERIC / 60, 2) as duration_in_hour,
     ROUND(distance::NUMERIC / (duration::NUMERIC / 60), 2) AS avg_spd
FROM pizza_runner.runner_orders
WHERE cancellation IS NULL
ORDER BY runner_id, order_id;
```
#### Result set

| runner_id | order_id | distance_in_km | duration_in_hour | avg_spd |
| --------- | -------- | -------------- | ---------------- | ------- |
| 1         | 1        | 20             | 0.53             | 37.50   |
| 1         | 2        | 20             | 0.45             | 44.44   |
| 1         | 3        | 13.4           | 0.33             | 40.20   |
| 1         | 10       | 10             | 0.17             | 60.00   |
| 2         | 4        | 23.4           | 0.67             | 35.10   |
| 2         | 7        | 25             | 0.42             | 60.00   |
| 2         | 8        | 23.4           | 0.25             | 93.60   |
| 3         | 5        | 10             | 0.25             | 40.00   |

---

### 7. What is the successful delivery percentage for each runner?

```SQL
SELECT
     runner_id,
     COUNT(*) AS all_orders_cnt,
     SUM(CASE WHEN cancellation IS NULL THEN 1 ELSE 0 END) AS delivered_orders_cnt,
     ROUND((SUM(CASE WHEN cancellation IS NULL THEN 1 ELSE 0 END) * 100.00/ COUNT(*)), 2) AS successful_delivery_pct
FROM pizza_runner.runner_orders
GROUP BY runner_id
ORDER BY runner_id;
```
#### Result set

| runner_id | all_orders_cnt | delivered_orders_cnt | successful_delivery_pct |
| --------- | -------------- | -------------------- | ----------------------- |
| 1         | 4              | 4                    | 100.00                  |
| 2         | 4              | 3                    | 75.00                   |
| 3         | 2              | 1                    | 50.00                   |

---
