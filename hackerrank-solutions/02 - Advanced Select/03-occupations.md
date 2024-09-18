# [Occupations](https://www.hackerrank.com/challenges/occupations/)

## Table Of Contents
1. [Problem Statement]()
2. [Datasets used]()
3. [Solutions]()
4. [Result set]()

## Problem Statement

Pivot the Occupation column in OCCUPATIONS so that each Name is sorted alphabetically and displayed underneath its corresponding Occupation. The output column headers should be Doctor, Professor, Singer, and Actor, respectively.

## Datasets used

```OCCUPATIONS``` Table:

| Column     | Type   |
| ---------- | ------ |
| Name       | String |
| Occupation | String |

## Solutions

```sql
WITH CTE AS (
    SELECT
        Name,
        Occupation,
        ROW_NUMBER() OVER (PARTITION BY Occupation ORDER BY Name) AS rw_nm
    FROM Occupations
)

SELECT
    MAX(CASE WHEN Occupation = 'Doctor' THEN Name ELSE NULL END) AS Doctor,
    MAX(CASE WHEN Occupation = 'Professor' THEN Name ELSE NULL END) AS Professor,
    MAX(CASE WHEN Occupation = 'Singer' THEN Name ELSE NULL END) AS Singer,
    MAX(CASE WHEN Occupation = 'Actor' THEN Name ELSE NULL END) AS Actor
FROM CTE
GROUP BY rw_nm
ORDER BY rw_nm;
```

## Result set

| Doctor | Professor | Singer    | Actor    |
| ------ | --------- | --------- | -------- |
| Aamina | Ashley    | Christeen | Eve      |
| Julia  | Belvet    | Jane      | Jennifer |
| Priya  | Britney   | Jenny     | Ketty    |
| NULL   | Maria     | Kristeen  | Samantha |
| NULL   | Meera     | NULL      | NULL     |
| NULL   | Naomi     | NULL      | NULL     |
| NULL   | Priyanka  | NULL      | NULL     |