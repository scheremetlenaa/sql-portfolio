# [African Cities](https://www.hackerrank.com/challenges/african-cities/)

## Table Of Contents
1. [Problem Statement]()
2. [Datasets used]()
3. [Solutions]()
4. [Result set]()

## Problem Statement

Given the CITY and COUNTRY tables, query the names of all cities where the CONTINENT is 'Africa'.

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
    CITY.NAME
FROM CITY
LEFT JOIN COUNTRY 
    ON CITY.CountryCode = COUNTRY.Code
WHERE CONTINENT = 'Africa';
```

## Result set

| NAME           |
| -------------- |
| Qina           |
| Warraq al-Arab |
| Kempton Park   |
| Alberton       |
| Klerksdorp     |
| Uitenhage      |
| Brakpan        |
| Libreville     |