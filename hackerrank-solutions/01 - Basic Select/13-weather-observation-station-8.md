# [Weather Observation Station 8](https://www.hackerrank.com/challenges/weather-observation-station-8/)

## Table Of Contents
1. [Problem Statement]()
2. [Datasets used]()
3. [Solutions]()
4. [Result set]()

## Problem Statement

Query the list of CITY names from STATION which have vowels (i.e., a, e, i, o, and u) as both their first and last characters. Your result cannot contain duplicates.

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
WHERE LEFT(CITY, 1) IN ('A', 'E', 'I', 'O', 'U', 'a', 'e', 'i', 'o', 'u')
AND RIGHT(CITY, 1) IN ('A', 'E', 'I', 'O', 'U', 'a', 'e', 'i', 'o', 'u');
```

## Result set

The result table is truncated.

| CITY          |
|---------------|
| Acme          |
| Aguanga       |
| Alba          |
| Aliso Viejo   |
| Alpine        |
| Amazonia      |
| Amo           |
| Andersonville |
| Archie        |
| Arispe        |
| Arkadelphia   |
| Atlantic Mine |
| East China    |
| East Irvine   |
| Eastlake      |
| Eleele        |
| Elm Grove     |
| Eriline       |
| Ermine        |
| Eskridge      |