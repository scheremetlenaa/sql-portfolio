# [Town Queries](https://www.interviewbit.com/problems/town-queries/)

## Table Of Contents
1. [Problem Statement]()
2. [Datasets used]()
3. [Solutions]()
4. [Result set]()

## Problem Statement

Given a table Towns, query for all the Towns which have a Population greater than 1000.

## Datasets used

```Towns``` Table:

| Field      | Type         |
| ---------- | ------------ |
| id         | INT          |
| TownName   | VARCHAR(255) |
| TownCode   | INT          |
| Population | INT          |

## Solutions

```sql
SELECT
    *
FROM Towns
WHERE Population > 1000;
```

## Result set

| **id** | **TownName**  | **TownCode** | **Population** |
| ------ | ------------- | ------------ | -------------- |
| 1      | Tegucigalpa   | 12625        | 2622           |
| 2      | Cockburn Town | 31222        | 2628           |
| 3      | Lubumbashi    | 42891        | 4277           |
| 6      | Vilnius       | 20880        | 4999           |
| 7      | Manama        | 34126        | 1720           |
| 8      | Kuwait City   | 36867        | 3001           |
| 9      | Nassau        | 44007        | 4780           |
| 10     | Tskhinvali    | 35954        | 4757           |