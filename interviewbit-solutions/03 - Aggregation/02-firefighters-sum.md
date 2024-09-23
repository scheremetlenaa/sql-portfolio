# [Firefighter's Sum](https://www.interviewbit.com/problems/firefighter-s-sum/)

## Table Of Contents
1. [Problem Statement](#problem-statement)
2. [Datasets used](#datasets-used)
3. [Solutions](#solutions)
4. [Result set](#result-set)

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