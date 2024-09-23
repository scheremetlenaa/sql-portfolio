# [Town Of Threes](https://www.interviewbit.com/problems/town-of-threes/)

## Table Of Contents
1. [Problem Statement](#problem-statement)
2. [Datasets used](#datasets-used)
3. [Solutions](#solutions)
4. [Result set](#result-set)

## Problem Statement

Given a table TOWNS, query for all the Town Names and Population, such that the ID is a multiple of 3.

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
    TownName,
    Population
FROM TOWNS 
WHERE ID % 3 = 0;
```

## Result set

| **TownName**     | **Population** |
| ---------------- | -------------- |
| Pekanbaru        | 786            |
| The Valley       | 357            |
| Novosibirsk      | 7807           |
| Austin           | 9587           |
| Faisalabad       | 983            |
| Linz             | 2201           |
| Stanley          | 5919           |
| San Juan         | 7772           |
| Wollongong       | 2732           |
| Kota Bharu       | 5788           |
| Memphis          | 6960           |
| Luanda           | 2242           |
| Fort-de-France   | 624            |
| Yerevan          | 9160           |
| Ho Chi Minh City | 6422           |
| Praia            | 5254           |