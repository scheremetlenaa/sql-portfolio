# [Select All](https://www.hackerrank.com/challenges/select-all-sql/)

## Table Of Contents
1. [Problem Statement]()
2. [Datasets used]()
3. [Solutions]()
4. [Result set]()

## Problem Statement

Query all columns (attributes) for every row in the CITY table.

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
SELECT * FROM CITY;
```

## Result set

| ID   | NAME         | COUNTRYCODE | DISTRICT     | POPULATION |
|------|--------------|-------------|--------------|------------|
| 6    | Rotterdam    | NLD         | Zuid-Holland | 593321     |
| 3878 | Scottsdale   | USA         | Arizona      | 202705     |
| 3965 | Corona       | USA         | California   | 124966     |
| 3973 | Concord      | USA         | California   | 121780     |
| 3977 | Cedar Rapids | USA         | Iowa         | 120758     |