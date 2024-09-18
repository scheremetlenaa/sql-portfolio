# [Average Population](https://www.hackerrank.com/challenges/average-population/)

## Table Of Contents
1. [Problem Statement]()
2. [Datasets used]()
3. [Solutions]()
4. [Result set]()

## Problem Statement

Query the average population for all cities in CITY, rounded down to the nearest integer.

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
    ROUND(AVG(POPULATION), 0)
FROM CITY;
```

## Result set

|        |
| ------ |
| 454250 |