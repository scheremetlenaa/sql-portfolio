# [1148. Article Views I](https://leetcode.com/problems/article-views-i/description/)

## Table Of Contents
1. [Problem Statement](#problem-statement)
2. [Datasets used](#datasets-used)
3. [Solutions](#solutions)
4. [Result set](#result-set)

## Problem Statement

Write a solution to find all the authors that viewed at least one of their own articles.

Return the result table sorted by id in ascending order.

## Datasets used

```Views``` Table:

| Column Name   | Type    |
| ------------- | ------- |
| article_id    | int     |
| author_id     | int     |
| viewer_id     | int     |
| view_date     | date    |

There is no primary key (column with unique values) for this table, the table may have duplicate rows.
Each row of this table indicates that some viewer viewed an article (written by some author) on some date. 
Note that equal author_id and viewer_id indicate the same person.

## Solutions

```sql
SELECT DISTINCT author_id AS id
FROM Views
WHERE author_id = viewer_id
ORDER BY id ASC;
```

## Result set

| id |
| -- |
| 4  |
| 7  |