# [Distance Maximizer](https://www.interviewbit.com/problems/distance-maximizer/)

## Table Of Contents
1. [Problem Statement]()
2. [Datasets used]()
3. [Solutions]()
4. [Result set]()

## Problem Statement

Given a table HOUSES, find the manhattan distance of the house which is the farthest from John’s house which lies at coordinates (20, 4).

Basically you have to find the manhattan distance of some house which is the maximum amongst all the other houses from John’s house.

Manhattan Distance between 2 points P(x1, y1), Q(x2, y2) is given as |x1 - x2| + |y1 - y2|.

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
   MAX(ABS(XCoordinate - 20) + ABS(YCoordinate - 4)) AS A
FROM HOUSES;
```

## Result set

| **A** |
| ----- |
| 1922  |