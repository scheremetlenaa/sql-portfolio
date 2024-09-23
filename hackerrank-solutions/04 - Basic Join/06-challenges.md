# [Challenges](https://www.hackerrank.com/challenges/challenges/)

## Table Of Contents
1. [Problem Statement](#problem-statement)
2. [Datasets used](#datasets-used)
3. [Solutions](#solutions)
4. [Result set](#result-set)

## Problem Statement

Julia asked her students to create some coding challenges. Write a query to print the hacker_id, name, and the total number of challenges created by each student. Sort your results by the total number of challenges in descending order. If more than one student created the same number of challenges, then sort the result by hacker_id. If more than one student created the same number of challenges and the count is less than the maximum number of challenges created, then exclude those students from the result.

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

## Solutions

```sql
WITH CTE AS (
    SELECT
        h.hacker_id,
        name,
        COUNT(challenge_id) AS cnt
    FROM Hackers h
    INNER JOIN Challenges c
        ON h.hacker_id = c.hacker_id
    GROUP BY h.hacker_id, name
)

SELECT
    hacker_id,
    name,
    cnt
FROM CTE
WHERE cnt IN (SELECT cnt FROM CTE GROUP BY cnt HAVING COUNT(*) = 1)
OR cnt = (SELECT MAX(cnt) FROM CTE)
ORDER BY cnt DESC, hacker_id
```

## Result set

The result table is truncated.

| hacker_id | name       | cnt |
| --------- | ---------- | --- |
| 5120      | Julia      | 50  |
| 18425     | Anna       | 50  |
| 20023     | Brian      | 50  |
| 33625     | Jason      | 50  |
| 41805     | Benjamin   | 50  |
| 52462     | Nicholas   | 50  |
| 64036     | Craig      | 50  |
| 69471     | Michelle   | 50  |
| 77173     | Mildred    | 50  |
| 94278     | Dennis     | 50  |
| 96009     | Russell    | 50  |
| 96716     | Emily      | 50  |
| 72866     | Eugene     | 42  |
| 37068     | Patrick    | 41  |
| 12766     | Jacqueline | 40  |
| 86280     | Beverly    | 37  |
| 19835     | Joyce      | 36  |
| 38316     | Walter     | 35  |
| 29483     | Jeffrey    | 34  |
| 23428     | Arthur     | 33  |