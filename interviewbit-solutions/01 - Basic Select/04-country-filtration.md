# [Country Filtration](https://www.interviewbit.com/problems/country-filtration/)

## Table Of Contents
1. [Problem Statement]()
2. [Datasets used]()
3. [Solutions]()
4. [Result set]()

## Problem Statement

Given a table COUNTRY, query for all the country names with Code NA.

## Datasets used

```COUNTRY``` Table:

| Field             | Type         |
| ----------------- | ------------ |
| ID                | INT          |
| Name              | VARCHAR(255) |
| Code              | VARCHAR(255) |
| PopulationDensity | INT          |

## Solutions

```sql
SELECT
    Name
FROM COUNTRY
WHERE CODE = 'NA';
```

## Result set

| **Name**   |
| ---------- |
| Cape Verde |