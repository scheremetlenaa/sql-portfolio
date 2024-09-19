# [Firefighter's Sum](https://www.interviewbit.com/problems/firefighter-s-sum/)

## Table Of Contents
1. [Problem Statement]()
2. [Datasets used]()
3. [Solutions]()
4. [Result set]()

## Problem Statement

Given a table FIREFIGHTERS, query the sum of all the people saved by the Firefighters whose CountryCode is PG.

## Datasets used

```FIREFIGHTERS``` Table:

| Field       | Type         |
| ----------- | ------------ |
| ID          | INT          |
| Name        | VARCHAR(255) |
| Country     | VARCHAR(255) |
| CountryCode | VARCHAR(255) |
| PeopleSaved | INT          |

## Solutions

```sql
SELECT
    SUM(PeopleSaved)
FROM FIREFIGHTERS 
WHERE CountryCode = 'PG';
```

## Result set

| **SUM(PeopleSaved)** |
| -------------------- |
| 1098                 |