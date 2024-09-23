# [1683. Invalid Tweets](https://leetcode.com/problems/invalid-tweets/description/)

## Table Of Contents
1. [Problem Statement](#problem-statement)
2. [Datasets used](#datasets-used)
3. [Solutions](#solutions)
4. [Result set](#result-set)

## Problem Statement

Write a solution to find the IDs of the invalid tweets. The tweet is invalid if the number of characters used in the content of the tweet is strictly greater than 15.

Return the result table in any order.

## Datasets used

```Tweets``` Table:

| Column Name    | Type    |
| -------------- | ------- |
| tweet_id       | int     |
| content        | varchar |

tweet_id is the primary key (column with unique values) for this table.
This table contains all the tweets in a social media app.

## Solutions

```sql
SELECT
    tweet_id
FROM Tweets
WHERE LEN(content) > 15;
```

## Result set

| tweet_id |
| -------- |
| 2        |