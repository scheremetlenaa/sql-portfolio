# [197. Rising Temperature](https://leetcode.com/problems/rising-temperature/description/)

## Table Of Contents
1. [Problem Statement](#problem-statement)
2. [Datasets used](#datasets-used)
3. [Solutions](#solutions)
4. [Result set](#result-set)

## Problem Statement

Write a solution to find all dates' id with higher temperatures compared to its previous dates (yesterday).

Return the result table in any order.

## Datasets used

```Weather``` Table:

| Column Name   | Type    |
| ------------- | ------- |
| id            | int     |
| recordDate    | date    |
| temperature   | int     |

id is the column with unique values for this table.
There are no different rows with the same recordDate.
This table contains information about the temperature on a certain day.

## Solutions

```sql
SELECT w1.id
FROM weather w1
INNER JOIN weather w2
    ON w1.recordDate = DATEADD(DAY, 1, w2.recordDate)
WHERE w1.temperature > w2.temperature;
```

## Result set

| id |
| -- |
| 2  |
| 4  |