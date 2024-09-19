# [Low and High Grades](https://www.interviewbit.com/problems/low-and-high-grades/)

## Table Of Contents
1. [Problem Statement]()
2. [Datasets used]()
3. [Solutions]()
4. [Result set]()

## Problem Statement

Given 2 tables EMPLOYEE and EVALUATION, query for the count of names whose Rating is less than 3. Also, query for the count of names whose Rating is greater than 8.

## Datasets used

| Field  | Type         |
| ------ | ------------ |
| ID     | INT          |
| Name   | VARCHAR(255) |
| Points | INT          |

```EVALUATION``` Table:

| Field  | Type |
| ------ | ---- |
| Rating | INT  |
| Lower  | INT  |
| Upper  | INT  |

## Solutions

```sql
SELECT
    COUNT(Name)
FROM EMPLOYEE EM
LEFT JOIN EVALUATION EV
    ON EM.Points BETWEEN EV.Lower AND EV.Upper
WHERE Rating < 3;

SELECT
    COUNT(Name)
FROM EMPLOYEE EM
LEFT JOIN EVALUATION EV
    ON EM.Points BETWEEN EV.Lower AND EV.Upper
WHERE Rating > 8;
```

## Result set

| **COUNT(Name)** |
| --------------- |
| 3               |
| COUNT(Name)     |
| 3               |