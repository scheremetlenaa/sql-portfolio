# [Job Offer](https://www.interviewbit.com/problems/job-offer/)

## Table Of Contents
1. [Problem Statement](#problem-statement)
2. [Datasets used](#datasets-used)
3. [Solutions](#solutions)
4. [Result set](#result-set)

## Problem Statement

You are given 3 tables namely ‘Students’ , ‘Departments’ and ‘Jobs’.

Write an SQL query to find for each student their name and the date of the job offer. The output should be sorted by Department Names. Note that there might be students who did not receive a single offer, in such cases you should not include them in the output table.

## Datasets used

```Students``` Table:

| Field        | Type    |
| ------------ | ------- |
| Id           | INT     |
| Name         | Varchar |
| DepartmentId | INT     |

```Departments``` Table:

| Field          | Type    |
| -------------- | ------- |
| DepartmentId   | INT     |
| DepartmentName | Varchar |

```Jobs``` Table:

| Field | Type |
| ----- | ---- |
| Id    | INT  |
| Date  | DATE |

## Solutions

```sql
SELECT
    CONCAT(s.Name, ',', j.Date) AS Offers
FROM Students s
INNER JOIN Jobs j
    ON s.Id = j.Id
INNER JOIN Departments d
    ON s.DepartmentId = d.DepartmentId
ORDER BY DepartmentName;
```

## Result set

| **Offers**           |
| -------------------- |
| Evita,2022-11-12     |
| Almeta,2022-11-12    |
| Sallie,2022-11-11    |
| Queenie,2022-11-14   |
| Marsiella,2022-11-11 |
| Nelle,2022-11-11     |
| Lisette,2022-11-12   |
| Augustine,2022-11-14 |
| Gretal,2022-11-11    |
| Lynde,2022-11-14     |
| Tybie,2022-11-13     |
| Steffane,2022-11-13  |