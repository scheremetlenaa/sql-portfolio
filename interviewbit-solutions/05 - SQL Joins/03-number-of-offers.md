# [Number of offers](https://www.interviewbit.com/problems/number-of-offers/)

## Table Of Contents
1. [Problem Statement]()
2. [Datasets used]()
3. [Solutions]()
4. [Result set]()

## Problem Statement

Given 2 tables ‘Students’ and ‘Jobs’, write an SQL query to find for every student the number of offers they got in the month of November. The output should contain 1 coloumn by the name ‘Job_Offers’ which should contain the number of jobs received by each of the student in the month of November. Also it should be sorted by the Id of the students.

## Datasets used

```Students``` Table:

| Field | Type    |
| ----- | ------- |
| Id    | INT     |
| Name  | Varchar |

```Jobs``` Table:

| Field  | Type |
| ------ | ---- |
| Id     | INT  |
| Date   | DATE |
| Salary | INT  |

## Solutions

```sql
SELECT 
    COUNT(IF(MONTH(j.Date) = 11, j.id, NULL)) AS Job_Offers 
FROM Students s
LEFT JOIN Jobs j on 
    s.Id = j.Id
GROUP BY s.id
ORDER BY s.Id;
```

## Result set

| **Job_Offers** |
| -------------- |
| 0              |
| 1              |
| 0              |
| 2              |
| 0              |
| 1              |
| 2              |
| 2              |
| 0              |
| 0              |
| 1              |
| 1              |
| 1              |
| 0              |
| 0              |
| 1              |
| 0              |
| 1              |
| 0              |
| 1              |
| 0              |
| 3              |
| 2              |
| 0              |
| 0              |
| 0              |
| 0              |
| 0              |
| 0              |
| 1              |
| 0              |
| 2              |
| 1              |
| 1              |
| 0              |
| 3              |
| 1              |
| 3              |
| 0              |
| 0              |
| 1              |
| 1              |
| 0              |
| 1              |
| 0              |
| 1              |
| 1              |
| 3              |
| 0              |
| 1              |