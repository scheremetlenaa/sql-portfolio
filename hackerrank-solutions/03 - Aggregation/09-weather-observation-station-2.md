# [Weather Observation Station 2](https://www.hackerrank.com/challenges/weather-observation-station-2/)

## Table Of Contents
1. [Problem Statement]()
2. [Datasets used]()
3. [Solutions]()
4. [Result set]()

## Problem Statement

Query the following two values from the STATION table:

1. The sum of all values in LAT_N rounded to a scale of 2 decimal places.
2. The sum of all values in LONG_W rounded to a scale of 2 decimal places.

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
    ROUND(SUM(LAT_N), 2), 
    ROUND(SUM(LONG_W), 2)
FROM STATION;
```

## Result set

|          |          |
| -------- | -------- |
| 42850.04 | 47381.48 |