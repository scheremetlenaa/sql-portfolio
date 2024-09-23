# [1341. Movie Rating](https://leetcode.com/problems/movie-rating/description/)

## Table Of Contents
1. [Problem Statement](#problem-statement)
2. [Datasets used](#datasets-used)
3. [Solutions](#solutions)
4. [Result set](#result-set)

## Problem Statement

Write a solution to:

- Find the name of the user who has rated the greatest number of movies. In case of a tie, return the lexicographically smaller user name.
- Find the movie name with the highest average rating in February 2020. In case of a tie, return the lexicographically smaller movie name.

## Datasets used

```Movies``` Table:

| Column Name   | Type    |
| ------------- | ------- |
| movie_id      | int     |
| title         | varchar |

movie_id is the primary key (column with unique values) for this table.
title is the name of the movie.

```Users``` Table:

| Column Name   | Type    |
| ------------- | ------- |
| user_id       | int     |
| name          | varchar |

user_id is the primary key (column with unique values) for this table.
The column 'name' has unique values.

```MovieRating``` Table:

| Column Name   | Type    |
| ------------- | ------- |
| movie_id      | int     |
| user_id       | int     |
| rating        | int     |
| created_at    | date    |

(movie_id, user_id) is the primary key (column with unique values) for this table.
This table contains the rating of a movie by a user in their review.
created_at is the user's review date. 

## Solutions

```sql
WITH results AS (
    SELECT
        TOP 1 u.name AS results
    FROM Users u
    INNER JOIN MovieRating mr
        ON u.user_id = mr.user_id
    GROUP BY u.name
    ORDER BY COUNT(movie_id) DESC, u.name

    UNION ALL

    SELECT
        TOP 1 title AS results
    FROM Movies m
    INNER JOIN MovieRating mr
        ON m.movie_id = mr.movie_id
        WHERE YEAR(created_at) = 2020 AND MONTH(created_at) = 2
    GROUP BY title
    ORDER BY AVG(rating * 1.00) DESC, title
)

SELECT * FROM results
```

## Result set

| results  |
| -------- |
| Daniel   |
| Frozen 2 |