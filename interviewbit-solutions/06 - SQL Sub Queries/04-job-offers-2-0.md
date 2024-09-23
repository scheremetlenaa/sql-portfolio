# [Job Offers 2.0](https://www.interviewbit.com/problems/job-offers-2-0/)

## Table Of Contents
1. [Problem Statement](#problem-statement)
2. [Datasets used](#datasets-used)
3. [Solutions](#solutions)
4. [Result set](#result-set)

## Problem Statement

You are given 3 tables namely ‘Students’ , ‘Departments’ and ‘Jobs’.

Write an SQL query to find sum of Distinct salaries obtained by students from ‘CSE’ department. The output should be sorted by the Department names.

Note: There might be students who have got multiple job offers.

## Datasets used

```Students``` Table:

| Field        | Type    |
| ------------ | ------- |
| Id           | INT     |
| Name         | VARCHAR |
| DepartmentId | INT     |

```Departments``` Table:

| Field          | Type    |
| -------------- | ------- |
| DepartmentId   | INT     |
| DepartmentName | Varchar |

```Jobs``` Table:

| Field  | Type |
| ------ | ---- |
| Id     | INT  |
| Salary | INT  |

## Solutions

```sql
SELECT
    SUM(DISTINCT Salary) AS Salary
FROM Students s
INNER JOIN Departments d
    ON s.DepartmentId = d.DepartmentId
    AND DepartmentName = 'CSE'
INNER JOIN Jobs j
    ON s.Id = j.Id;
```

## Result set

| **Salary** |
| ---------- |
| 736147     |