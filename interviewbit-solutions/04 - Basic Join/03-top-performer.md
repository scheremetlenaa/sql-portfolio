# [Top Performer](https://www.interviewbit.com/problems/top-performer/)

## Table Of Contents
1. [Problem Statement](#problem-statement)
2. [Datasets used](#datasets-used)
3. [Solutions](#solutions)
4. [Result set](#result-set)

## Problem Statement

Given 2 tables EMPLOYEE and EVALUATION, build a report containing the 2 columns, Name and Rating. Employees with Ratings less than 6 should appear as NULL in the table. The entries in the table should be sorted by descending order of Rating, followed by Names in lexicographic order.

## Datasets used

```EMPLOYEE``` Table:

| Field  | Type         |
| ------ | ------------ |
| ID     | INT          |
| Name   | VARCHAR(255) |
| Points | INT          |

```EVALUATION``` Table:

| Field  | Type |
| ------ | ---- |
| Rating | INT  |
| Lower  | INT  |
| Upper  | INT  |

## Solutions

```sql
SELECT
    CASE
        WHEN EV.Rating < 6 THEN NULL
        ELSE EM.Name
    END AS Names,
    EV.Rating AS Rating
FROM EMPLOYEE EM
LEFT JOIN EVALUATION EV
    ON EM.Points BETWEEN EV.Lower AND EV.Upper
ORDER BY EV.Rating DESC, EM.Name;
```

## Result set

| **Names** | **Rating** |
| --------- | ---------- |
| Alyssa    | 10         |
| Keelia    | 9          |
| Shannah   | 9          |
| Jere      | 7          |
| Romona    | 7          |
| Corry     | 6          |
| NULL      | 5          |
| NULL      | 5          |
| NULL      | 5          |
| NULL      | 5          |
| NULL      | 4          |
| NULL      | 4          |
| NULL      | 4          |
| NULL      | 3          |
| NULL      | 3          |
| NULL      | 3          |
| NULL      | 3          |
| NULL      | 1          |
| NULL      | 1          |
| NULL      | 1          |