# [Weather Observation Station 1](https://www.hackerrank.com/challenges/weather-observation-station-1/)

## Table Of Contents
1. [Problem Statement]()
2. [Datasets used]()
3. [Solutions]()
4. [Result set]()

## Problem Statement

Query a list of CITY and STATE from the STATION table.

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
SELECT CITY, STATE 
FROM STATION;
```

## Result set

The result table is truncated.

| CITY          | STATE |
|---------------|-------|
| Acme          | LA    |
| Addison       | MI    |
| Agency        | MO    |
| Aguanga       | CA    |
| Alanson       | MI    |
| Alba          | MI    |
| Albany        | CA    |
| Albion        | IN    |
| Algonac       | MI    |
| Aliso Viejo   | CA    |
| Allerton      | IA    |
| Alpine        | AR    |
| Alton         | MO    |
| Amazonia      | MO    |
| Amo           | IN    |
| Andersonville | GA    |
| Andover       | CT    |
| Anthony       | KS    |
| Archie        | MO    |
| Arispe        | IA    |