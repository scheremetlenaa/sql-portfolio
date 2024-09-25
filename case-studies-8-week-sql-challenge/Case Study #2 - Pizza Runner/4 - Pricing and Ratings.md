## Case Study Questions

1. If a Meat Lovers pizza costs $12 and Vegetarian costs $10 and there were no charges for changes - how much money has Pizza Runner made so far if there are no delivery fees?
2. What if there was an additional $1 charge for any pizza extras?
    - Add cheese is $1 extra
3. The Pizza Runner team now wants to add an additional ratings system that allows customers to rate their runner, how would you design an additional table for this new dataset - generate a schema for this new table and insert your own data for ratings for each successful customer order between 1 to 5.
4. Using your newly generated table - can you join all of the information together to form a table which has the following information for successful deliveries?
    - customer_id
    - order_id
    - runner_id
    - rating
    - order_time
    - pickup_time
    - Time between order and pickup
    - Delivery duration
    - Average speed
    - Total number of pizzas
5. If a Meat Lovers pizza was $12 and Vegetarian $10 fixed prices with no cost for extras and each runner is paid $0.30 per kilometre traveled - how much money does Pizza Runner have left over after these deliveries?

---

## Solutions

---

### 1. If a Meat Lovers pizza costs $12 and Vegetarian costs $10 and there were no charges for changes - how much money has Pizza Runner made so far if there are no delivery fees?

```sql
SELECT
      SUM(CASE
          WHEN pn.pizza_name = 'Meatlovers' THEN 12
        	ELSE 10
    	END) AS total_earnings
FROM pizza_runner.customer_orders co
INNER JOIN pizza_runner.pizza_names pn
      ON co.pizza_id = pn.pizza_id
INNER JOIN pizza_runner.runner_orders ro
      ON co.order_id = ro.order_id
      AND ro.cancellation IS NULL;
```
#### Result set

| total_earnings |
| -------------- |
| 138            |

---

### 2. What if there was an additional $1 charge for any pizza extras?
  - Add cheese is $1 extra

```sql
WITH pizza_cost AS (
SELECT
     SUM(CASE
          WHEN pn.pizza_name = 'Meatlovers' THEN 12
        	ELSE 10
     END) AS total_earnings
FROM pizza_runner.customer_orders co
INNER JOIN pizza_runner.pizza_names pn
     ON co.pizza_id = pn.pizza_id
INNER JOIN pizza_runner.runner_orders ro
     ON co.order_id = ro.order_id
     AND ro.cancellation IS NULL
),

topping_cost AS (
  SELECT
      SUM(CASE
               WHEN co.extras IS NULL THEN 0
               ELSE LENGTH(extras) - LENGTH(REPLACE(extras, ',', '')) + 1
      	  END) AS topping_cost
  FROM pizza_runner.customer_orders co
	INNER JOIN pizza_runner.runner_orders ro
      ON co.order_id = ro.order_id
    	AND ro.cancellation IS NULL
)

SELECT (SELECT total_earnings FROM pizza_cost) + (SELECT topping_cost FROM topping_cost) AS total_cost_with_toppings;
```
#### Result set

| total_cost_with_toppings |
| ------------------------ |
| 142                      |

---

### 3. The Pizza Runner team now wants to add an additional ratings system that allows customers to rate their runner, how would you design an additional table for this new dataset - generate a schema for this new table and insert your own data for ratings for each successful customer order between 1 to 5.

```sql
DROP TABLE IF EXISTS pizza_runner.runner_rating;

CREATE TABLE pizza_runner.runner_rating (
  "order_id" INTEGER,
  "rating" INTEGER,
  "comment" VARCHAR(255)
);

INSERT INTO pizza_runner.runner_rating ("order_id", "rating", "comment")
VALUES
    ('1', '3', 'great service, but delivery was too slow..'),
    ('2', '4', 'good'),
    ('3', '1', 'Pizza was COLD'),
    ('4', '5', 'Very fast delivery'),
    ('5', '4', 'OK'),
    ('6', '5', NULL),
    ('7', '4', 'Good pizza, polite runner'),
    ('8', '4', NULL),
    ('10', '5', 'Everything is OK!');

SELECT * FROM pizza_runner.runner_rating;
```
### Result set

| order_id | rating | comment                                    |
| -------- | ------ | ------------------------------------------ |
| 1        | 3      | great service, but delivery was too slow.. |
| 2        | 4      | good                                       |
| 3        | 1      | Pizza was COLD                             |
| 4        | 5      | Very fast delivery                         |
| 5        | 4      | OK                                         |
| 6        | 5      | NULL                                       |
| 7        | 4      | Good pizza, polite runner                  |
| 8        | 4      | NULL                                       |
| 10       | 5      | Everything is OK!                          |

