# [Student Query](https://www.interviewbit.com/problems/student-query/)

## Table Of Contents
1. [Problem Statement]()
2. [Datasets used]()
3. [Solutions]()
4. [Result set]()

## Problem Statement

Given a table STUDENT, query for all the Names with Class 1 and SubjectCount greater than 3.

## Datasets used

```STUDENT``` Table:

| Field        | Type         |
| ------------ | ------------ |
| ID           | INT          |
| Name         | VARCHAR(255) |
| Class        | INT          |
| SubjectCount | INT          |

## Solutions

```sql
SELECT
    Name
FROM STUDENT
WHERE Class = 1
AND SubjectCount > 3;
```

## Result set

| **Name** |
| -------- |
| Maxi     |