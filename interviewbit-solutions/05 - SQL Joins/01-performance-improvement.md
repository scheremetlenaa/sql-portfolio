# [Performance Improvement](https://www.interviewbit.com/problems/performance-improvement/)

## Table Of Contents
1. [Problem Statement]()
2. [Datasets used]()
3. [Solutions]()
4. [Result set]()

## Problem Statement

You are given a table having the marks of one student in every test (Tests are held every day). You have to output the tests in which the student has improved his performance. For a student to improve his performance he has to score more than the previous test. Given that TestIDs are in increasing order, forming a continuous sequence without any missing numbers.

## Datasets used

```Tests``` Table:

| Field  | Type |
| ------ | ---- |
| TestId | INT  |
| Marks  | INT  |

## Solutions

```sql
SELECT 
    T2.TestId
FROM Tests T1
INNER JOIN Tests T2
    ON T1.TestId = T2.TestId - 1 
    AND T1.marks < T2.marks;
```

## Result set

| **TestId** |
| ---------- |
| 104        |
| 106        |
| 107        |
| 108        |
| 109        |
| 111        |
| 112        |
| 113        |
| 115        |
| 116        |
| 118        |
| 120        |
| 122        |
| 123        |
| 125        |
| 126        |
| 128        |
| 129        |
| 131        |
| 134        |
| 136        |
| 137        |
| 138        |
| 139        |
| 142        |
| 144        |
| 146        |
| 148        |
| 149        |