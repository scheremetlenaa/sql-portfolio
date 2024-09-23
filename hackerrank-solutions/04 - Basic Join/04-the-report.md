# [The Report](https://www.hackerrank.com/challenges/the-report/)

## Table Of Contents
1. [Problem Statement](#problem-statement)
2. [Datasets used](#datasets-used)
3. [Solutions](#solutions)
4. [Result set](#result-set)

## Problem Statement

Ketty gives Eve a task to generate a report containing three columns: Name, Grade and Mark. Ketty doesn't want the NAMES of those students who received a grade lower than 8. The report must be in descending order by grade -- i.e. higher grades are entered first. If there is more than one student with the same grade (8-10) assigned to them, order those particular students by their name alphabetically. Finally, if the grade is lower than 8, use "NULL" as their name and list them by their grades in descending order. If there is more than one student with the same grade (1-7) assigned to them, order those particular students by their marks in ascending order.

Write a query to help Eve.

## Datasets used

```Students``` Table:

| Column | Type    |
| ------ | ------- |
| ID     | Integer |
| Name   | String  |
| Marks  | Integer |

```Grades``` Table:

| Grade | Min_Mark | Max_Mark |
| ----- | -------- | -------- |
| 1     | 0        | 9        |
| 2     | 10       | 19       |
| 3     | 20       | 29       |
| 4     | 30       | 39       |
| 5     | 40       | 49       |
| 6     | 50       | 59       |
| 7     | 60       | 69       |
| 8     | 70       | 79       |
| 9     | 80       | 89       |
| 10    | 90       | 100      |

## Solutions

```sql
SELECT
    CASE
        WHEN Grade < 8 THEN NULL
        ELSE Students.Name
    END AS Name,
    Grade, Marks
FROM Students
LEFT JOIN Grades 
    ON Students.Marks BETWEEN Grades.Min_Mark AND Grades.Max_Mark
ORDER BY Grade DESC, Name
```

## Result set

| Name    | Grade | Marks |
| ------- | ----- | ----- |
| Britney | 10    | 95    |
| Heraldo | 10    | 94    |
| Julia   | 10    | 96    |