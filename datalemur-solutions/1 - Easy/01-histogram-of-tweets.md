# [Histogram of Tweets [Twitter SQL Interview Question]](https://datalemur.com/questions/sql-histogram-tweets)

## Table Of Contents
1. [Problem Statement](#Problem Statement)
2. [Datasets used](https://github.com/scheremetlenaa/sql-portfolio/new/main/datalemur-solutions/1%20-%20Easy#datasets-used)
3. [Solutions](https://github.com/scheremetlenaa/sql-portfolio/new/main/datalemur-solutions/1%20-%20Easy#solutions)
4. [Result set](https://github.com/scheremetlenaa/sql-portfolio/new/main/datalemur-solutions/1%20-%20Easy#result-set)

## Problem Statement

Assume you're given a table Twitter tweet data, write a query to obtain a histogram of tweets posted per user in 2022. Output the tweet count per user as the bucket and the number of Twitter users who fall into that bucket.

In other words, group the users by the number of tweets they posted in 2022 and count the number of users in each group.

## Datasets used

```tweets``` Table:

|  Column Name  | Type          |
| ------------- | ------------- |
| tweet_id      | integer       |
| user_id       | integer       |
| msg           | string        |
| tweet_date    | timestamp     |

## Solutions

```sql
SELECT
  groups AS tweet_bucket,
  COUNT(*) AS users_num
FROM (
  SELECT
    COUNT(*) AS groups
  FROM tweets
  WHERE tweet_date BETWEEN '01/01/2022' AND '12/31/2022'
  GROUP BY user_id
) t1
GROUP BY tweet_bucket;
```

## Result set

| tweet_bucket | users_num |
| ------------ | --------- |
| 1 | 2 |
| 2 | 1 |
