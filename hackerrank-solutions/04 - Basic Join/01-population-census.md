# [Population Census](https://www.hackerrank.com/challenges/asian-population/)

## Table Of Contents
1. [Problem Statement](#problem-statement)
2. [Datasets used](#datasets-used)
3. [Solutions](#solutions)
4. [Result set](#result-set)

## Problem Statement

Given the CITY and COUNTRY tables, query the sum of the populations of all cities where the CONTINENT is 'Asia'.

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
    SUM(CITY.POPULATION)
FROM CITY
LEFT JOIN COUNTRY 
    ON CITY.CountryCode = COUNTRY.Code
WHERE CONTINENT = 'Asia';
```

## Result set

|          |
| -------- |
| 27028384 |