# [180. Consecutive Numbers](https://leetcode.com/problems/consecutive-numbers/description/)

## Table Of Contents
1. [Problem Statement](#problem-statement)
2. [Datasets used](#datasets-used)
3. [Solutions](#solutions)
4. [Result set](#result-set)

## Problem Statement

Find all numbers that appear at least three times consecutively.

Return the result table in any order.

## Datasets used

```Logs``` Table:

| Column Name | Type    |
| ----------- | ------- |
| id          | int     |
| num         | varchar |

In SQL, id is the primary key for this table.
id is an autoincrement column starting from 1.

## Solutions

```sql
SELECT 
    DISTINCT l1.num AS ConsecutiveNums 
FROM Logs l1
INNER JOIN Logs l2 
    ON l1.id = l2.id - 1
INNER JOIN Logs l3 
    ON l1.id = l3.id - 2
WHERE l1.num = l2.num
AND l2.num = l3.num;
```

## Result set

| ConsecutiveNums |
| --------------- |
| 1               |