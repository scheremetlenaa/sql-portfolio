# [196. Delete Duplicate Emails](https://leetcode.com/problems/delete-duplicate-emails/description/)

## Table Of Contents
1. [Problem Statement]()
2. [Datasets used]()
3. [Solutions]()
4. [Result set]()

## Problem Statement

Write a solution to delete all duplicate emails, keeping only one unique email with the smallest id.

For SQL users, please note that you are supposed to write a DELETE statement and not a SELECT one.

For Pandas users, please note that you are supposed to modify Person in place.

After running your script, the answer shown is the Person table. The driver will first compile and run your piece of code and then show the Person table. The final order of the Person table does not matter.

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
DELETE FROM Person
WHERE id IN (
    SELECT t.id
    FROM (
        SELECT 
        id, 
        email, 
        ROW_NUMBER() OVER (PARTITION BY email ORDER BY id) AS rw_nm 
        FROM Person
    ) t
    WHERE t.rw_nm > 1 
);
```

## Result set

| id | email            |
| -- | ---------------- |
| 1  | john@example.com |
| 2  | bob@example.com  |