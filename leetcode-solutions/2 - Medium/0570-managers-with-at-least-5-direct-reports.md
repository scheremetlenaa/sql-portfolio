# [570. Managers with at Least 5 Direct Reports](https://leetcode.com/problems/managers-with-at-least-5-direct-reports/description/)

## Table Of Contents
1. [Problem Statement](#problem-statement)
2. [Datasets used](#datasets-used)
3. [Solutions](#solutions)
4. [Result set](#result-set)

## Problem Statement

Write a solution to find managers with at least five direct reports.

Return the result table in any order.

## Datasets used

```Employee``` Table:

| Column Name | Type    |
| ------------| ------- |
| id          | int     |
| name        | varchar |
| department  | varchar |
| managerId   | int     |

id is the primary key (column with unique values) for this table.
Each row of this table indicates the name of an employee, their department, and the id of their manager.
If managerId is null, then the employee does not have a manager.
No employee will be the manager of themself.

## Solutions

```sql
SELECT
    name
FROM Employee
WHERE id IN (
    SELECT
        managerId
    FROM Employee
    GROUP BY managerId
    HAVING COUNT(*) >= 5
);
```

## Result set

| name |
| ---- |
| John |