# [Class Average](https://www.interviewbit.com/problems/class-average/)

## Table Of Contents
1. [Problem Statement]()
2. [Datasets used]()
3. [Solutions]()
4. [Result set]()

## Problem Statement

You are given a table ‘Students’ which consists of the marks that students from different classes obtained in the final exam. Write an SQL query to find for each departments the number of students who managed to score above total average (average considering students of all classes) . The output should be sorted by ClassId .

## Datasets used

```Students``` Table:

| Field   | Type    |
| ------- | ------- |
| Id      | INT     |
| Name    | VARCHAR |
| Marks   | INT     |
| ClassId | INT     |

## Solutions

```sql
SELECT
    COUNT(*) AS A
FROM Students
WHERE Marks > (SELECT AVG(Marks) FROM Students)
GROUP BY ClassId;
```

## Result set

| **A** |
| ----- |
| 3     |
| 7     |
| 3     |
| 5     |
| 5     |