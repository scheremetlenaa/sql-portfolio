# [Many Tables](https://www.interviewbit.com/problems/many-tables/)

## Table Of Contents
1. [Problem Statement]()
2. [Datasets used]()
3. [Solutions]()
4. [Result set]()

## Problem Statement

Given 2 tables ENGINEER and DATA, query for the total count of each Type in the ENGINEER table. Print the result in alphabetical order of the Type.

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
GROUP BY Type;
```

## Result set

| **A** |
| ----- |
| 214   |
| 294   |
| 301   |
| 307   |