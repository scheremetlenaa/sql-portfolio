# [Revising Aggregations - The Sum Function](https://www.hackerrank.com/challenges/revising-aggregations-sum/)

## Table Of Contents
1. [Problem Statement]()
2. [Datasets used]()
3. [Solutions]()
4. [Result set]()

## Problem Statement

Query the total population of all cities in CITY where District is California.

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
    SUM(POPULATION)
FROM CITY
WHERE DISTRICT = 'California';
```

## Result set

|        |
| ------ |
| 339002 |