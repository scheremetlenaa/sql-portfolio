# [Contest Leaderboard](https://www.hackerrank.com/challenges/contest-leaderboard/)

## Table Of Contents
1. [Problem Statement](#problem-statement)
2. [Datasets used](#datasets-used)
3. [Solutions](#solutions)
4. [Result set](#result-set)

## Problem Statement

You did such a great job helping Julia with her last coding contest challenge that she wants you to work on this one, too!

The total score of a hacker is the sum of their maximum scores for all of the challenges. Write a query to print the hacker_id, name, and total score of the hackers ordered by the descending score. If more than one hacker achieved the same total score, then sort the result by ascending hacker_id. Exclude all hackers with a total score of 0 from your result.

## Datasets used

```Hackers``` Table:

| Column    | Type    |
| --------- | ------- |
| hacker_id | Integer |
| name      | String  |

The hacker_id is the id of the hacker, and name is the name of the hacker.

```Submissions``` Table:

| Column        | Type    |
| ------------- | ------- |
| submission_id | Integer |
| hacker_id     | Integer |
| challenge_id  | Integer |
| score         | Integer |

The submission_id is the id of the submission, hacker_id is the id of the hacker who made the submission, challenge_id is the id of the challenge for which the submission belongs to, and score is the score of the submission.

## Solutions

```sql
WITH CTE AS (
    SELECT
        h.hacker_id,
        s.challenge_id,
        name,
        MAX(score) AS max_score
    FROM Hackers h
    INNER JOIN Submissions s
        ON h.hacker_id = s.hacker_id
    GROUP BY h.hacker_id, s.challenge_id, name
)

SELECT
    hacker_id,
    name,
    SUM(max_score) AS total_score
FROM CTE
GROUP BY hacker_id, name
HAVING SUM(max_score) > 0
ORDER BY total_score DESC, hacker_id;
```

## Result set

The result table is truncated.

| hacker_id | name      | total_score |
| --------- | --------- | ----------- |
| 76971     | Ashley    | 760         |
| 84200     | Susan     | 710         |
| 76615     | Ryan      | 700         |
| 82382     | Sara      | 640         |
| 79034     | Marilyn   | 580         |
| 78552     | Harry     | 570         |
| 74064     | Helen     | 540         |
| 78688     | Sean      | 540         |
| 83832     | Jason     | 540         |
| 72796     | Jose      | 510         |
| 76216     | Carlos    | 510         |
| 90304     | Lillian   | 500         |
| 88507     | Patrick   | 490         |
| 72505     | Keith     | 480         |
| 88018     | Dennis    | 480         |
| 78918     | Julia     | 470         |
| 85319     | Shawn     | 470         |
| 71357     | Bobby     | 460         |
| 72047     | Elizabeth | 460         |
| 74147     | Jason     | 460         |