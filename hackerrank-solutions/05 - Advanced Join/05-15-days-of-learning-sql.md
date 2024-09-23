# [15 Days of Learning SQL](https://www.hackerrank.com/challenges/15-days-of-learning-sql/)

## Table Of Contents
1. [Problem Statement](#problem-statement)
2. [Datasets used](#datasets-used)
3. [Solutions](#solutions)
4. [Result set](#result-set)

## Problem Statement

Julia conducted a 15 days of learning SQL contest. The start date of the contest was March 01, 2016 and the end date was March 15, 2016.

Write a query to print total number of unique hackers who made at least 1 submission each day (starting on the first day of the contest), and find the hacker_id and name of the hacker who made maximum number of submissions each day. If more than one such hacker has a maximum number of submissions, print the lowest hacker_id. The query should print this information for each day of the contest, sorted by the date.

## Datasets used

```Hackers``` Table:

| Column    | Type    |
| --------- | ------- |
| hacker_id | Integer |
| name      | String  |

The hacker_id is the id of the hacker, and name is the name of the hacker.

```Submissions``` Table:

| Column          | Type    |
| --------------- | ------- |
| submission_date | Date    |
| submission_id   | Integer |
| hacker_id       | Integer |
| score           | Integer |

The submission_date is the date of the submission, submission_id is the id of the submission, hacker_id is the id of the hacker who made the submission, and score is the score of the submission.

## Solutions

```sql
WITH dates_with_rnk AS (
    SELECT
        submission_date_dist,
        ROW_NUMBER() OVER (ORDER BY submission_date_dist) AS dates_rnk
    FROM (SELECT DISTINCT submission_date AS submission_date_dist FROM Submissions) t1
),

hackers_with_rnk AS (
    SELECT
        hacker_id,
        submission_date,
        DENSE_RANK() OVER(PARTITION BY hacker_id ORDER BY submission_date, hacker_id) AS dns_rnk
    FROM Submissions
),

grouped_hackers_with_streak AS (
    SELECT
        submission_date_dist,
        hacker_id
    FROM dates_with_rnk dwr
    LEFT JOIN hackers_with_rnk hwr ON dwr.submission_date_dist = hwr.submission_date
    AND dwr.dates_rnk = hwr.dns_rnk
    GROUP BY submission_date_dist, hacker_id
),

submissions_per_day AS (
    SELECT
        submission_date,
        hacker_id,
        COUNT(*) AS counted_submissions
    FROM Submissions
    GROUP BY submission_date, hacker_id
),

submissions_daily AS (
    SELECT
        submission_date,
        hacker_id,
        ROW_NUMBER() OVER(PARTITION BY submission_date ORDER BY counted_submissions DESC, hacker_id) AS rank_hackers_daily
    FROM submissions_per_day 
),

top_submissions_daily AS (
    SELECT
        submission_date,
        sd.hacker_id,
        name
    FROM submissions_daily sd
    INNER JOIN Hackers h ON sd.hacker_id = h.hacker_id
    WHERE rank_hackers_daily = 1
),

total_number_of_unique_hackers AS (
    SELECT
        submission_date_dist,
        COUNT(hacker_id) AS total_unique_hackers
    FROM grouped_hackers_with_streak
    GROUP BY submission_date_dist
)

SELECT
    submission_date_dist,
    total_unique_hackers,
    hacker_id,
    name
FROM total_number_of_unique_hackers tnuh
INNER JOIN top_submissions_daily tsd
ON tnuh.submission_date_dist = tsd.submission_date
```

## Result set

| submission_date_dist | total_unique_hackers | hacker_id | name      |
| -------------------- | -------------------- | --------- | --------- |
| 2016-03-01           | 112                  | 81314     | Denise    |
| 2016-03-02           | 59                   | 39091     | Ruby      |
| 2016-03-03           | 51                   | 18105     | Roy       |
| 2016-03-04           | 49                   | 533       | Patrick   |
| 2016-03-05           | 49                   | 7891      | Stephanie |
| 2016-03-06           | 49                   | 84307     | Evelyn    |
| 2016-03-07           | 35                   | 80682     | Deborah   |
| 2016-03-08           | 35                   | 10985     | Timothy   |
| 2016-03-09           | 35                   | 31221     | Susan     |
| 2016-03-10           | 35                   | 43192     | Bobby     |
| 2016-03-11           | 35                   | 3178      | Melissa   |
| 2016-03-12           | 35                   | 54967     | Kenneth   |
| 2016-03-13           | 35                   | 30061     | Julia     |
| 2016-03-14           | 35                   | 32353     | Rose      |
| 2016-03-15           | 35                   | 27789     | Helen     |