# [Next And Previous](https://www.interviewbit.com/problems/next-and-previous/)

## Table Of Contents
1. [Problem Statement]()
2. [Datasets used]()
3. [Solutions]()
4. [Result set]()

## Problem Statement

Given a table Students. Write an SQL qurey to find for all students the marks which are immediately greater than the student’s marks . The output should have 1 column ‘Next’ and should contain the marks which are immediately greater than the student’s marks for each student which are Sorted by their Name.

## Datasets used

```Students``` Table:

| Field | Type    |
| ----- | ------- |
| Id    | INT     |
| Name  | Varchar |
| Marks | Varchar |

## Solutions

```sql
SELECT 
    LEAD(Marks) OVER (ORDER BY Marks) AS Next
FROM Students
ORDER BY Name;
```

## Result set

| **Next** |
| -------- |
| 3        |
| 43       |
| 68       |
| 38       |
| 92       |
| 9        |
| 60       |
| 28       |
| 69       |
| 67       |
| 65       |
| 74       |
| 35       |
| 28       |
| 69       |
| 74       |
| 85       |
| 67       |
| 96       |
| 5        |
| 43       |
| 50       |
| 91       |
| 32       |
| 27       |
| 69       |
| 65       |
| 91       |
| 52       |
| 58       |
| 60       |
| 73       |
| 92       |
| 96       |
| 78       |
| 3        |
| 5        |
| 22       |
| 11       |
| 83       |
| 16       |
| 61       |
| 48       |
| 92       |
| 58       |
| 6        |
| 32       |
| 60       |
| 18       |
| 37       |
| 83       |
| 6        |
| 77       |
| 95       |
| 70       |
| NULL     |
| 59       |
| 79       |
| 25       |
| 35       |