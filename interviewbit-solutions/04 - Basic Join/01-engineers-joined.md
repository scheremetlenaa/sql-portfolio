# [Engineers Joined](https://www.interviewbit.com/problems/engineers-joined/)

## Table Of Contents
1. [Problem Statement]()
2. [Datasets used]()
3. [Solutions]()
4. [Result set]()

## Problem Statement

Given 2 tables ENGINEER and DATA, query the sum of Count of all the engineers whose Type is FrontEnd.

## Datasets used

```ENGINEER``` Table:

| Field      | Type         |
| ---------- | ------------ |
| ID         | INT          |
| Name       | VARCHAR(255) |
| Department | VARCHAR(255) |
| Count      | INT          |

```DATA``` Table:

| Field | Type         |
| ----- | ------------ |
| ID    | INT          |
| Name  | VARCHAR(255) |
| Type  | VARCHAR(255) |

## Solutions

```sql
SELECT
    SUM(Count) AS A
FROM ENGINEER e
INNER JOIN DATA d
    ON e.ID = d.ID
WHERE Type = 'FrontEnd';
```

## Result set

| **A** |
| ----- |
| 294   |