---

### 4. Using your newly generated table - can you join all of the information together to form a table which has the following information for successful deliveries?
- customer_id
- order_id
- runner_id
- rating
- order_time
- pickup_time
- Time between order and pickup
- Delivery duration
- Average speed
- Total number of pizzas

```sql
SELECT
    co.customer_id,
    ro.order_id,
    ro.runner_id,
    rr.rating,
    co.order_time,
    ro.pickup_time,
    ROUND((EXTRACT(EPOCH FROM (ro.pickup_time::TIMESTAMP - co.order_time)) / 60)::NUMERIC, 0) AS prep_time_in_min,
    ro.duration AS delivery_duration,
    ROUND(ro.distance::NUMERIC / (ro.duration::NUMERIC / 60), 2) AS average_speed,
    COUNT(co.pizza_id) AS pizza_count
FROM pizza_runner.runner_orders ro
LEFT JOIN pizza_runner.runner_rating rr
    ON ro.order_id = rr.order_id
INNER JOIN pizza_runner.customer_orders co
    ON ro.order_id = co.order_id
GROUP BY 1, 2, 3, 4, 6, 8, co.order_time, ro.distance
ORDER BY 1, 2;
```
#### Result set

| customer_id | order_id | runner_id | rating | order_time               | pickup_time         | prep_time_in_min | delivery_duration | average_speed | pizza_count |
| ----------- | -------- | --------- | ------ | ------------------------ | ------------------- | ---------------- | ----------------- | ------------- | ----------- |
| 101         | 1        | 1         | 3      | 2020-01-01T18:05:02.000Z | 2020-01-01 18:15:34 | 11               | 32                | 37.50         | 1           |
| 101         | 2        | 1         | 4      | 2020-01-01T19:00:52.000Z | 2020-01-01 19:10:54 | 10               | 27                | 44.44         | 1           |
| 101         | 6        | 3         | NULL   | 2020-01-08T21:03:13.000Z | NULL                | NULL             | NULL              | NULL          | 1           |
| 102         | 3        | 1         | 1      | 2020-01-02T23:51:23.000Z | 2020-01-03 00:12:37 | 21               | 20                | 40.20         | 2           |
| 102         | 8        | 2         | 4      | 2020-01-09T23:54:33.000Z | 2020-01-10 00:15:02 | 20               | 15                | 93.60         | 1           |
| 103         | 4        | 2         | 5      | 2020-01-04T13:23:46.000Z | 2020-01-04 13:53:03 | 29               | 40                | 35.10         | 3           |
| 103         | 9        | 2         | NULL   | 2020-01-10T11:22:59.000Z | NULL                | NULL             | NULL              | NULL          | 1           |
| 104         | 5        | 3         | 4      | 2020-01-08T21:00:29.000Z | 2020-01-08 21:10:57 | 10               | 15                | 40.00         | 1           |
| 104         | 10       | 1         | 5      | 2020-01-11T18:34:49.000Z | 2020-01-11 18:50:20 | 16               | 10                | 60.00         | 2           |
| 105         | 7        | 2         | 4      | 2020-01-08T21:20:29.000Z | 2020-01-08 21:30:45 | 10               | 25                | 60.00         | 1           |

---

### 5. If a Meat Lovers pizza was $12 and Vegetarian $10 fixed prices with no cost for extras and each runner is paid $0.30 per kilometre traveled - how much money does Pizza Runner have left over after these deliveries?

```sql
WITH CTE AS (
SELECT
      SUM(CASE
          WHEN pn.pizza_name = 'Meatlovers' THEN 12
        	ELSE 10
    	END) AS total_earnings
FROM pizza_runner.customer_orders co
INNER JOIN pizza_runner.pizza_names pn
      ON co.pizza_id = pn.pizza_id
INNER JOIN pizza_runner.runner_orders ro
      ON co.order_id = ro.order_id
      AND ro.cancellation IS NULL
), 

CTE1 AS (
SELECT
	SUM(distance::NUMERIC * 0.3) AS runner_expenses
FROM pizza_runner.runner_orders
WHERE cancellation IS NULL
AND distance IS NOT NULL
)

SELECT
(SELECT total_earnings FROM CTE) - (SELECT runner_expenses FROM CTE1) AS earnings_left;
```
#### Result set

| earnings_left |
| ------------- |
| 94.44         |

---
