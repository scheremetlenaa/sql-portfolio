# [Role Ordering](https://www.interviewbit.com/problems/role-ordering/)

## Table Of Contents
1. [Problem Statement](#problem-statement)
2. [Datasets used](#datasets-used)
3. [Solutions](#solutions)
4. [Result set](#result-set)

## Problem Statement

Given a table GAMERS, pivot the table in such a manner that the Player is sorted in alphabetical order and displayed under its corresponding Role. Print NULL if no more players are associated with the corresponding role. The roles are Healer, Attacker, Defender, Tactician.

## Datasets used

```GAMERS``` Table:

| Field  | Type         |
| ------ | ------------ |
| Player | VARCHAR(255) |
| Role   | VARCHAR(255) |

## Solutions

```sql
SELECT
    MAX(CASE WHEN Role = 'Healer' THEN Player ELSE NULL END) AS "MIN(Healer)",
    MAX(CASE WHEN Role = 'Attacker' THEN Player ELSE NULL END) AS "MIN(Attacker)"   ,
    MAX(CASE WHEN Role = 'Defender' THEN Player ELSE NULL END) AS "MIN(Defender)",
    MAX(CASE WHEN Role = 'Tactician' THEN Player ELSE NULL END) AS "MIN(Tactician)"

FROM (
    SELECT
        Player,
        Role,
        (SELECT COUNT(*) FROM GAMERS g2 WHERE g2.Role = g1.Role AND g2.Player <= g1.Player) AS row_num
    FROM GAMERS g1
) AS t
GROUP BY row_num;
```

## Result set

| **MIN(Healer)** | **MIN(Attacker)** | **MIN(Defender)** | **MIN(Tactician)** |
| --------------- | ----------------- | ----------------- | ------------------ |
| Lila            | Inga              | Alyda             | Aili               |
| NULL            | Margette          | Cathie            | Basia              |
| NULL            | Rosaline          | Chere             | Bertine            |
| NULL            | Tamqrah           | Janis             | Diena              |
| NULL            | NULL              | Nessie            | Evita              |
| NULL            | NULL              | Teriann           | Hayley             |
| NULL            | NULL              | NULL              | Janey              |
| NULL            | NULL              | NULL              | Kayla              |
| NULL            | NULL              | NULL              | Tera               |