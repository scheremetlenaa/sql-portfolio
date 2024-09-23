# [Interviews](https://www.hackerrank.com/challenges/interviews/)

## Table Of Contents
1. [Problem Statement](#problem-statement)
2. [Datasets used](#datasets-used)
3. [Solutions](#solutions)
4. [Result set](#result-set)

## Problem Statement

Samantha interviews many candidates from different colleges using coding challenges and contests. Write a query to print the contest_id, hacker_id, name, and the sums of total_submissions, total_accepted_submissions, total_views, and total_unique_views for each contest sorted by contest_id. Exclude the contest from the result if all four sums are 0.

## Datasets used

```Contests``` Table:

| Column     | Type    |
| ---------- | ------- |
| contest_id | Integer |
| hacker_id  | Integer |
| name       | String  |

The contest_id is the id of the contest, hacker_id is the id of the hacker who created the contest, and name is the name of the hacker.

```Colleges``` Table:

| Column     | Type    |
| ---------- | ------- |
| college_id | Integer |
| contest_id | Integer |

The college_id is the id of the college, and contest_id is the id of the contest that Samantha used to screen the candidates.

```Challenges``` Table:

| Column       | Type    |
| ------------ | ------- |
| challenge_id | Integer |
| college_id   | Integer |

The challenge_id is the id of the challenge that belongs to one of the contests whose contest_id Samantha forgot, and college_id is the id of the college where the challenge was given to candidates.

```View_Stats``` Table:

| Column             | Type    |
| ------------------ | ------- |
| challenge_id       | Integer |
| total_views        | Integer |
| total_unique_views | Integer |

The challenge_id is the id of the challenge, total_views is the number of times the challenge was viewed by candidates, and total_unique_views is the number of times the challenge was viewed by unique candidates.

```Submission_Stats``` Table:

| Column                     | Type    |
| -------------------------- | ------- |
| challenge_id               | Integer |
| total_submissions          | Integer |
| total_accepted_submissions | Integer |

The challenge_id is the id of the challenge, total_submissions is the number of submissions for the challenge, and total_accepted_submission is the number of submissions that achieved full scores.

## Solutions

```sql
WITH sum_submissions AS (
    SELECT
                col.contest_id,
                SUM(total_submissions) AS sum_ts,
                SUM(total_accepted_submissions) AS sum_tas
    FROM        Colleges col
    INNER JOIN  Challenges cha ON col.college_id = cha.college_id
    INNER JOIN  Submission_Stats ss ON cha.challenge_id = ss.challenge_id
    GROUP BY    col.contest_id
),

sum_views AS (
    SELECT
                col.contest_id,
                SUM(total_views) AS sum_tv,
                SUM(total_unique_views) AS sum_tuv
    FROM        Colleges col
    INNER JOIN  Challenges cha ON col.college_id = cha.college_id
    INNER JOIN  View_Stats vs ON cha.challenge_id = vs.challenge_id
    GROUP BY    col.contest_id
)
    
SELECT
            con.contest_id,
            con.hacker_id,
            con.name,
            sum_ts,
            sum_tas,
            sum_tv,
            sum_tuv
FROM        Contests con
INNER JOIN  sum_submissions ON con.contest_id = sum_submissions.contest_id
INNER JOIN  sum_views ON con.contest_id = sum_views.contest_id
WHERE       sum_ts > 0
OR          sum_tas > 0
OR          sum_tv > 0
OR          sum_tuv > 0
ORDER BY    con.contest_id;
```

## Result set

The result table is truncated.

| contest_id | hacker_id | name     | sum_ts | sum_tas | sum_tv | sum_tuv |
| ---------- | --------- | -------- | ------ | ------- | ------ | ------- |
| 845        | 579       | Rose     | 1987   | 580     | 1635   | 566     |
| 858        | 1053      | Angela   | 703    | 160     | 1002   | 384     |
| 883        | 1055      | Frank    | 1121   | 319     | 1217   | 338     |
| 1793       | 2655      | Patrick  | 1337   | 360     | 1216   | 412     |
| 2374       | 2765      | Lisa     | 2733   | 815     | 3368   | 904     |
| 2963       | 2845      | Kimberly | 4306   | 1221    | 3603   | 1184    |
| 3584       | 2873      | Bonnie   | 2492   | 652     | 3019   | 954     |
| 4044       | 3067      | Michael  | 1323   | 449     | 1722   | 528     |
| 4249       | 3116      | Todd     | 1452   | 376     | 1767   | 463     |
| 4269       | 3256      | Joe      | 1018   | 372     | 1766   | 530     |
| 4483       | 3386      | Earl     | 1911   | 572     | 1644   | 477     |
| 4541       | 3608      | Robert   | 1886   | 516     | 1694   | 504     |
| 4601       | 3868      | Amy      | 1900   | 639     | 1738   | 548     |
| 4710       | 4255      | Pamela   | 2752   | 639     | 2378   | 705     |
| 4982       | 5639      | Maria    | 2705   | 759     | 2558   | 711     |
| 5913       | 5669      | Joe      | 2646   | 790     | 3181   | 835     |
| 5994       | 5713      | Linda    | 3369   | 967     | 3048   | 954     |
| 6939       | 6550      | Melissa  | 2842   | 859     | 3574   | 1004    |
| 7266       | 6947      | Carol    | 2758   | 665     | 3044   | 835     |
| 7280       | 7030      | Paula    | 1963   | 554     | 886    | 259     |