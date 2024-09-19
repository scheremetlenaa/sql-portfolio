# [627. Swap Salary](https://leetcode.com/problems/swap-salary/description/)

## Table Of Contents
1. [Problem Statement]()
2. [Datasets used]()
3. [Solutions]()
4. [Result set]()

## Problem Statement

Write a solution to swap all 'f' and 'm' values (i.e., change all 'f' values to 'm' and vice versa) with a single update statement and no intermediate temporary tables.

Note that you must write a single update statement, do not write any select statement for this problem.

## Datasets used

```Salary``` Table:

| Column Name | Type     |
| ----------- | -------- |
| id          | int      |
| name        | varchar  |
| sex         | ENUM     |
| salary      | int      |

id is the primary key (column with unique values) for this table.
The sex column is ENUM (category) value of type ('m', 'f').
The table contains information about an employee.

## Solutions

```sql
UPDATE Salary
SET sex = 
CASE
    WHEN sex = 'm' THEN 'f'
    WHEN sex = 'f' THEN 'm'
END;
```

## Result set

| id | name | sex | salary |
| -- | ---- | --- | ------ |
| 1  | A    | f   | 2500   |
| 2  | B    | m   | 1500   |
| 3  | C    | f   | 5500   |
| 4  | D    | m   | 500    |