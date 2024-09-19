# [Big Salary](https://www.interviewbit.com/problems/big-salary/)

## Table Of Contents
1. [Problem Statement]()
2. [Datasets used]()
3. [Solutions]()
4. [Result set]()

## Problem Statement

Given a table WORKERS, find how many workers have the maximum total earnings among all the workers.

The total earnings of a worker is calculated as Daily Wage * Number of Days Worked.

## Datasets used

```WORKERS``` Table:

| Field      | Type         |
| ---------- | ------------ |
| ID         | INT          |
| Name       | VARCHAR(255) |
| DailyWage  | INT          |
| DaysWorked | INT          |

## Solutions

```sql
SELECT
    COUNT(Name) AS A
FROM WORKERS
WHERE DailyWage*DaysWorked = (SELECT MAX(DailyWage*DaysWorked) FROM WORKERS);
```

## Result set

| **A** |
| ----- |
| 1     |