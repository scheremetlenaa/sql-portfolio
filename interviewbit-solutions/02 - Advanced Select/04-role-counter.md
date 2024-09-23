# [Role Counter](https://www.interviewbit.com/problems/role-counter/)

## Table Of Contents
1. [Problem Statement](#problem-statement)
2. [Datasets used](#datasets-used)
3. [Solutions](#solutions)
4. [Result set](#result-set)

## Problem Statement

Given a table GAMERS, query for the count of each Role of the Players in the given table. Sort the result based on ascending order of the count and print the result in the following format:

```[Role] Count is [Role_Count]```

## Datasets used

```GAMERS``` Table:

| Field  | Type         |
| ------ | ------------ |
| Player | VARCHAR(255) |
| Role   | VARCHAR(255) |

## Solutions

```sql
SELECT
    CONCAT(Role, ' Count is ', COUNT(*)) AS COUNT
FROM GAMERS
GROUP BY Role
ORDER BY COUNT(*);
```

## Result set

| **COUNT**             |
| --------------------- |
| Defender Count is 11  |
| Attacker Count is 12  |
| Healer Count is 13    |
| Tactician Count is 14 |