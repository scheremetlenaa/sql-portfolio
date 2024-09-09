# [Japanese Cities' Names](https://www.hackerrank.com/challenges/japanese-cities-name/)

## Table Of Contents
1. [Problem Statement]()
2. [Datasets used]()
3. [Solutions]()
4. [Result set]()

## Problem Statement

Query the names of all the Japanese cities in the CITY table. The COUNTRYCODE for Japan is JPN.

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
WHERE COUNTRYCODE = 'JPN';
```

## Result set

| NAME     |
|----------|
| Neyagawa |
| Ageo     |
| Sayama   |