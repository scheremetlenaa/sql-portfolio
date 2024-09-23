# [3-Topping Pizzas [McKinsey SQL Interview Question]](https://datalemur.com/questions/pizzas-topping-cost)

## Table Of Contents
1. [Problem Statement](#problem-statement)
2. [Datasets used](#datasets-used)
3. [Solutions](#solutions)
4. [Result set](#result-set)

## Problem Statement

You’re a consultant for a major pizza chain that will be running a promotion where all 3-topping pizzas will be sold for a fixed price, and are trying to understand the costs involved.

Given a list of pizza toppings, consider all the possible 3-topping pizzas, and print out the total cost of those 3 toppings. Sort the results with the highest total cost on the top followed by pizza toppings in ascending order.

Break ties by listing the ingredients in alphabetical order, starting from the first ingredient, followed by the second and third.

Notes:

- Do not display pizzas where a topping is repeated. For example, ‘Pepperoni,Pepperoni,Onion Pizza’.
- Ingredients must be listed in alphabetical order. For example, 'Chicken,Onions,Sausage'. 'Onion,Sausage,Chicken' is not acceptable.

## Datasets used

```pizza_toppings``` Table:

|  Column Name  | Type          |
| ------------- | ------------- |
| topping_name | varchar(255) |
| ingredient_cost | decimal(10,2) |


## Solutions

```sql
SELECT
    CONCAT(p1.topping_name, ',', p2.topping_name, ',', p3.topping_name) AS pizza,
    p1.ingredient_cost + p2.ingredient_cost + p3.ingredient_cost AS total_cost
FROM pizza_toppings p1
INNER JOIN pizza_toppings p2
    ON p1.topping_name < p2.topping_name
INNER JOIN pizza_toppings p3
    ON p2.topping_name < p3.topping_name
ORDER BY total_cost DESC, pizza
```

## Result set

| pizza                                | total_cost |
| ------------------------------------ | ---------- |
| Chicken,Pepperoni,Sausage            | 1.75       |
| Chicken,Extra Cheese,Sausage         | 1.65       |
| Extra Cheese,Pepperoni,Sausage       | 1.60       |
| Chicken,Sausage,Spinach              | 1.55       |
| Chicken,Mushrooms,Sausage            | 1.50       |
| Chicken,Pineapple,Sausage            | 1.50       |
| Pepperoni,Sausage,Spinach	           | 1.50       |
| Chicken,Extra Cheese,Pepperoni       | 1.45       |
| Chicken,Green Peppers,Sausage	       | 1.45       |
| Chicken,Jalapenos,Sausage	           | 1.45       |
| Mushrooms,Pepperoni,Sausage	       | 1.45       |
| Pepperoni,Pineapple,Sausage          | 1.45       |
| Chicken,Onions,Sausage               | 1.40       |
| Extra Cheese,Sausage,Spinach         | 1.40       |
| Green Peppers,Pepperoni,Sausage      | 1.40       |
| Jalapenos,Pepperoni,Sausage          | 1.40       |
| Chicken,Pepperoni,Spinach	           | 1.35       |
| Extra Cheese,Mushrooms,Sausage       | 1.35       |
| Extra Cheese,Pineapple,Sausage       | 1.35       |
| Onions,Pepperoni,Sausage             | 1.35       |
| Chicken,Mushrooms,Pepperoni          | 1.30       |
| Chicken,Pepperoni,Pineapple          | 1.30       |
| Extra Cheese,Green Peppers,Sausage   | 1.30       |
| Extra Cheese,Jalapenos,Sausage	   | 1.30       |
| Chicken,Extra Cheese,Spinach	       | 1.25       |
| Chicken,Green Peppers,Pepperoni      | 1.25       |
| Chicken,Jalapenos,Pepperoni	       | 1.25       |
| Extra Cheese,Onions,Sausage	       | 1.25       |
| Mushrooms,Sausage,Spinach            | 1.25       |
| Pineapple,Sausage,Spinach	           | 1.25       |
| Chicken,Extra Cheese,Mushrooms       | 1.20       |
| Chicken,Extra Cheese,Pineapple       | 1.20       |
| Chicken,Onions,Pepperoni	           | 1.20       |
| Extra Cheese,Pepperoni,Spinach	   | 1.20       |
| Green Peppers,Sausage,Spinach	       | 1.20       |
| Jalapenos,Sausage,Spinach	           | 1.20       |
| Mushrooms,Pineapple,Sausage	       | 1.20       |
| Chicken,Extra Cheese,Green Peppers   | 1.15       |
| Chicken,Extra Cheese,Jalapenos	   | 1.15       |
| Extra Cheese,Mushrooms,Pepperoni	   | 1.15       |
| Extra Cheese,Pepperoni,Pineapple	   | 1.15       |
| Green Peppers,Mushrooms,Sausage	   | 1.15       |
| Green Peppers,Pineapple,Sausage	   | 1.15       |
| Jalapenos,Mushrooms,Sausage	       | 1.15       |
| Jalapenos,Pineapple,Sausage	       | 1.15       |
| Onions,Sausage,Spinach	           | 1.15       |
| Chicken,Extra Cheese,Onions	       | 1.10       |
| Chicken,Mushrooms,Spinach	           | 1.10       |
| Chicken,Pineapple,Spinach	           | 1.10       |
| Extra Cheese,Green Peppers,Pepperoni | 1.10       |
| Extra Cheese,Jalapenos,Pepperoni     | 1.10       |
| Green Peppers,Jalapenos,Sausage	   | 1.10       |
| Mushrooms,Onions,Sausage             | 1.10       |
| Onions,Pineapple,Sausage	           | 1.10       |
| Chicken,Green Peppers,Spinach	       | 1.05       |
| Chicken,Jalapenos,Spinach	           | 1.05       |
| Chicken,Mushrooms,Pineapple	       | 1.05       |
| Extra Cheese,Onions,Pepperoni	       | 1.05       |
| Green Peppers,Onions,Sausage	       | 1.05       |
| Jalapenos,Onions,Sausage	           | 1.05       |
| Mushrooms,Pepperoni,Spinach	       | 1.05       |
| Pepperoni,Pineapple,Spinach	       | 1.05       |
| Chicken,Green Peppers,Mushrooms	   | 1.00       |
| Chicken,Green Peppers,Pineapple	   | 1.00       |
| Chicken,Jalapenos,Mushrooms	       | 1.00       |
| Chicken,Jalapenos,Pineapple	       | 1.00       |
| Chicken,Onions,Spinach	           | 1.00       |
| Green Peppers,Pepperoni,Spinach	   | 1.00       |
| Jalapenos,Pepperoni,Spinach	       | 1.00       |
| Mushrooms,Pepperoni,Pineapple	       | 1.00       |
| Chicken,Green Peppers,Jalapenos	   | 0.95       |
| Chicken,Mushrooms,Onions	           | 0.95       |
| Chicken,Onions,Pineapple	           | 0.95       |
| Extra Cheese,Mushrooms,Spinach	   | 0.95       |
| Extra Cheese,Pineapple,Spinach	   | 0.95       |
| Green Peppers,Mushrooms,Pepperoni	   | 0.95       |
| Green Peppers,Pepperoni,Pineapple    | 0.95       |
| Jalapenos,Mushrooms,Pepperoni	       | 0.95       |
| Jalapenos,Pepperoni,Pineapple	       | 0.95       |
| Onions,Pepperoni,Spinach             | 0.95       |
| Chicken,Green Peppers,Onions	       | 0.90       |
| Chicken,Jalapenos,Onions	           | 0.90       |
| Extra Cheese,Green Peppers,Spinach   | 0.90       |
| Extra Cheese,Jalapenos,Spinach       | 0.90       |
| Extra Cheese,Mushrooms,Pineapple	   | 0.90       |
| Green Peppers,Jalapenos,Pepperoni	   | 0.90       |
| Mushrooms,Onions,Pepperoni	       | 0.90       |
| Onions,Pepperoni,Pineapple	       | 0.90       |
| Extra Cheese,Green Peppers,Mushrooms | 0.85       |
| Extra Cheese,Green Peppers,Pineapple | 0.85       |
| Extra Cheese,Jalapenos,Mushrooms	   | 0.85       |
| Extra Cheese,Jalapenos,Pineapple	   | 0.85       |
| Extra Cheese,Onions,Spinach	       | 0.85       |
| Green Peppers,Onions,Pepperoni	   | 0.85       |
| Jalapenos,Onions,Pepperoni	       | 0.85       |
| Extra Cheese,Green Peppers,Jalapenos | 0.80       |
| Extra Cheese,Mushrooms,Onions	       | 0.80       |
| Extra Cheese,Onions,Pineapple	       | 0.80       |
| Mushrooms,Pineapple,Spinach	       | 0.80       |
| Extra Cheese,Green Peppers,Onions	   | 0.75       |
| Extra Cheese,Jalapenos,Onions	       | 0.75       |
| Green Peppers,Mushrooms,Spinach	   | 0.75       |
| Green Peppers,Pineapple,Spinach	   | 0.75       |
| Jalapenos,Mushrooms,Spinach	       | 0.75       |
| Jalapenos,Pineapple,Spinach	       | 0.75       |
| Green Peppers,Jalapenos,Spinach	   | 0.70       |
| Green Peppers,Mushrooms,Pineapple	   | 0.70       |
| Jalapenos,Mushrooms,Pineapple	       | 0.70       |
| Mushrooms,Onions,Spinach	           | 0.70       |
| Onions,Pineapple,Spinach	           | 0.70       |
| Green Peppers,Jalapenos,Mushrooms	   | 0.65       |
| Green Peppers,Jalapenos,Pineapple    | 0.65       |
| Green Peppers,Onions,Spinach	       | 0.65       |
| Jalapenos,Onions,Spinach	           | 0.65       |
| Mushrooms,Onions,Pineapple	       | 0.65       |
| Green Peppers,Mushrooms,Onions	   | 0.60       |
| Green Peppers,Onions,Pineapple	   | 0.60       |
| Jalapenos,Mushrooms,Onions	       | 0.60       |
| Jalapenos,Onions,Pineapple	       | 0.60       |
| Green Peppers,Jalapenos,Onions	   | 0.55       |