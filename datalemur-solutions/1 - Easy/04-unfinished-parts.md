# [Unfinished Parts [Tesla SQL Interview Question]](https://datalemur.com/questions/tesla-unfinished-parts)

## Table Of Contents
1. [Problem Statement](#problem-statement)
2. [Datasets used](#datasets-used)
3. [Solutions](#solutions)
4. [Result set](#result-set)

## Problem Statement

Tesla is investigating production bottlenecks and they need your help to extract the relevant data. Write a query to determine which parts have begun the assembly process but are not yet finished.

Assumptions:

- ```parts_assembly``` table contains all parts currently in production, each at varying stages of the assembly process.
- An unfinished part is one that lacks a ```finish_date```.

This question is straightforward, so let's approach it with simplicity in both thinking and solution.

## Datasets used

```parts_assembly``` Table:

|  Column Name  | Type          |
| ------------- | ------------- |
| part | string |
| finish_date | datetime |
| assembly_step | integer |

## Solutions

```sql
SELECT part, assembly_step
FROM parts_assembly
WHERE finish_date IS NULL;
```

## Result set

| part | assembly_step |
| ---- | ------------- |
| bumper | 3 |
| bumper | 4 |
| engine | 5 |