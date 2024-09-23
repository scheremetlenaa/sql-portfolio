# [I hate Vowels](https://www.interviewbit.com/problems/i-hate-vowels/)

## Table Of Contents
1. [Problem Statement](#problem-statement)
2. [Datasets used](#datasets-used)
3. [Solutions](#solutions)
4. [Result set](#result-set)

## Problem Statement

You are given a ‘Students’ table consisting of Id,Name and marks of two tests namely Marks1 and Marks2. The teacher wants to sort the table based on their marks(in descending order). However the teacher has a particular hate towards students whose Names starts with a vowel. Therefore the teacher would take the maximum of the two tests for students whose name doesn’t start with a vowel while sorting, and would take the minimum of the two tests for the students whose name starts with a vowel while sorting.

## Datasets used

```Students``` Table:

| Field  | Type    |
| ------ | ------- |
| Id     | INT     |
| Name   | Varchar |
| Marks1 | INT     |
| Marks2 | INT     |

## Solutions

```sql
SELECT
    Name
FROM Students
ORDER BY
    CASE
        WHEN LOWER(Name) REGEXP '^[aeiou]' THEN Least(Marks1, Marks2)
        ELSE GREATEST(Marks1, Marks2)
    END DESC;
```

## Result set

| **Name**   |
| ---------- |
| Nickie     |
| Lanae      |
| Maurene    |
| Phedra     |
| Chickie    |
| Pearline   |
| Renie      |
| Benita     |
| Libbie     |
| Dorthy     |
| Vere       |
| Luci       |
| Janis      |
| Merrie     |
| Hyacinthe  |
| Clarice    |
| Celestyna  |
| Mureil     |
| Gabi       |
| Lilith     |
| Mildrid    |
| Vere       |
| Dode       |
| Sue        |
| Wendi      |
| Mireielle  |
| Leona      |
| Bobbi      |
| Thalia     |
| Ilse       |
| Sybille    |
| Moyna      |
| Belinda    |
| Albertina  |
| Tamqrah    |
| Viviene    |
| Emylee     |
| Mariann    |
| Paulita    |
| Celisse    |
| Consuela   |
| Marguerite |
| Emelina    |
| Brietta    |
| Leontine   |
| Mathilda   |
| Kial       |
| Magdalena  |
| Sophia     |
| Alia       |