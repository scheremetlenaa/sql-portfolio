# [Weather Observation Station 20](https://www.hackerrank.com/challenges/weather-observation-station-20/)

## Table Of Contents
1. [Problem Statement](#problem-statement)
2. [Datasets used](#datasets-used)
3. [Solutions](#solutions)
4. [Result set](#result-set)

## Problem Statement

A median is defined as a number separating the higher half of a data set from the lower half. Query the median of the Northern Latitudes (LAT_N) from STATION and round your answer to 4 decimal places.

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
    ROUND(St.LAT_N,4) AS mediam 
FROM STATION 
WHERE (SELECT COUNT(Lat_N) FROM STATION WHERE Lat_N < St.LAT_N ) = 
(SELECT COUNT(Lat_N) FROM STATION WHERE Lat_N > St.LAT_N);
```

## Result set

|         |
| ------- |
| 83.8913 |