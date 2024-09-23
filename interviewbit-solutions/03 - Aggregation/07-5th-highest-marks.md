# [5'th Highest Marks](https://www.interviewbit.com/problems/5-th-highest-marks/)

## Table Of Contents
1. [Problem Statement](#problem-statement)
2. [Datasets used](#datasets-used)
3. [Solutions](#solutions)
4. [Result set](#result-set)

## Problem Statement

Given the ‘STUDENTS’ table. Write an SQL query to find the 5’th highest marks in the students table.

## Datasets used

```STUDENTS``` Table:

| Field | Type |
| ----- | ---- |
| Id    | INT  |
| MARKS | INT  |

## Solutions

```sql
SELECT 
    MARKS
FROM (SELECT MARKS FROM STUDENTS ORDER BY MARKS DESC LIMIT 5) t1
ORDER BY MARKS
LIMIT 1;
```

## Result set

| **MARKS** |
| --------- |
| 94        |