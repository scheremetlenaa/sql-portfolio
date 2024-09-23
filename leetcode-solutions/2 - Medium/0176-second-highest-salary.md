# [176. Second Highest Salary](https://leetcode.com/problems/second-highest-salary/description/)

## Table Of Contents
1. [Problem Statement](#problem-statement)
2. [Datasets used](#datasets-used)
3. [Solutions](#solutions)
4. [Result set](#result-set)

## Problem Statement

Write a solution to find the second highest distinct salary from the Employee table. If there is no second highest salary, return null (return None in Pandas).

## Datasets used

```Employee``` Table:

| Column Name | Type |
| ----------- | ---- |
| id          | int  |
| salary      | int  |

id is the primary key (column with unique values) for this table.
Each row of this table contains information about the salary of an employee.

## Solutions

```sql
SELECT
    MAX(salary) AS SecondHighestSalary
FROM (
    SELECT
        id,
        salary,
        DENSE_RANK() OVER(ORDER BY salary DESC) AS rnk
    FROM Employee
    ) t1
WHERE rnk = 2;
```

## Result set

| SecondHighestSalary |
| ------------------- |
| 200                 |