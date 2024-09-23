# [Page With No Likes [Facebook SQL Interview Question]](https://datalemur.com/questions/sql-page-with-no-likes)

## Table Of Contents
1. [Problem Statement](#problem-statement)
2. [Datasets used](#datasets-used)
3. [Solutions](#solutions)
4. [Result set](#result-set)

## Problem Statement

Assume you're given two tables containing data about Facebook Pages and their respective likes (as in "Like a Facebook Page").

Write a query to return the IDs of the Facebook pages that have zero likes. The output should be sorted in ascending order based on the page IDs.

## Datasets used

```pages``` Table:

|  Column Name  | Type          |
| ------------- | ------------- |
| page_id | integer |
| page_name | varchar |

```page_likes``` Table:

| Column Name | Type |
| ----------- | ---- |
| user_id | integer |
| page_id | integer |
| liked_date | datetime |

## Solutions

```sql
SELECT page_id
FROM pages
WHERE page_id NOT IN (SELECT page_id FROM page_likes)
ORDER BY page_id ASC;
```

## Result set

| page_id |
| ------------ |
| 20701 |
| 32728 |