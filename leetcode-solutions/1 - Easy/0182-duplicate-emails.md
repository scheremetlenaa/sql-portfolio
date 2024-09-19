# [182. Duplicate Emails](https://leetcode.com/problems/duplicate-emails/description/)

## Table Of Contents
1. [Problem Statement]()
2. [Datasets used]()
3. [Solutions]()
4. [Result set]()

## Problem Statement

Write a solution to report all the duplicate emails. Note that it's guaranteed that the email field is not NULL.

Return the result table in any order.

## Datasets used

```Person``` Table:

| Column Name | Type    |
| ----------- | ------- |
| id          | int     |
| email       | varchar |

id is the primary key (column with unique values) for this table.
Each row of this table contains an email. The emails will not contain uppercase letters.

## Solutions

```sql
SELECT email
FROM Person
WHERE email IS NOT NULL
GROUP BY email
HAVING COUNT(*) > 1;
```

## Result set

| email   |
| ------- |
| a@b.com |