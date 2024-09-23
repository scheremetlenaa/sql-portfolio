# [NULL sorting](https://www.interviewbit.com/problems/null-sorting/)

## Table Of Contents
1. [Problem Statement](#problem-statement)
2. [Datasets used](#datasets-used)
3. [Solutions](#solutions)
4. [Result set](#result-set)

## Problem Statement

You are given a table ‘Students’ which consists of the student information of every student along with the marks that they obtained in a test out of 100. However there were students who were Absent for the test, their marks section would contain ‘Absent’ word. Help the teacher arrange the students first based on their marks and second based on their first name.(You just have to output the names of the students).

## Datasets used

```Students``` Table:

| Field | Type    |
| ----- | ------- |
| Id    | INT     |
| Name  | Varchar |
| Marks | Varchar |

## Solutions

```sql
UPDATE Students
SET Marks = NULL
WHERE Marks = 'Absent';

SELECT
   Name
FROM Students
ORDER BY Marks DESC, Name;
```

## Result set

| **Name**  |
| --------- |
| Alyssa    |
| Thalia    |
| Natka     |
| Josephine |
| Lisette   |
| Alejandra |
| Caressa   |
| Eolanda   |
| Mellicent |
| Therine   |
| Albertina |
| Tiffie    |
| Debee     |
| Dode      |
| Livvyy    |
| Trudie    |
| Sharai    |
| Nananne   |
| Tatiania  |
| Ivett     |
| Dorice    |
| Vivia     |
| Lily      |
| Hollie    |
| Randa     |
| Sabina    |
| Ardenia   |
| Lisette   |
| Petronia  |
| Philis    |
| Jobi      |
| Miquela   |
| Celestyna |
| Patricia  |
| Lilith    |
| Lauryn    |
| Minne     |
| Dede      |
| Arlina    |
| Lauryn    |
| Bernie    |
| Gretal    |
| Sallie    |
| Teddie    |
| Halette   |
| Di        |
| Chere     |
| Cyndie    |
| Fina      |
| Tressa    |