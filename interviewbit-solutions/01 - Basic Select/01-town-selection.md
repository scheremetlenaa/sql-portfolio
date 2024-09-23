# [Town Selection](https://www.interviewbit.com/problems/town-selection/)

## Table Of Contents
1. [Problem Statement](#problem-statement)
2. [Datasets used](#datasets-used)
3. [Solutions](#solutions)
4. [Result set](#result-set)

## Problem Statement

Given a table Towns, query for all the attributes in the table. 

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
SELECT * FROM Towns;
```

## Result set

| **id** | **TownName** | **TownCode** | **Population** |
| ------ | ------------ | ------------ | -------------- |
| 1      | Alofi        | 10000        | 10000          |
| 2      | Saipan       | 10000        | 10000          |
| 3      | Raleigh      | 10000        | 10000          |
| 4      | Omdurman     | 10000        | 10000          |
| 5      | Malacca Town | 10000        | 10000          |
| 6      | San Juan     | 10000        | 10000          |
| 7      | Guwahati     | 10000        | 10000          |
| 8      | Hanover      | 10000        | 10000          |
| 9      | Mecca        | 10000        | 10000          |
| 10     | Brikama      | 10000        | 10000          |