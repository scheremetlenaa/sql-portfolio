# [Weather Observation Station 18](https://www.hackerrank.com/challenges/weather-observation-station-18/)

## Table Of Contents
1. [Problem Statement](#problem-statement)
2. [Datasets used](#datasets-used)
3. [Solutions](#solutions)
4. [Result set](#result-set)

## Problem Statement

Consider P1(a,b) and P2(c,d) to be two points on a 2D plane.

- ```a``` happens to equal the minimum value in Northern Latitude (LAT_N in STATION).
- ```b``` happens to equal the minimum value in Western Longitude (LONG_W in STATION).
- ```c``` happens to equal the maximum value in Northern Latitude (LAT_N in STATION).
- ```d``` happens to equal the maximum value in Western Longitude (LONG_W in STATION).

Query the Manhattan Distance between points P1 and P2 and round it to a scale of 4 decimal places.

## Datasets used

```STATION``` Table:

| Field  | Type         |
| ------ | ------------ |
| ID     | NUMBER       |
| CITY   | VARCHAR2(21) |
| STATE  | VARCHAR(2)   |
| LAT_N  | NUMBER       |
| LONG_W | NUMBER       |

## Solutions

```sql
SELECT 
    ROUND(ABS((MAX(LAT_N) - MIN(LAT_N))) + ABS((MAX(LONG_W) - MIN(LONG_W))), 4)
FROM STATION;
```

## Result set

|          |
| -------- |
| 259.6859 |