# [Draw The Triangle 2](https://www.hackerrank.com/challenges/draw-the-triangle-2/)

## Table Of Contents
1. [Problem Statement]()
2. [Solutions]()
3. [Result set]()

## Problem Statement

P(R) represents a pattern drawn by Julia in R rows. The following pattern represents P(5):

```
* 
* * 
* * * 
* * * * 
* * * * *
```

Write a query to print the pattern P(20).

## Solutions

```sql
SET @row := 0;
SELECT REPEAT('* ', @row := @row + 1) 
FROM information_schema.tables 
WHERE @row < 20
```

## Result set

```
* 
* * 
* * * 
* * * * 
* * * * * 
* * * * * * 
* * * * * * * 
* * * * * * * * 
* * * * * * * * * 
* * * * * * * * * * 
* * * * * * * * * * * 
* * * * * * * * * * * * 
* * * * * * * * * * * * * 
* * * * * * * * * * * * * * 
* * * * * * * * * * * * * * * 
* * * * * * * * * * * * * * * * 
* * * * * * * * * * * * * * * * * 
* * * * * * * * * * * * * * * * * * 
* * * * * * * * * * * * * * * * * * * 
* * * * * * * * * * * * * * * * * * * * 
```
