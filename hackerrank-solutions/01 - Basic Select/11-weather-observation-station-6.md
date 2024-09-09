# [Weather Observation Station 6](https://www.hackerrank.com/challenges/weather-observation-station-6/)

## Table Of Contents
1. [Problem Statement]()
2. [Datasets used]()
3. [Solutions]()
4. [Result set]()

## Problem Statement

Query the list of CITY names starting with vowels (i.e., a, e, i, o, or u) from STATION. Your result cannot contain duplicates.

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
WHERE LEFT(CITY, 1) IN ('a', 'e', 'i', 'o', 'u', 'A', 'E', 'I', 'O', 'U');
```

## Result set

The result table is truncated.

| CITY          |
|---------------|
| Acme          |
| Addison       |
| Agency        |
| Aguanga       |
| Alanson       |
| Alba          |
| Albany        |
| Albion        |
| Algonac       |
| Aliso Viejo   |
| Allerton      |
| Alpine        |
| Alton         |
| Amazonia      |
| Amo           |
| Andersonville |
| Andover       |
| Anthony       |
| Archie        |
| Arispe        |