# [Top Competitors](https://www.hackerrank.com/challenges/full-score/)

## Table Of Contents
1. [Problem Statement](#problem-statement)
2. [Datasets used](#datasets-used)
3. [Solutions](#solutions)
4. [Result set](#result-set)

## Problem Statement

Julia just finished conducting a coding contest, and she needs your help assembling the leaderboard! Write a query to print the respective hacker_id and name of hackers who achieved full scores for more than one challenge. Order your output in descending order by the total number of challenges in which the hacker earned a full score. If more than one hacker received full scores in same number of challenges, then sort them by ascending hacker_id.

## Datasets used

```Hackers``` Table:

| Column    | Type    |
| --------- | ------- |
| hacker_id | Integer |
| name      | String  |

The hacker_id is the id of the hacker, and name is the name of the hacker.

```Challenges``` Table:

| Column       | Type    |
| ------------ | ------- |
| challenge_id | Integer |
| hacker_id    | Integer |

The challenge_id is the id of the challenge, and hacker_id is the id of the student who created the challenge.

```Difficulty``` Table:

| Column           | Type    |
| ---------------- | ------- |
| difficulty_level | Integer |
| score            | Integer |

The difficult_level is the level of difficulty of the challenge, and score is the score of the challenge for the difficulty level.

```Submissions``` Table:

| Column        | Type    |
| ------------- | ------- |
| submission_id | Integer |
| hacker_id     | Integer |
| challenge_id  | Integer |
| score         | Integer |

The submission_id is the id of the submission, hacker_id is the id of the hacker who made the submission, challenge_id is the id of the challenge that the submission belongs to, and score is the score of the submission.

## Solutions

```sql
WITH CTE AS (
    SELECT
        h.hacker_id,
        h.name,
        c.challenge_id,
        d.difficulty_level,
        d.score AS highest_lvl_score,
        s.score AS hacker_score
    FROM Hackers h
    INNER JOIN Submissions s
        ON h.hacker_id = s.hacker_id
    INNER JOIN Challenges c
        ON s.challenge_id = c.challenge_id
    INNER JOIN Difficulty d
        ON c.difficulty_level = d.difficulty_level
    WHERE d.score = s.score
)

SELECT
    hacker_id,
    name
FROM CTE
GROUP BY hacker_id, name
HAVING COUNT(*) > 1
ORDER BY COUNT(*) DESC, hacker_id;
```

## Result set

| hacker_id | name      |
| --------- | --------- |
| 27232     | Phillip   |
| 28614     | Willie    |
| 15719     | Christina |