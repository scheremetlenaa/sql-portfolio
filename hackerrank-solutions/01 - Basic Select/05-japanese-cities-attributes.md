# [Japanese Cities' Attributes](https://www.hackerrank.com/challenges/japanese-cities-attributes/)

## Table Of Contents
1. [Problem Statement]()
2. [Datasets used]()
3. [Solutions]()
4. [Result set]()

## Problem Statement

Query all attributes of every Japanese city in the CITY table. The COUNTRYCODE for Japan is JPN.

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
SELECT * 
FROM CITY
WHERE COUNTRYCODE = 'JPN';
```

## Result set

| ID   | NAME     | COUNTRYCODE | DISTRICT  | POPULATION |
|------|----------|-------------|-----------|------------|
| 1613 | Neyagawa | JPN         | Osaka     | 257315     |
| 1630 | Ageo     | JPN         | Saitama   | 209442     |
| 1661 | Sayama   | JPN         | Saitama   | 162472     |
| 1681 | Omuta    | JPN         | Fukuoka   | 142889     |
| 1739 | Tokuyama | JPN         | Yamaguchi | 107078     |