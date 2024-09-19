# [Role Player](https://www.interviewbit.com/problems/role-player/)

## Table Of Contents
1. [Problem Statement]()
2. [Datasets used]()
3. [Solutions]()
4. [Result set]()

## Problem Statement

Given a table GAMERS, query for a list sorted by alphabetical order of all the Players in the table, followed by the First letter of the Role each player plays in the game enclosed in braces (). Example: Ram(H)

## Datasets used

```GAMERS``` Table:

| Field  | Type         |
| ------ | ------------ |
| Player | VARCHAR(255) |
| Role   | VARCHAR(255) |

## Solutions

```sql
SELECT
    CONCAT(Player, '(', LEFT(Role, 1), ')') AS N
FROM GAMERS
ORDER BY N;
```

## Result set

| **N**       |
| ----------- |
| Aili(T)     |
| Alyda(D)    |
| Basia(T)    |
| Bertine(T)  |
| Cathie(D)   |
| Chere(D)    |
| Diena(T)    |
| Evita(T)    |
| Hayley(T)   |
| Inga(A)     |
| Janey(T)    |
| Janis(D)    |
| Kayla(T)    |
| Lila(H)     |
| Margette(A) |
| Nessie(D)   |
| Rosaline(A) |
| Tamqrah(A)  |
| Tera(T)     |
| Teriann(D)  |