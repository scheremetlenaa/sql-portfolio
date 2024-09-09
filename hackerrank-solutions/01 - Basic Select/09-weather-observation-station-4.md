# [Weather Observation Station 4](https://www.hackerrank.com/challenges/weather-observation-station-4/)

## Table Of Contents
1. [Problem Statement]()
2. [Datasets used]()
3. [Solutions]()
4. [Result set]()

## Problem Statement

Find the difference between the total number of CITY entries in the table and the number of distinct CITY entries in the table.

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
    (COUNT(CITY) - COUNT(DISTINCT CITY)) AS DIFFERENCE
FROM STATION;
```

## Result set

| DIFFERENCE   |
| ------------ |
| 13 |