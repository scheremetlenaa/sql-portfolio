# [Vowel Country](https://www.interviewbit.com/problems/vowel-country/)

## Table Of Contents
1. [Problem Statement]()
2. [Datasets used]()
3. [Solutions]()
4. [Result set]()

## Problem Statement

Given a table PLACES, count the number of Countries which end with a vowel.

## Datasets used

```PLACES``` Table:

| Field   | Type         |
| ------- | ------------ |
| ID      | INT          |
| Name    | VARCHAR(255) |
| Country | VARCHAR(255) |

## Solutions

```sql
SELECT
    COUNT(Country)
FROM PLACES
WHERE Country REGEXP '[aeiou]$';
```

## Result set

| **COUNT(Country)** |
| ------------------ |
| 52                 |