# [Minimum GPA](https://www.interviewbit.com/problems/minimum-gpa/)

## Table Of Contents
1. [Problem Statement](#problem-statement)
2. [Datasets used](#datasets-used)
3. [Solutions](#solutions)
4. [Result set](#result-set)

## Problem Statement

Given 2 tables ‘Students’ and ‘Departments’. Write an SQL query to find the students who has the Lowest GPA in each of the departments. 

## Datasets used

```Students``` Table:

| Field        | Type    |
| ------------ | ------- |
| Id           | INT     |
| Name         | Varchar |
| GPA          | Float   |
| DepartmentId | INT     |

```Departments``` Table:

| Field          | Type    |
| -------------- | ------- |
| DepartmentId   | INT     |
| DepartmentName | Varchar |

## Solutions

```sql
WITH CTE AS (
    SELECT
        D.DepartmentName,
        S.Name,
        S.GPA,
        RANK() OVER(PARTITION BY D.DepartmentName ORDER BY S.GPA) AS rnk
    FROM Students S
    LEFT JOIN DEPARTMENTS D
        ON S.DepartmentId = D.DepartmentId
)

SELECT
    CONCAT(DepartmentName, ',', Name, ',', GPA) AS A
FROM CTE
WHERE rnk = 1;
```

## Result set

| **A**            |
| ---------------- |
| CSE,Shandie,1.02 |
| CVE,Leia,1.5     |
| ECE,Siana,3.94   |
| EEE,Mady,2.35    |
| MECH,Tybie,1.13  |