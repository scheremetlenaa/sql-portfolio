# [Ollivander's Inventory](https://www.hackerrank.com/challenges/harry-potter-and-wands/)

## Table Of Contents
1. [Problem Statement](#problem-statement)
2. [Datasets used](#datasets-used)
3. [Solutions](#solutions)
4. [Result set](#result-set)

## Problem Statement

Harry Potter and his friends are at Ollivander's with Ron, finally replacing Charlie's old broken wand.

Hermione decides the best way to choose is by determining the minimum number of gold galleons needed to buy each non-evil wand of high power and age. Write a query to print the id, age, coins_needed, and power of the wands that Ron's interested in, sorted in order of descending power. If more than one wand has same power, sort the result in order of descending age.

## Datasets used

```Wands``` Table:

| Column       | Type    |
| ------------ | ------- |
| id           | Integer |
| code         | Integer |
| coins_needed | Integer |
| power        | Integer |

The id is the id of the wand, code is the code of the wand, coins_needed is the total number of gold galleons needed to buy the wand, and power denotes the quality of the wand (the higher the power, the better the wand is).

```Wands_Property``` Table:

| Column  | Type    |
| ------- | ------- |
| code    | Integer |
| age     | Integer |
| is_evil | Integer |

The code is the code of the wand, age is the age of the wand, and is_evil denotes whether the wand is good for the dark arts. If the value of is_evil is 0, it means that the wand is not evil. The mapping between code and age is one-one, meaning that if there are two pairs, ```(code1, age1)``` and ```(code2, age2)``` then ```code1 <> code2``` and ```age1 <> age2```

## Solutions

```sql
WITH CTE AS (
    SELECT
        id,
        age,
        coins_needed,
        power,
        ROW_NUMBER() OVER (PARTITION BY power, age ORDER BY coins_needed) AS rw_nm
    FROM Wands w
    INNER JOIN Wands_Property wp
        ON w.code = wp.code
    WHERE is_evil = 0
)

SELECT
    id,
    age,
    coins_needed,
    power
FROM CTE
WHERE rw_nm = 1
ORDER BY power DESC, age DESC;
```

## Result set

The result table is truncated.

| id   | age | coins_needed | power |
| ---- | --- | ------------ | ----- |
| 1038 | 496 | 4789         | 10    |
| 1130 | 494 | 9439         | 10    |
| 1315 | 492 | 4126         | 10    |
| 9    | 491 | 7345         | 10    |
| 858  | 483 | 4352         | 10    |
| 1164 | 481 | 9831         | 10    |
| 1288 | 464 | 4952         | 10    |
| 861  | 462 | 8302         | 10    |
| 412  | 455 | 5625         | 10    |
| 996  | 451 | 8884         | 10    |
| 1608 | 446 | 8351         | 10    |
| 1376 | 443 | 1735         | 10    |
| 1330 | 430 | 5182         | 10    |
| 1633 | 425 | 2206         | 10    |
| 1197 | 419 | 3468         | 10    |
| 441  | 416 | 2508         | 10    |
| 424  | 413 | 997          | 10    |
| 1298 | 397 | 3810         | 10    |
| 1125 | 395 | 2299         | 10    |
| 333  | 393 | 926          | 10    |