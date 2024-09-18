# [Weather Observation Station 17](https://www.hackerrank.com/challenges/weather-observation-station-17/)

## Table Of Contents
1. [Problem Statement]()
2. [Datasets used]()
3. [Solutions]()
4. [Result set]()

## Problem Statement

Query the Western Longitude (LONG_W)where the smallest Northern Latitude (LAT_N) in STATION is greater than 38.7780. Round your answer to 4 decimal places.

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
    ROUND(LONG_W, 4)
FROM STATION
WHERE LAT_N = (SELECT MIN(LAT_N ) FROM STATION WHERE LAT_N > 38.7780);
```

## Result set

|         |
| ------- |
| 70.1378 |