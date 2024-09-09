# [Weather Observation Station 12](https://www.hackerrank.com/challenges/weather-observation-station-12/)

## Table Of Contents
1. [Problem Statement]()
2. [Datasets used]()
3. [Solutions]()
4. [Result set]()

## Problem Statement

Query the list of CITY names from STATION that do not start with vowels and do not end with vowels. Your result cannot contain duplicates.

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
AND RIGHT(CITY, 1) NOT IN ('A', 'E', 'I', 'O', 'U', 'a', 'e', 'i', 'o', 'u');
```

## Result set

The result table is truncated.

| CITY            |
|-----------------|
| Baker           |
| Baldwin         |
| Bass Harbor     |
| Beaufort        |
| Beaver Island   |
| Benedict        |
| Bennington      |
| Berryton        |
| Beverly         |
| Bison           |
| Blue River      |
| Bowdon          |
| Bowdon Junction |
| Bridgeport      |
| Bridgton        |
| Brighton        |
| Brilliant       |
| Bristol         |
| Brownstown      |
| Buffalo Creek   |