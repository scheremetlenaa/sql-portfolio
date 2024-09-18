# [Placements](https://www.hackerrank.com/challenges/placements/)

## Table Of Contents
1. [Problem Statement]()
2. [Datasets used]()
3. [Solutions]()
4. [Result set]()

## Problem Statement

Write a query to output the names of those students whose best friends got offered a higher salary than them. Names must be ordered by the salary amount offered to the best friends. It is guaranteed that no two students got same salary offer.

## Datasets used

```Students``` Table:

| Column | Type    |
| ------ | ------- |
| ID     | Integer |
| Name   | String  |

```Friends``` Table:

| Column    | Type    |
| --------- | ------- |
| ID        | Integer |
| Friend_ID | Integer |

```Packages``` Table:

| Column | Type    |
| ------ | ------- |
| ID     | Integer |
| Salary | Float   |

## Solutions

```sql
SELECT
    s.name
FROM Students s
INNER JOIN Friends f
    ON s.ID = f.id
INNER JOIN Packages p
    ON f.friend_id = p.id
INNER JOIN Packages p2
    ON s.id = p2.id
WHERE p.salary > p2.salary
ORDER BY p.salary;
```

## Result set

| name     |
| -------- |
| Stuart   |
| Priyanka |
| Paige    |
| Jane     |
| Julia    |
| Belvet   |
| Amina    |
| Kristeen |
| Scarlet  |
| Priya    |
| Meera    |