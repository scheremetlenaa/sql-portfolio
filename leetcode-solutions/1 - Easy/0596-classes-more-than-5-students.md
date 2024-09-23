# [596. Classes More Than 5 Students](https://leetcode.com/problems/classes-more-than-5-students/description/)

## Table Of Contents
1. [Problem Statement](#problem-statement)
2. [Datasets used](#datasets-used)
3. [Solutions](#solutions)
4. [Result set](#result-set)

## Problem Statement

Write a solution to find all the classes that have at least five students.

Return the result table in any order.

## Datasets used

```Courses``` Table:

| Column Name | Type    |
| ----------- | ------- |
| student     | varchar |
| class       | varchar |

(student, class) is the primary key (combination of columns with unique values) for this table.
Each row of this table indicates the name of a student and the class in which they are enrolled.

## Solutions

```sql
SELECT class
FROM Courses
GROUP BY class
HAVING COUNT(*) >= 5;
```

## Result set

| class |
| ----- |
| Math  |