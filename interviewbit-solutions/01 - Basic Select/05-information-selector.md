# [Information Selector](https://www.interviewbit.com/problems/information-selector/)

## Table Of Contents
1. [Problem Statement]()
2. [Datasets used]()
3. [Solutions]()
4. [Result set]()

## Problem Statement

Given a table STUDENTS, query for all the student’s Name and Class whose Age is greater than 15.

## Datasets used

```STUDENTS``` Table:

| Field | Type         |
| ----- | ------------ |
| ID    | INT          |
| Name  | VARCHAR(255) |
| Class | INT          |
| Age   | INT          |

## Solutions

```sql
SELECT
    Name,
    Class
FROM STUDENTS
WHERE Age > 15;
```

## Result set

| **Name**   | **Class** |
| ---------- | --------- |
| Giustina   | 11        |
| Ketti      | 11        |
| Helena     | 6         |
| Nannie     | 6         |
| Clarice    | 10        |
| Grier      | 11        |
| Betta      | 12        |
| Chickie    | 12        |
| Luci       | 8         |
| Sheree     | 6         |
| Layla      | 12        |
| Gavrielle  | 11        |
| Zondra     | 9         |
| Charissa   | 5         |
| Sara-Ann   | 7         |
| Catrina    | 6         |
| Alia       | 7         |
| Ursulina   | 12        |
| Margarette | 8         |
| Lacie      | 10        |
| Wanda      | 8         |
| Caritta    | 6         |
| Norine     | 5         |
| Jessamyn   | 10        |
| Sara-Ann   | 10        |
| Cathie     | 10        |