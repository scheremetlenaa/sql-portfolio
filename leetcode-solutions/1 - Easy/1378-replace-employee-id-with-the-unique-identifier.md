# [1378. Replace Employee ID With The Unique Identifier](https://leetcode.com/problems/replace-employee-id-with-the-unique-identifier/description/)

## Table Of Contents
1. [Problem Statement]()
2. [Datasets used]()
3. [Solutions]()
4. [Result set]()

## Problem Statement

Write a solution to show the unique ID of each user, If a user does not have a unique ID replace just show null.

Return the result table in any order.

## Datasets used

```Employees``` Table:

| Column Name   | Type    |
| ------------- | ------- |
| id            | int     |
| name          | varchar |

id is the primary key (column with unique values) for this table.
Each row of this table contains the id and the name of an employee in a company.

```EmployeeUNI``` Table:

| Column Name   | Type    |
| ------------- | ------- |
| id            | int     |
| unique_id     | int     |

(id, unique_id) is the primary key (combination of columns with unique values) for this table.
Each row of this table contains the id and the corresponding unique id of an employee in the company.

## Solutions

```sql
SELECT
    unique_id,
    name
FROM Employees em
LEFT JOIN EmployeeUNI emu
    ON em.id = emu.id;
```

## Result set

| unique_id | name     |
| --------- | -------- |
| null      | Alice    |
| null      | Bob      |
| 2         | Meir     |
| 3         | Winston  |
| 1         | Jonathan |