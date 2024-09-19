# [Euclid's Distance](https://www.interviewbit.com/problems/euclid-s-distance/)

## Table Of Contents
1. [Problem Statement]()
2. [Datasets used]()
3. [Solutions]()
4. [Result set]()

## Problem Statement

Given a table HOUSES, find the euclidean distance between points with the largest X and Y coordinate, and the points with the smallest X and Y coordinate.

The Euclidean Distance between 2 points P(x1, y1) and Q(x2, y2) is defined as: sqrt((x1 - x2)2 + (y1 - y2)2).

## Datasets used

```HOUSES``` Table:

| Field       | Type         |
| ----------- | ------------ |
| ID          | INT          |
| Owner       | VARCHAR(255) |
| XCoordinate | INT          |
| YCoordinate | INT          |

## Solutions

```sql
SELECT
    SQRT(POW(MAX(XCoordinate) - MIN(XCoordinate), 2) + POW(MAX(YCoordinate) - MIN(YCoordinate), 2)) AS A
FROM HOUSES;
```

## Result set

| **A**             |
| ----------------- |
| 1362.749059805216 |