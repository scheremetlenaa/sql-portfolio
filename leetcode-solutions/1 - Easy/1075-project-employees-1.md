# [1075. Project Employees I](https://leetcode.com/problems/project-employees-i/description/)

## Table Of Contents
1. [Problem Statement](#problem-statement)
2. [Datasets used](#datasets-used)
3. [Solutions](#solutions)
4. [Result set](#result-set)

## Problem Statement

Write an SQL query that reports the average experience years of all the employees for each project, rounded to 2 digits.

Return the result table in any order.

## Datasets used

```Project``` Table:

| Column Name | Type    |
| ----------- | ------- |
| project_id  | int     |
| employee_id | int     |

(project_id, employee_id) is the primary key of this table.
employee_id is a foreign key to Employee table.
Each row of this table indicates that the employee with employee_id is working on the project with project_id.

```Employee``` Table:

| Column Name      | Type    |
| ---------------- | ------- |
| employee_id      | int     |
| name             | varchar |
| experience_years | int     |

employee_id is the primary key of this table. It's guaranteed that experience_years is not NULL.
Each row of this table contains information about one employee.

## Solutions

```sql
SELECT
    project_id,
    ROUND(AVG(CAST(experience_years AS DECIMAL)), 2) AS average_years
FROM Project p
INNER JOIN Employee e
    ON p.employee_id = e.employee_id
GROUP BY project_id;
```

## Result set

| project_id | average_years |
| ---------- | ------------- |
| 1          | 2             |
| 2          | 2.5           |