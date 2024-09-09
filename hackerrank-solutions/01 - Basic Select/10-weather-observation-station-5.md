# [Weather Observation Station 5](https://www.hackerrank.com/challenges/weather-observation-station-5/)

## Table Of Contents
1. [Problem Statement]()
2. [Datasets used]()
3. [Solutions]()
4. [Result set]()

## Problem Statement

Query the two cities in STATION with the shortest and longest CITY names, as well as their respective lengths (i.e.: number of characters in the name). If there is more than one smallest or largest city, choose the one that comes first when ordered alphabetically.

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

MY SQL Solution

```sql
SELECT 
    CITY, 
    LENGTH(CITY)
FROM STATION
ORDER BY LENGTH(CITY) DESC, CITY
LIMIT 1;

SELECT 
    CITY, 
    LENGTH(CITY)
FROM STATION
ORDER BY LENGTH(CITY), CITY
LIMIT 1;
```
T-SQL Solution

```sql
SELECT 
    TOP 1 CITY, 
    LEN(CITY)
FROM STATION
ORDER BY LEN(CITY) DESC, CITY;

SELECT 
    TOP 1 CITY, 
    LEN(CITY)
FROM STATION
ORDER BY LEN(CITY), CITY;
```

## Result set

| CITY                  | LENGTH |
|-----------------------|--------|
| Amo                   | 3      |
| Marine On Saint Croix | 21     |