# [Average Population of Each Continent](https://www.hackerrank.com/challenges/average-population-of-each-continent/)

## Table Of Contents
1. [Problem Statement]()
2. [Datasets used]()
3. [Solutions]()
4. [Result set]()

## Problem Statement

Given the CITY and COUNTRY tables, query the names of all the continents (COUNTRY.Continent) and their respective average city populations (CITY.Population) rounded down to the nearest integer.

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
    COUNTRY.CONTINENT, 
    FLOOR(AVG(CITY.POPULATION))
FROM COUNTRY
INNER JOIN CITY 
    ON CITY.CountryCode = COUNTRY.Code
GROUP BY CONTINENT;
```

## Result set

| CONTINENT     |        |
| ------------- | ------ |
| Oceania       | 109189 |
| South America | 147435 |
| Europe        | 175138 |
| Africa        | 274439 |
| Asia          | 693038 |