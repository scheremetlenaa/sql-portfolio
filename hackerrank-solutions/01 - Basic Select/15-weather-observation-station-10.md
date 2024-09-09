# [Weather Observation Station 10](https://www.hackerrank.com/challenges/weather-observation-station-10/)

## Table Of Contents
1. [Problem Statement]()
2. [Datasets used]()
3. [Solutions]()
4. [Result set]()

## Problem Statement

Query the list of CITY names from STATION that do not end with vowels. Your result cannot contain duplicates.

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
WHERE RIGHT(CITY, 1) NOT IN ('A', 'E', 'I', 'O', 'U', 'a', 'e', 'i', 'o', 'u');
```

## Result set

The result table is truncated.

| CITY          |
|---------------|
| Addison       |
| Agency        |
| Alanson       |
| Albany        |
| Albion        |
| Algonac       |
| Allerton      |
| Alton         |
| Andover       |
| Anthony       |
| Arlington     |
| Arrowsmith    |
| Athens        |
| Auburn        |
| Baker         |
| Baldwin       |
| Bass Harbor   |
| Beaufort      |
| Beaver Island |
| Benedict      |