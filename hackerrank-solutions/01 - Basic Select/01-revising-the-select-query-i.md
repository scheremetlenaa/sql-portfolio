# [Revising the Select Query I](https://www.hackerrank.com/challenges/revising-the-select-query/)

## Table Of Contents
1. [Problem Statement]()
2. [Datasets used]()
3. [Solutions]()
4. [Result set]()

## Problem Statement

Query all columns for all American cities in the CITY table with populations larger than 100000. The CountryCode for America is USA.

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

MY SQL 
```sql
SELECT *
FROM CITY
WHERE POPULATION > 100000
AND COUNTRYCODE = 'USA'
```

## Result set

| ID   | NAME          | COUNTRYCODE | DISTRICT   | POPULATION |
|------|---------------|-------------|------------|------------|
| 3878 | Scottsdale    | USA         | Arizona    | 202705     |
| 3965 | Corona        | USA         | California | 124966     |
| 3973 | Concord       | USA         | California | 121780     |
| 3977 | Cedar  Rapids | USA         | Iowa       | 120758     |
| 3982 | Coral Springs | USA         | Florida    | 117549     |