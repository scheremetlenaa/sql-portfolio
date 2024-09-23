# [Study Update](https://www.interviewbit.com/problems/study-update/)

## Table Of Contents
1. [Problem Statement](#problem-statement)
2. [Datasets used](#datasets-used)
3. [Solutions](#solutions)
4. [Result set](#result-set)

## Problem Statement

Given a table STUDY, update the marks of all the students to 50, whose marks lie in the range 25 - 50 (excluding 25 , including 50 i.e. (25,50] ) . Then print the new table.

## Datasets used

```STUDY``` Table:

| Field | Type         |
| ----- | ------------ |
| ID    | INT          |
| Name  | VARCHAR(255) |
| Age   | INT          |
| Marks | INT          |

## Solutions

```sql
UPDATE STUDY
SET Marks = 50
WHERE Marks BETWEEN 26 AND 50;

SELECT * FROM STUDY;
```

## Result set

| **ID** | **Name**  | **Age** | **Marks** |
| ------ | --------- | ------- | --------- |
| 1      | Betta     | 24      | 19        |
| 2      | Allyce    | 20      | 50        |
| 3      | Maryellen | 22      | 83        |
| 4      | Trudie    | 23      | 79        |
| 5      | Leona     | 18      | 50        |
| 6      | Elbertina | 21      | 24        |
| 7      | Gale      | 21      | 7         |
| 8      | Magdalena | 24      | 71        |
| 9      | Chastity  | 23      | 84        |
| 10     | Gilligan  | 20      | 75        |
| 11     | Roslyn    | 18      | 50        |
| 12     | Jillayne  | 19      | 76        |
| 13     | Aili      | 20      | 50        |
| 14     | Minda     | 18      | 89        |
| 15     | Georgetta | 24      | 12        |
| 16     | Edee      | 20      | 65        |
| 17     | Tomasina  | 22      | 50        |
| 18     | Rori      | 19      | 88        |
| 19     | Latisha   | 22      | 61        |
| 20     | Melanie   | 23      | 69        |
| 21     | Lynde     | 23      | 84        |
| 22     | Mahalia   | 19      | 17        |
| 23     | Lilith    | 19      | 64        |
| 24     | Sara-Ann  | 23      | 61        |
| 25     | Nicoli    | 22      | 9         |
| 26     | Emma      | 22      | 10        |
| 27     | Helsa     | 20      | 25        |
| 28     | Mary      | 22      | 97        |
| 29     | Goldie    | 21      | 50        |
| 30     | Patricia  | 21      | 50        |
| 31     | Estell    | 23      | 69        |
| 32     | Agathe    | 23      | 50        |
| 33     | Arlina    | 20      | 96        |
| 34     | Mildrid   | 20      | 55        |
| 35     | Margette  | 22      | 13        |
| 36     | Hannis    | 22      | 80        |
| 37     | Brynna    | 20      | 76        |
| 38     | Jasmina   | 19      | 73        |
| 39     | Lusa      | 21      | 50        |
| 40     | Kayla     | 19      | 58        |
| 41     | Bee       | 19      | 50        |
| 42     | Augustine | 18      | 73        |
| 43     | Deirdre   | 20      | 11        |
| 44     | Sharai    | 19      | 50        |
| 45     | Lusa      | 20      | 2         |
| 46     | Alexine   | 23      | 50        |
| 47     | Fayre     | 23      | 1         |
| 48     | Etta      | 19      | 100       |
| 49     | Henriette | 20      | 50        |
| 50     | Marjie    | 19      | 6         |