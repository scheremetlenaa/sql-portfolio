# [Population Density Difference](https://www.hackerrank.com/challenges/population-density-difference/)

## Table Of Contents
1. [Problem Statement](#problem-statement)
2. [Datasets used](#datasets-used)
3. [Solutions](#solutions)
4. [Result set](#result-set)

## Problem Statement

Query the difference between the maximum and minimum populations in CITY.

## Datasets used

```CITY``` Table:

| Field       | Type         |
| ----------- | ------------ |
| ID          | NUMBER       |
| NAME        | VARCHAR2(17) |
| COUNTRYCODE | VARCHAR2(3)  |
| DISTRICT    | VARCHAR2(20) |
| POPULATION  | NUMBER       |

## Solutions

```sql
SELECT 
    MAX(POPULATION) - MIN(POPULATION)
FROM CITY;
```

## Result set

|         |
| ------- |
| 4695354 |