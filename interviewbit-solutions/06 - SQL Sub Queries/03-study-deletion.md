# [Study Deletion](https://www.interviewbit.com/problems/study-deletion/)

## Table Of Contents
1. [Problem Statement](#problem-statement)
2. [Datasets used](#datasets-used)
3. [Solutions](#solutions)
4. [Result set](#result-set)

## Problem Statement

Given a table STUDY, delete all the entries in the table where the AGE of the students lies between 19-22. Then print the new table.

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
DELETE FROM STUDY
WHERE Age BETWEEN 19 AND 22;

SELECT * FROM STUDY;
```

## Result set

| **ID** | **Name**  | **Age** | **Marks** |
| ------ | --------- | ------- | --------- |
| 1      | Betta     | 24      | 19        |
| 4      | Trudie    | 23      | 79        |
| 5      | Leona     | 18      | 43        |
| 8      | Magdalena | 24      | 71        |
| 9      | Chastity  | 23      | 84        |
| 11     | Roslyn    | 18      | 44        |
| 14     | Minda     | 18      | 89        |
| 15     | Georgetta | 24      | 12        |
| 20     | Melanie   | 23      | 69        |
| 21     | Lynde     | 23      | 84        |
| 24     | Sara-Ann  | 23      | 61        |
| 31     | Estell    | 23      | 69        |
| 32     | Agathe    | 23      | 40        |
| 42     | Augustine | 18      | 73        |
| 46     | Alexine   | 23      | 29        |
| 47     | Fayre     | 23      | 1         |