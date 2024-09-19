# [1667. Fix Names in a Table](https://leetcode.com/problems/fix-names-in-a-table/description/)

## Table Of Contents
1. [Problem Statement]()
2. [Datasets used]()
3. [Solutions]()
4. [Result set]()

## Problem Statement

Write a solution to fix the names so that only the first character is uppercase and the rest are lowercase.

Return the result table ordered by user_id.

## Datasets used

```Users``` Table:

| Column Name    | Type    |
| -------------- | ------- |
| user_id        | int     |
| name           | varchar |

user_id is the primary key (column with unique values) for this table.
This table contains the ID and the name of the user. The name consists of only lowercase and uppercase characters.

## Solutions

```sql
SELECT
    user_id,
    UPPER(LEFT(name, 1)) + LOWER(SUBSTRING(name, 2, LEN(name))) AS name
FROM Users
ORDER BY user_id;
```

## Result set

| user_id | name  |
| ------- | ----- |
| 1       | Alice |
| 2       | Bob   |