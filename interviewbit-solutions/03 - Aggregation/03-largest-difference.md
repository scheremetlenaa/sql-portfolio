# [Largest Difference](https://www.interviewbit.com/problems/largest-difference/)

## Table Of Contents
1. [Problem Statement](#problem-statement)
2. [Datasets used](#datasets-used)
3. [Solutions](#solutions)
4. [Result set](#result-set)

## Problem Statement

Given a table FIREFIGHTERS, find the largest difference between the number of people saved by 2 firefighters.

## Datasets used

```FIREFIGHTERS``` Table:

| Field       | Type         |
| ----------- | ------------ |
| ID          | INT          |
| Name        | VARCHAR(255) |
| Country     | VARCHAR(255) |
| CountryCode | VARCHAR(255) |
| PeopleSaved | INT          |

## Solutions

```sql
SELECT
    MAX(PeopleSaved) - MIN(PeopleSaved) AS A
FROM FIREFIGHTERS;
```

## Result set

| **A** |
| ----- |
| 480   |