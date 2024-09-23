# [Select By ID](https://www.hackerrank.com/challenges/select-by-id/)

## Table Of Contents
1. [Problem Statement](#problem-statement)
2. [Datasets used](#datasets-used)
3. [Solutions](#solutions)
4. [Result set](#result-set)

## Problem Statement

Query all columns for a city in CITY with the ID 1661.

## Datasets used

```CITY``` Table:

| Field       | Type         |
|-------------|--------------|
| ID          | NUMBER       |
| NAME        | VARCHAR2(17) |
| COUNTRYCODE | VARCHAR2(3)  |
| DISTRICT    | VARCHAR2(20) |
| POPULATION  | NUMBER       |

## Solutions

```sql
SELECT * 
FROM CITY
WHERE ID = 1661;
```

## Result set

| ID   | NAME   | COUNTRYCODE | DISTRICT | POPULATION |
|------|--------|-------------|----------|------------|
| 1661 | Sayama | JPN         | Saitama  | 162472     |