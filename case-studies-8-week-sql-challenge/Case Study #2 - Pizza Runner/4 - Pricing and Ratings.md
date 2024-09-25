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

