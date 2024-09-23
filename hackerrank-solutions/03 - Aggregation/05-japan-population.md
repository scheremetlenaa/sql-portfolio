# [Japan Population](https://www.hackerrank.com/challenges/japan-population/)

## Table Of Contents
1. [Problem Statement](#problem-statement)
2. [Datasets used](#datasets-used)
3. [Solutions](#solutions)
4. [Result set](#result-set)

## Problem Statement

Query the sum of the populations for all Japanese cities in CITY. The COUNTRYCODE for Japan is JPN.

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
WHERE COUNTRYCODE = 'JPN';
```

## Result set

|        |
| ------ |
| 879196 |