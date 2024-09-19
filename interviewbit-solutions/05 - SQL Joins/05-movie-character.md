# [Movie Character](https://www.interviewbit.com/problems/movie-character/)

## Table Of Contents
1. [Problem Statement]()
2. [Datasets used]()
3. [Solutions]()
4. [Result set]()

## Problem Statement

Write a SQL Query to find the movie_title and name of director (first and last names combined) who directed a movie that casted a role as ‘SeanMaguire’.

## Datasets used

![schema design](https://s3-us-west-2.amazonaws.com/ib-assessment-tests/problem_images/sql_course.jpg)

## Solutions

```sql
SELECT
    CONCAT(director_first_name, director_last_name) AS director_name,
    movie_title
FROM movies m
INNER JOIN movies_directors md
    ON m.movie_id = md.movie_id
INNER JOIN directors d
    ON md.director_id = d.director_id
INNER JOIN movies_cast mc
    ON m.movie_id = mc.movie_id    
WHERE mc.role = 'SeanMaguire';
```

## Result set

| **director_name** | **movie_title** |
| ----------------- | --------------- |
| GusVanSant        | GoodWillHunting |