# [Symmetric Pairs](https://www.hackerrank.com/challenges/symmetric-pairs/)

## Table Of Contents
1. [Problem Statement](#problem-statement)
2. [Datasets used](#datasets-used)
3. [Solutions](#solutions)
4. [Result set](#result-set)

## Problem Statement

Write a query to output all such symmetric pairs in ascending order by the value of X. List the rows such that X1 ≤ Y1.

## Datasets used

```Functions``` Table:

| Column | Type    |
| ------ | ------- |
| X      | Integer |
| Y      | Integer |

Two pairs (X1, Y1) and (X2, Y2) are said to be symmetric pairs if X1 = Y2 and X2 = Y1.

## Solutions

```sql
SELECT
    f1.X,
    f1.Y
FROM Functions f1
INNER JOIN Functions f2
    ON f1.X = f2.Y AND f1.Y = f2.X
GROUP BY f1.X, f1.Y
HAVING COUNT(*) > 1 OR f1.X < f1.Y
ORDER BY f1.X;
```

## Result set

| X  | Y  |
| -- | -- |
| 2  | 24 |
| 4  | 22 |
| 5  | 21 |
| 6  | 20 |
| 8  | 18 |
| 9  | 17 |
| 11 | 15 |
| 13 | 13 |