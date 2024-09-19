# [Short Films](https://www.interviewbit.com/problems/short-films/)

## Table Of Contents
1. [Problem Statement]()
2. [Datasets used]()
3. [Solutions]()
4. [Result set]()

## Problem Statement

Write a SQL Query to find those lowest duration movies along with the year, director’s name(first and last name combined), actor’s name(first and last name combined) and his/her role in that production.

## Datasets used

![schema design](https://s3-us-west-2.amazonaws.com/ib-assessment-tests/problem_images/sql_course.jpg)

## Solutions

```sql
SELECT
    movie_title,
    movie_year,
    CONCAT(director_first_name, director_last_name) AS director_name,
    CONCAT(actor_first_name, actor_last_name) AS actor_name,
    role
FROM movies m
INNER JOIN movies_directors md
    ON m.movie_id = md.movie_id
INNER JOIN directors d
    ON md.director_id = d.director_id
INNER JOIN movies_cast mc
    ON m.movie_id = mc.movie_id
INNER JOIN actors a
    ON mc.actor_id = a.actor_id
WHERE movie_time = (SELECT MIN(movie_time) FROM movies);
```

## Result set

| **movie_title** | **movie_year** | **director_name** | **actor_name** | **role**   |
| --------------- | -------------- | ----------------- | -------------- | ---------- |
| AnnieHall       | 1977           | WoodyAllen        | WoodyAllen     | AlvySinger |