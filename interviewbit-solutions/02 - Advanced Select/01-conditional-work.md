# [Conditional Work](https://www.interviewbit.com/problems/conditional-work/)

## Table Of Contents
1. [Problem Statement](#problem-statement)
2. [Datasets used](#datasets-used)
3. [Solutions](#solutions)
4. [Result set](#result-set)

## Problem Statement

Given a table NUMBERS, determine for each row, if the sum of the numbers are ‘Positive’, ‘Negative’, or ‘Zero’.

## Datasets used

```NUMBERS``` Table:

| Field | Type |
| ----- | ---- |
| A     | INT  |
| B     | INT  |
| C     | INT  |

## Solutions

```sql
SELECT
    CASE
        WHEN (A + B + C) > 0 THEN 'Positive'
        WHEN (A + B + C) < 0 THEN 'Negative'
        ELSE 'Zero'
    END AS A
FROM NUMBERS;
```

## Result set

| **A**    |
| -------- |
| Negative |
| Negative |
| Zero     |
| Negative |
| Positive |
| Positive |
| Positive |
| Negative |
| Positive |
| Negative |
| Negative |
| Negative |
| Negative |
| Negative |
| Negative |
| Positive |
| Negative |
| Positive |
| Negative |
| Positive |
| Positive |
| Positive |
| Positive |
| Positive |
| Negative |
| Positive |
| Negative |
| Negative |
| Positive |
| Negative |
| Positive |
| Positive |
| Positive |
| Negative |
| Positive |
| Negative |
| Negative |
| Zero     |
| Positive |
| Positive |
| Positive |
| Positive |
| Negative |
| Positive |
| Positive |
| Negative |
| Positive |
| Negative |
| Negative |
| Negative |
| Positive |
| Negative |
| Negative |
| Negative |
| Negative |
| Positive |
| Negative |
| Negative |
| Negative |
| Positive |
| Negative |
| Positive |
| Positive |
| Positive |
| Positive |
| Positive |
| Positive |
| Negative |
| Negative |
| Positive |
| Negative |
| Negative |
| Negative |
| Positive |
| Positive |
| Negative |
| Positive |
| Negative |
| Negative |
| Positive |
| Negative |
| Positive |
| Positive |
| Negative |
| Negative |
| Negative |
| Negative |
| Positive |
| Negative |
| Negative |
| Positive |
| Positive |
| Negative |
| Positive |
| Positive |
| Positive |
| Negative |
| Zero     |
| Negative |
| Positive |