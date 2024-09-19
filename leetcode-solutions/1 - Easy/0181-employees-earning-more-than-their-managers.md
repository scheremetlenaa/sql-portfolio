# [181. Employees Earning More Than Their Managers](https://leetcode.com/problems/employees-earning-more-than-their-managers/description/)

## Table Of Contents
1. [Problem Statement]()
2. [Datasets used]()
3. [Solutions]()
4. [Result set]()

## Problem Statement

Write a solution to find the employees who earn more than their managers.

Return the result table in any order.

## Datasets used

```Employee``` Table:

| Column Name | Type    |
| ----------- | ------- |
| id          | int     |
| name        | varchar |
| salary      | int     |
| managerId   | int     |

id is the primary key (column with unique values) for this table.
Each row of this table indicates the ID of an employee, their name, salary, and the ID of their manager.


## Solutions

```sql
SELECT e.name AS Employee
FROM Employee m
INNER JOIN Employee e
    ON m.id = e.managerId
    WHERE e.salary > m.salary
```

## Result set

| Employee |
| -------- |
| Joe      |