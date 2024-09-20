# [177. Nth Highest Salary](https://leetcode.com/problems/nth-highest-salary/description/)

## Table Of Contents
1. [Problem Statement]()
2. [Datasets used]()
3. [Solutions]()
4. [Result set]()

## Problem Statement

Write a solution to find the nth highest salary from the Employee table. If there is no nth highest salary, return null.

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
CREATE FUNCTION getNthHighestSalary(@N INT) RETURNS INT AS
BEGIN
    RETURN (
            SELECT
                MAX(salary)
            FROM (
                SELECT
                    id,
                    salary,
                    DENSE_RANK() OVER(ORDER BY salary DESC) AS rnk
                FROM Employee
                ) t1
            WHERE rnk = @N
    )
END
```

## Result set

| getNthHighestSalary(2) |
| ---------------------- |
| 200                    |