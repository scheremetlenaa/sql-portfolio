# [1789. Primary Department for Each Employee](https://leetcode.com/problems/primary-department-for-each-employee/description/)

## Table Of Contents
1. [Problem Statement](#problem-statement)
2. [Datasets used](#datasets-used)
3. [Solutions](#solutions)
4. [Result set](#result-set)

## Problem Statement

Employees can belong to multiple departments. When the employee joins other departments, they need to decide which department is their primary department. Note that when an employee belongs to only one department, their primary column is 'N'.

Write a solution to report all the employees with their primary department. For employees who belong to one department, report their only department.

Return the result table in any order.

## Datasets used

```Employee``` Table:

| Column Name   |  Type   |
| ------------- | ------- |
| employee_id   | int     |
| department_id | int     |
| primary_flag  | varchar |

(employee_id, department_id) is the primary key (combination of columns with unique values) for this table.
employee_id is the id of the employee.
department_id is the id of the department to which the employee belongs.
primary_flag is an ENUM (category) of type ('Y', 'N'). If the flag is 'Y', the department is the primary department for the employee. If the flag is 'N', the department is not the primary.

## Solutions

```sql
WITH CTE AS (
    SELECT
        *,
        CASE
            WHEN COUNT(employee_id) OVER (PARTITION BY employee_id) = 1 AND primary_flag = 'N' 
            THEN department_id
            WHEN COUNT(employee_id) OVER (PARTITION BY employee_id) > 1 AND primary_flag = 'Y' 
            THEN department_id
            ELSE 0
        END AS dpt
    FROM Employee
)

SELECT
    employee_id,
    MAX(dpt) AS department_id
FROM CTE
GROUP BY employee_id;
```

## Result set

| employee_id | department_id |
| ----------- | ------------- |
| 1           | 1             |
| 2           | 1             |
| 3           | 3             |
| 4           | 3             |