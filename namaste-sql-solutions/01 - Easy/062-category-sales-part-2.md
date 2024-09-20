# [62 - Category Sales (Part 2)](https://www.namastesql.com/coding-problem/62-category-sales-part-2)

## Table Of Contents
1. [Problem Statement]()
2. [Datasets used]()
3. [Solutions]()
4. [Result set]()

## Problem Statement

Write an SQL query to retrieve the total sales amount in each category. Include all categories, if no products were sold in a category display as 0. Display the output in ascending order of total_sales.

## Datasets used

```sales``` Table:

| COLUMN_NAME | DATA_TYPE |
| ----------- | --------- |
| amount      | int       |
| category_id | int       |
| sale_date   | date      |
| sale_id     | int       |

```Categories``` Table:

| COLUMN_NAME   | DATA_TYPE   |
| ------------- | ----------- | 
| category_id   | int         |
| category_name | varchar(12) |

## Solutions

```sql
SELECT
	category_name,
    IFNULL(SUM(amount), 0) AS total_sales
FROM Categories c
LEFT JOIN sales s
	ON c.category_id = s.category_id
GROUP BY category_name
ORDER BY total_sales;
```

## Result set

| category_name | total_sales |
| ------------- | ----------- | 
| Clothing      |           0 |
| Books         |         350 |
| Home Decor    |        1000 |
| Electronics   |        1300 |