# [Weather Observation Station 7](https://www.hackerrank.com/challenges/weather-observation-station-7/)

## Table Of Contents
1. [Problem Statement]()
2. [Datasets used]()
3. [Solutions]()
4. [Result set]()

## Problem Statement

Query the list of CITY names ending with vowels (a, e, i, o, u) from STATION. Your result cannot contain duplicates.

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
WHERE RIGHT(CITY, 1) IN ('A', 'E', 'O', 'I', 'U', 'a', 'e', 'o', 'i', 'u');
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
| Baileyville   |
| Bainbridge    |
| Barrigada     |
| Baton Rouge   |
| Bayville      |
| Bellevue      |
| Bentonville   |
| Bertha        |