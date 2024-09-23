# [Revising Aggregations - Averages](https://www.hackerrank.com/challenges/revising-aggregations-the-average-function/)

## Table Of Contents
1. [Problem Statement](#problem-statement)
2. [Datasets used](#datasets-used)
3. [Solutions](#solutions)
4. [Result set](#result-set)

## Problem Statement

Query the average population of all cities in CITY where District is California.

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
    AVG(POPULATION)
FROM CITY
WHERE DISTRICT = 'California';
```

## Result set

|            |
| ---------- |
| 113000.667 |