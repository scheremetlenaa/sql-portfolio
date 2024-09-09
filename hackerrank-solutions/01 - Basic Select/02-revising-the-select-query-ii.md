# [Revising the Select Query II](https://www.hackerrank.com/challenges/revising-the-select-query-2/)

## Table Of Contents
1. [Problem Statement]()
2. [Datasets used]()
3. [Solutions]()
4. [Result set]()

## Problem Statement

Query the NAME field for all American cities in the CITY table with populations larger than 120000. The CountryCode for America is USA.

## Datasets used

```CITY``` Table:

| Field       | Type         |
|-------------|--------------|
| ID          | NUMBER       |
| NAME        | VARCHAR2(17) |
| COUNTRYCODE | VARCHAR2(3)  |
| DISTRICT    | VARCHAR2(20) |
| POPULATION  | NUMBER       |

## Solutions

```sql
SELECT NAME
FROM CITY
WHERE COUNTRYCODE = 'USA'
AND POPULATION > 120000
```

## Result set

| NAME       |
|------------|
| Scottsdale |
| Corona     |