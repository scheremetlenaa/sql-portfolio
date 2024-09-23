# [The PADS](https://www.hackerrank.com/challenges/the-pads/)

## Table Of Contents
1. [Problem Statement](#problem-statement)
2. [Datasets used](#datasets-used)
3. [Solutions](#solutions)
4. [Result set](#result-set)

## Problem Statement

Generate the following two result sets:

1. Query an alphabetically ordered list of all names in OCCUPATIONS, immediately followed by the first letter of each profession as a parenthetical (i.e.: enclosed in parentheses). For example: AnActorName(A), ADoctorName(D), AProfessorName(P), and ASingerName(S).
2. Query the number of ocurrences of each occupation in OCCUPATIONS. Sort the occurrences in ascending order, and output them in the following format:
```There are a total of [occupation_count] [occupation]s.```
where ```[occupation_count]``` is the number of occurrences of an occupation in OCCUPATIONS and ```[occupation]``` is the lowercase occupation name. If more than one Occupation has the same ```[occupation_count]```, they should be ordered alphabetically.

Note: There will be at least two entries in the table for each type of occupation.

## Datasets used

```OCCUPATIONS``` Table:

| Column     | Type   |
| ---------- | ------ |
| Name       | String |
| Occupation | String |

## Solutions

```sql
SELECT 
    CONCAT(Name, '(', LEFT(Occupation, 1), ')')
FROM OCCUPATIONS
ORDER BY Name;

SELECT 
    CONCAT('There are a total of ', COUNT(*), ' ', LOWER(Occupation), 's.')
FROM OCCUPATIONS
GROUP BY Occupation
ORDER BY COUNT(*), Occupation;
```

## Result set

|              |
| ------------ |
| Aamina(D)    |
| Ashley(P)    |
| Belvet(P)    |
| Britney(P)   |
| Christeen(S) |
| Eve(A)       |
| Jane(S)      |
| Jennifer(A)  |
| Jenny(S)     |
| Julia(D)     |
| Ketty(A)     |
| Kristeen(S)  |
| Maria(P)     |
| Meera(P)     |
| Naomi(P)     |