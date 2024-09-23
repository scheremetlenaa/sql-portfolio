# [Higher Than 75 Marks](https://www.hackerrank.com/challenges/more-than-75-marks/)

## Table Of Contents
1. [Problem Statement](#problem-statement)
2. [Datasets used](#datasets-used)
3. [Solutions](#solutions)
4. [Result set](#result-set)

## Problem Statement

Query the Name of any student in STUDENTS who scored higher than 75 Marks. Order your output by the last three characters of each name. If two or more students both have names ending in the same last three characters (i.e.: Bobby, Robby, etc.), secondary sort them by ascending ID.

## Datasets used

```STUDENTS``` Table:

| Column | Type    |
|--------|---------|
| ID     | Integer |
| Name   | String  |
| Marks  | Integer |

## Solutions

```sql
SELECT
    Name
From STUDENTS
Where Marks > 75
ORDER BY RIGHT(Name, 3), ID;
```

## Result set

| Name      |
|-----------|
| Stuart    |
| Kristeen  |
| Christene |
| Amina     |
| Aamina    |
| Priya     |
| Heraldo   |
| Scarlet   |
| Julia     |
| Salma     |
| Britney   |
| Priyanka  |
| Samantha  |
| Vivek     |
| Belvet    |
| Devil     |
| Evil      |