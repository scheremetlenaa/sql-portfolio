# [Actors and their Movies](https://www.interviewbit.com/problems/actors-and-their-movies/)

## Table Of Contents
1. [Problem Statement]()
2. [Datasets used]()
3. [Solutions]()
4. [Result set]()

## Problem Statement

Write a SQL Query to find the name of those movies where one or more actors acted in two or more movies.

## Datasets used

![schema design](https://s3-us-west-2.amazonaws.com/ib-assessment-tests/problem_images/sql_course.jpg)

## Solutions

```sql
SELECT
    movie_title
FROM movies m
INNER JOIN movies_cast mc
    ON m.movie_id = mc.movie_id
WHERE actor_id IN (
    SELECT
        actor_id
    FROM movies_cast
    GROUP BY actor_id
    HAVING COUNT(movie_id) >= 2
);
```

## Result set

| **movie_title** |
| --------------- |
| AmericanBeauty  |
| BeyondtheSea    |