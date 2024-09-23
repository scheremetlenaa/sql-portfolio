# [Weather Observation Station 11](https://www.hackerrank.com/challenges/weather-observation-station-11/)

## Table Of Contents
1. [Problem Statement](#problem-statement)
2. [Datasets used](#datasets-used)
3. [Solutions](#solutions)
4. [Result set](#result-set)

## Problem Statement

Query the list of CITY names from STATION that either do not start with vowels or do not end with vowels. Your result cannot contain duplicates.

## Datasets used

```STATION``` Table:

| Field  | Type         |
|--------|--------------|
| ID     | NUMBER       |
| CITY   | VARCHAR2(21) |
| STATE  | VARCHAR2(2)  |
| LAT_N  | NUMBER       |
| LONG_W | NUMBER       |

where LAT_N is the northern latitude and LONG_W is the western longitude.

## Solutions

```sql
SELECT 
    DISTINCT CITY
FROM STATION
WHERE LEFT(CITY, 1) NOT IN ('A', 'E', 'I', 'O', 'U', 'a', 'e', 'i', 'o', 'u')
OR RIGHT(CITY, 1) NOT IN ('A', 'E', 'I', 'O', 'U', 'a', 'e', 'i', 'o', 'u');
```

## Result set

The result table is truncated.

| CITY        |
|-------------|
| Addison     |
| Agency      |
| Alanson     |
| Albany      |
| Albion      |
| Algonac     |
| Allerton    |
| Alton       |
| Andover     |
| Anthony     |
| Arlington   |
| Arrowsmith  |
| Athens      |
| Auburn      |
| Baileyville |
| Bainbridge  |
| Baker       |
| Baldwin     |
| Barrigada   |
| Bass Harbor |