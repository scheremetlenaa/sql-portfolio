# [Weather Observation Station 3](https://www.hackerrank.com/challenges/weather-observation-station-3/)

## Table Of Contents
1. [Problem Statement](#problem-statement)
2. [Datasets used](#datasets-used)
3. [Solutions](#solutions)
4. [Result set](#result-set)

## Problem Statement

Query a list of CITY names from STATION for cities that have an even ID number. Print the results in any order, but exclude duplicates from the answer.

## Datasets used

```STATION``` Table:

| Field  | Type         |
|--------|--------------|
| ID     | NUMBER       |
| CITY   | VARCHAR2(21) |
| STATE  | VARCHAR2(2)  |
| LAT_N  | NUMBER       |
| LONG_W | NUMBER       |

## Solutions

```sql
SELECT DISTINCT CITY
FROM STATION
WHERE ID%2 = 0;
```

## Result set

The result table is truncated.

| CITY          |
|---------------|
| Aguanga       |
| Alba          |
| Albany        |
| Amo           |
| Andersonville |
| Archie        |
| Athens        |
| Atlantic Mine |
| Bainbridge    |
| Baker         |
| Bass Harbor   |
| Bayville      |
| Beaufort      |
| Bellevue      |
| Benedict      |
| Bennington    |
| Bentonville   |
| Biggsville    |
| Bison         |
| Bono          |