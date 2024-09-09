# [Employee Names](https://www.hackerrank.com/challenges/name-of-employees/)

## Table Of Contents
1. [Problem Statement]()
2. [Datasets used]()
3. [Solutions]()
4. [Result set]()

## Problem Statement

Write a query that prints a list of employee names (i.e.: the name attribute) from the Employee table in alphabetical order.

## Datasets used

```Employee``` Table:

| Column      | Type    |
|-------------|---------|
| employee_id | Integer |
| name        | String  |
| months      | Integer |
| salary      | Integer |

where employee_id is an employee's ID number, name is their name, months is the total number of months they've been working for the company, and salary is their monthly salary.

## Solutions

```sql
SELECT name
FROM employee
ORDER BY name;
```

## Result set

The result table is truncated.

| Name      |
|-----------|
| Alan      |
| Amy       |
| Andrew    |
| Andrew    |
| Angela    |
| Ann       |
| Anna      |
| Anthony   |
| Antonio   |
| Benjamin  |
| Bonnie    |
| Brandon   |
| Brandon   |
| Brian     |
| Carol     |
| Charles   |
| Christina |
| Christina |
| Christine |
| Christine |