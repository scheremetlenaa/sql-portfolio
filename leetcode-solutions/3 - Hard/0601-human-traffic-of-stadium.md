# [601. Human Traffic of Stadium](https://leetcode.com/problems/human-traffic-of-stadium/description/)

## Table Of Contents
1. [Problem Statement](#problem-statement)
2. [Datasets used](#datasets-used)
3. [Solutions](#solutions)
4. [Result set](#result-set)

## Problem Statement

Write a solution to display the records with three or more rows with consecutive id's, and the number of people is greater than or equal to 100 for each.

Return the result table ordered by visit_date in ascending order.

## Datasets used

```Stadium``` Table:

| Column Name   | Type    |
| ------------- | ------- |
| id            | int     |
| visit_date    | date    |
| people        | int     |

visit_date is the column with unique values for this table.
Each row of this table contains the visit date and visit id to the stadium with the number of people during the visit.
As the id increases, the date increases as well.

## Solutions

```sql
WITH CTE1 AS (
    SELECT
        id,
        visit_date,
        people,
        id - ROW_NUMBER() OVER (ORDER BY id) AS grp
    FROM Stadium
    WHERE people >= 100
),

CTE2 AS (
    SELECT
        grp,
        COUNT(*) AS cnt
    FROM CTE1
    GROUP BY grp
    HAVING COUNT(*) >= 3
)

SELECT
    id,
    visit_date,
    people
FROM CTE1
INNER JOIN CTE2
    ON CTE1.grp = CTE2.grp
ORDER BY visit_date;
```

## Result set

| id | visit_date | people |
| -- | ---------- | ------ |
| 5  | 2017-01-05 | 145    |
| 6  | 2017-01-06 | 1455   |
| 7  | 2017-01-07 | 199    |
| 8  | 2017-01-09 | 188    |