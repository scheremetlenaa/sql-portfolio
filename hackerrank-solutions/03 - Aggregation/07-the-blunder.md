# [The Blunder](https://www.hackerrank.com/challenges/the-blunder/)

## Table Of Contents
1. [Problem Statement](#problem-statement)
2. [Datasets used](#datasets-used)
3. [Solutions](#solutions)
4. [Result set](#result-set)

## Problem Statement

Samantha was tasked with calculating the average monthly salaries for all employees in the EMPLOYEES table, but did not realize her keyboard's 0 key was broken until after completing the calculation. She wants your help finding the difference between her miscalculation (using salaries with any zeros removed), and the actual average salary.

Write a query calculating the amount of error (i.e.: actual - miscalculated average monthly salaries), and round it up to the next integer.

## Datasets used

```EMPLOYEES``` Table:

| Column | Type    |
| ------ | ------- |
| ID     | Integer |
| Name   | String  |
| Salary | Integer |

## Solutions

```sql
SELECT 
    CEIL(AVG(Salary) - AVG(REPLACE(Salary,0,''))) 
FROM EMPLOYEES;
```

## Result set

|      |
| ---- |
| 2253 |