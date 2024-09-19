# [1965. Employees With Missing Information](https://leetcode.com/problems/employees-with-missing-information/description/)

## Table Of Contents
1. [Problem Statement]()
2. [Datasets used]()
3. [Solutions]()
4. [Result set]()

## Problem Statement

Write a solution to report the IDs of all the employees with missing information. The information of an employee is missing if:

- The employee's name is missing, or
- The employee's salary is missing.

Return the result table ordered by employee_id in ascending order.

## Datasets used

```Employees``` Table:

| Column Name | Type    |
| ----------- | ------- |
| employee_id | int     |
| name        | varchar |

employee_id is the column with unique values for this table.
Each row of this table indicates the name of the employee whose ID is employee_id.

```Salaries``` Table:

| Column Name | Type    |
| ----------- | ------- |
| employee_id | int     |
| salary      | int     |

employee_id is the column with unique values for this table.
Each row of this table indicates the salary of the employee whose ID is employee_id.

## Solutions

```sql
SELECT
    CASE
        WHEN name IS NULL THEN s.employee_id
        WHEN salary IS NULL THEN e.employee_id
    END AS employee_id
FROM Employees e
FULL OUTER JOIN Salaries s
    ON e.employee_id = s.employee_id
WHERE name IS NULL OR salary IS NULL
ORDER BY employee_id;
```

## Result set

| employee_id |
| ----------- |
| 1           |
| 2           |