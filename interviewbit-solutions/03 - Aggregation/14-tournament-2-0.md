# [Tournament 2.0](https://www.interviewbit.com/problems/tournament-2-0/)

## Table Of Contents
1. [Problem Statement](#problem-statement)
2. [Datasets used](#datasets-used)
3. [Solutions](#solutions)
4. [Result set](#result-set)

## Problem Statement

A tournament is being held where several matches takes place between a player from team 1 and a player from team 2. After every match one of the players is declared as the winner. However there are some players in Team2 who are known cheaters. Write an SQL Query to find the percentage of matches Won by Team1 against a non cheater from team 2 on every day. percentage of wins=(total games won against non cheaters)/(total games played against non cheaters). The percentage of wins should be rounded upto 4 decimals.

Also the name of the output coloumn should be ‘Percentage Wins’. Also the output should be order ascending order of the Dates.

## Datasets used

```Team1``` Table:

| Field | Type    |
| ----- | ------- |
| Id    | INT     |
| Name  | Varchar |

```Team2``` Table:

| Field   | Type    |
| ------- | ------- |
| Id      | INT     |
| Name    | Varchar |
| Cheater | INT     |

## Solutions

```sql
SELECT
    SUM(CASE
        WHEN Result = 1 THEN 1
        ELSE 0
    END) / COUNT(*) AS 'Percentage Wins'
FROM Matches m
INNER JOIN Team1 t1
    ON m.PlayerId1 = t1.Id
INNER JOIN Team2 t2
    ON m.PlayerId2 = t2.Id
    AND t2.Cheater = 0
GROUP BY Date;
```

## Result set

| **Percentage Wins** |
| ------------------- |
| 0.5000              |
| 0.3000              |
| 0.6000              |
| 0.6250              |
| 0.5000              |