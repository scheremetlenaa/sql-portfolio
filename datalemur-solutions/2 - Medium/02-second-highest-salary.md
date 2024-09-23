# [Second Highest Salary [FAANG SQL Interview Question]](https://datalemur.com/questions/sql-second-highest-salary)

## Table Of Contents
1. [Problem Statement](#problem-statement)
2. [Datasets used](#datasets-used)
3. [Solutions](#solutions)
4. [Result set](#result-set)

## Problem Statement

Imagine you're an HR analyst at a tech company tasked with analyzing employee salaries. Your manager is keen on understanding the pay distribution and asks you to determine the second highest salary among all employees.

It's possible that multiple employees may share the same second highest salary. In case of duplicate, display the salary only once.

## Datasets used

```employee``` Table:

|  Column Name  | Type          | Description |
| ------------- | ------------- | ----------- |
| employee_id |	integer	| The unique ID of the employee. |
| name |	string |	The name of the employee. |
| salary |	integer |	The salary of the employee. |
| department_id |	integer |	The department ID of the employee. |
| manager_id |	integer |	The manager ID of the employee. |

## Solutions

```sql
SELECT
    MAX(salary) AS second_max_salary
FROM employee
WHERE salary < (
    SELECT
        MAX(salary) AS max_salary
    FROM employee
);
```

## Result set

| second_max_salary |
| ------------ |
| 12500 |