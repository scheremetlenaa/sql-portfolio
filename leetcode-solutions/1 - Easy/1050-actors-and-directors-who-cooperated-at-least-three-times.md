# [1050. Actors and Directors Who Cooperated At Least Three Times](https://leetcode.com/problems/actors-and-directors-who-cooperated-at-least-three-times/description/)

## Table Of Contents
1. [Problem Statement]()
2. [Datasets used]()
3. [Solutions]()
4. [Result set]()

## Problem Statement

Write a solution to find all the pairs (actor_id, director_id) where the actor has cooperated with the director at least three times.

Return the result table in any order.

## Datasets used

```ActorDirector``` Table:

| Column Name | Type    |
| ----------- | ------- |
| actor_id    | int     |
| director_id | int     |
| timestamp   | int     |

timestamp is the primary key (column with unique values) for this table.

## Solutions

```sql
SELECT actor_id, director_id
FROM ActorDirector
GROUP BY actor_id, director_id
HAVING COUNT(*) >= 3;
```

## Result set

| actor_id | director_id |
| -------- | ----------- |
| 1        | 1           |