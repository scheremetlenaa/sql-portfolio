# [Average Post Hiatus (Part 1) [Facebook SQL Interview Question]](https://datalemur.com/questions/sql-average-post-hiatus-1)

## Table Of Contents
1. [Problem Statement]()
2. [Datasets used]()
3. [Solutions]()
4. [Result set]()

## Problem Statement

Given a table of Facebook posts, for each user who posted at least twice in 2021, write a query to find the number of days between each user’s first post of the year and last post of the year in the year 2021. Output the user and number of the days between each user's first and last post.

## Datasets used

```posts``` Table:

|  Column Name  | Type          |
| ------------- | ------------- |
| user_id | integer |
| post_id | integer |
| post_content | text |
| post_date | timestamp |

## Solutions

```sql
SELECT 
    user_id, 
    EXTRACT(day FROM MAX(post_date) - MIN(post_date)) AS days_between
FROM posts
WHERE EXTRACT(year FROM post_date) = 2021
GROUP BY user_id
HAVING COUNT(*) > 1;
```

## Result set

| user_id | days_between |
| ------- | ------------ |
| 151652 | 307 |
| 661093 | 206 |