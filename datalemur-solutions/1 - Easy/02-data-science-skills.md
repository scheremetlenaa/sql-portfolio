# [Data Science Skills [LinkedIn SQL Interview Question]](https://datalemur.com/questions/matching-skills)

## Table Of Contents
1. [Problem Statement]()
2. [Datasets used]()
3. [Solutions]()
4. [Result set]()

## Problem Statement

Given a table of candidates and their skills, you're tasked with finding the candidates best suited for an open Data Science job. You want to find candidates who are proficient in Python, Tableau, and PostgreSQL.

Write a query to list the candidates who possess all of the required skills for the job. Sort the output by candidate ID in ascending order.


## Datasets used

```candidates``` Table:

|  Column Name  | Type          |
| ------------- | ------------- |
| candidate_id      | integer       |
| skill       | varchar       |

## Solutions

```sql
SELECT candidate_id
FROM candidates
WHERE skill IN ('Python', 'Tableau', 'PostgreSQL')
GROUP BY candidate_id
HAVING COUNT(skill) = 3;
```

## Result set

| candidate_id |
| ------------ |
| 123 |