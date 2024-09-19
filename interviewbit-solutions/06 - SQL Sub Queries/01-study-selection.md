# [Study Selection](https://www.interviewbit.com/problems/study-selection/)

## Table Of Contents
1. [Problem Statement]()
2. [Datasets used]()
3. [Solutions]()
4. [Result set]()

## Problem Statement

Given a table STUDY, query for all the attributes, which have marks greater than 80.

## Datasets used

```STUDY``` Table:

| Field | Type         |
| ----- | ------------ |
| ID    | INT          |
| Name  | VARCHAR(255) |
| Age   | INT          |
| Marks | INT          |

## Solutions

```sql
SELECT
    *
FROM STUDY
WHERE Marks > 80;
```

## Result set

| **ID** | **Name**  | **Age** | **Marks** |
| ------ | --------- | ------- | --------- |
| 3      | Maryellen | 22      | 83        |
| 9      | Chastity  | 23      | 84        |
| 14     | Minda     | 18      | 89        |
| 18     | Rori      | 19      | 88        |
| 21     | Lynde     | 23      | 84        |
| 28     | Mary      | 22      | 97        |
| 33     | Arlina    | 20      | 96        |
| 48     | Etta      | 19      | 100       |