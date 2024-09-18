# [SQL Project Planning](https://www.hackerrank.com/challenges/sql-projects/)

## Table Of Contents
1. [Problem Statement]()
2. [Datasets used]()
3. [Solutions]()
4. [Result set]()

## Problem Statement

You are given a table, Projects, containing three columns: Task_ID, Start_Date and End_Date. It is guaranteed that the difference between the End_Date and the Start_Date is equal to 1 day for each row in the table.

If the End_Date of the tasks are consecutive, then they are part of the same project. Samantha is interested in finding the total number of different projects completed.

Write a query to output the start and end dates of projects listed by the number of days it took to complete the project in ascending order. If there is more than one project that have the same number of completion days, then order by the start date of the project.

## Datasets used

```Projects``` Table:

| Column     | Type    |
| ---------- | ------- |
| Task_ID    | Integer |
| Start_Date | Integer |
| End_Date   | Integer |

## Solutions

```sql
WITH START_DATES AS (
    SELECT
        start_date,
        ROW_NUMBER() OVER(ORDER BY start_date) AS start_rank 
    FROM Projects
    WHERE start_date NOT IN (SELECT end_date FROM Projects)
),

END_DATES AS (
    SELECT
        end_date,
        ROW_NUMBER() OVER(ORDER BY end_date) AS end_rank 
    FROM Projects
    WHERE end_date NOT IN (SELECT start_date FROM Projects)
)

SELECT
    start_date,
    end_date
FROM START_DATES, END_DATES
WHERE start_rank = end_rank
ORDER BY DATEDIFF(DAY, start_date, end_date), start_date;
```

## Result set

| start_date | end_date   |
| ---------- | ---------- |
| 2015-10-15 | 2015-10-16 |
| 2015-10-17 | 2015-10-18 |
| 2015-10-19 | 2015-10-20 |