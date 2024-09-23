# [610. Triangle Judgement](https://leetcode.com/problems/triangle-judgement/description/)

## Table Of Contents
1. [Problem Statement](#problem-statement)
2. [Datasets used](#datasets-used)
3. [Solutions](#solutions)
4. [Result set](#result-set)

## Problem Statement

Report for every three line segments whether they can form a triangle.

Return the result table in any order.

## Datasets used

```Triangle``` Table:

| Column Name | Type |
| ----------- | ---- |
| x           | int  |
| y           | int  |
| z           | int  |

In SQL, (x, y, z) is the primary key column for this table.
Each row of this table contains the lengths of three line segments.

## Solutions

```sql
SELECT
x, y, z,
CASE
    WHEN (x + y) > z AND (x + z) > y AND (y + z) > x THEN 'Yes'
    ELSE 'No'
END AS triangle
FROM Triangle;
```

## Result set

| x  | y  | z  | triangle |
| -- | -- | -- | -------- |
| 13 | 15 | 30 | No       |
| 10 | 20 | 15 | Yes      |