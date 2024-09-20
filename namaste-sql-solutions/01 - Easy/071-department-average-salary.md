# []()

## Table Of Contents
1. [Problem Statement]()
2. [Datasets used]()
3. [Solutions]()
4. [Result set]()

## Problem Statement

You are provided with two tables: Employees and Departments. The Employees table contains information about employees, including their IDs, names, salaries, and department IDs. The Departments table contains information about departments, including their IDs and names. Your task is to write a SQL query to find the average salary of employees in each department, but only include departments that have more than 2 employees . Display department name and average salary round to 2 decimal places. Sort the result by average salary in descending order.

## Datasets used

```Employees``` Table:

| COLUMN_NAME   | DATA_TYPE   |
| ------------- | ----------- |
| employee_id   | int         |
| employee_name | varchar(20) |
| salary        | int         |
| department_id | int         |

```Departments``` Table:

| COLUMN_NAME     | DATA_TYPE   |
| --------------- | ----------- | 
| department_id   | int         |
| department_name | varchar(10) |

## Solutions

```sql
SELECT
	department_name,
    ROUND(AVG(salary), 2) AS avg_salary
FROM Departments d
LEFT JOIN Employees e
	ON d.department_id = e.department_id
GROUP BY department_name
HAVING COUNT(employee_id) > 2
ORDER BY avg_salary DESC;
```

## Result set

| department_name | avg_salary |
| --------------- | ---------- |
| Finance         |   57000.00 |
| Sales           |   56200.00 |