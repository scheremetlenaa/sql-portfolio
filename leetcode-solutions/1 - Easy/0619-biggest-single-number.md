# [619. Biggest Single Number](https://leetcode.com/problems/biggest-single-number/description/)

## Table Of Contents
1. [Problem Statement]()
2. [Datasets used]()
3. [Solutions]()
4. [Result set]()

## Problem Statement

A single number is a number that appeared only once in the MyNumbers table.

Find the largest single number. If there is no single number, report null.

## Datasets used

```MyNumbers``` Table:

| Column Name | Type |
| ----------- | ---- |
| num         | int  |

This table may contain duplicates (In other words, there is no primary key for this table in SQL).
Each row of this table contains an integer.

## Solutions

```sql
SELECT MAX(num) AS num
FROM (
    SELECT num
    FROM MyNumbers
    GROUP BY num
    HAVING COUNT(num) = 1
) t1;
```

## Result set

| num |
| --- |
| 6   |