# [Neutral Reviewers](https://www.interviewbit.com/problems/neutral-reviewers/)

## Table Of Contents
1. [Problem Statement]()
2. [Datasets used]()
3. [Solutions]()
4. [Result set]()

## Problem Statement

Write a SQL Query to find the name of all reviewers who have rated their ratings with a NULL value.

## Datasets used

![schema design](https://s3-us-west-2.amazonaws.com/ib-assessment-tests/problem_images/sql_course.jpg)

## Solutions

```sql
SELECT
    reviewer_name
FROM reviewers r
INNER JOIN ratings rat
    ON r.reviewer_id = rat.reviewer_id
WHERE reviewer_stars IS NULL;
```

## Result set

| **reviewer_name** |
| ----------------- |
| NealWruck         |
| ScottLeBrun       |