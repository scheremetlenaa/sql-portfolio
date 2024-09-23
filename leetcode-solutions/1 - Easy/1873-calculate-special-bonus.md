# [1873. Calculate Special Bonus](https://leetcode.com/problems/calculate-special-bonus/description/)

## Table Of Contents
1. [Problem Statement](#problem-statement)
2. [Datasets used](#datasets-used)
3. [Solutions](#solutions)
4. [Result set](#result-set)

## Problem Statement

Write a solution to calculate the bonus of each employee. The bonus of an employee is 100% of their salary if the ID of the employee is an odd number and the employee's name does not start with the character 'M'. The bonus of an employee is 0 otherwise.

Return the result table ordered by employee_id.

## Datasets used

```Employees``` Table:

| Column Name | Type    |
| ----------- | ------- |
| employee_id | int     |
| name        | varchar |
| salary      | int     |

employee_id is the primary key (column with unique values) for this table.
Each row of this table indicates the employee ID, employee name, and salary.

## Solutions

```sql
SELECT
    employee_id,
    CASE
        WHEN employee_id % 2 = 0 OR LEFT(name, 1) = 'M' THEN 0
        ELSE salary
    END AS bonus
FROM Employees
ORDER BY employee_id;
```

## Result set

| employee_id | bonus |
| ----------- | ----- |
| 2           | 0     |
| 3           | 0     |
| 7           | 7400  |
| 8           | 0     |
| 9           | 7700  |