# [Employee Salaries](https://www.hackerrank.com/challenges/salary-of-employees/)

## Table Of Contents
1. [Problem Statement](#problem-statement)
2. [Datasets used](#datasets-used)
3. [Solutions](#solutions)
4. [Result set](#result-set)

## Problem Statement

Write a query that prints a list of employee names (i.e.: the name attribute) for employees in Employee having a salary greater than $2000 per month who have been employees for less than 10 months. Sort your result by ascending employee_id.

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
SELECT 
    name
FROM Employee
WHERE salary > 2000 
AND months < 10;
```

## Result set

The result table is truncated.

| Name      |
|-----------|
| Rose      |
| Patrick   |
| Lisa      |
| Amy       |
| Pamela    |
| Jennifer  |
| Julia     |
| Kevin     |
| Paul      |
| Donna     |
| Michelle  |
| Christina |
| Brandon   |
| Joseph    |
| Jesse     |
| Paula     |
| Louise    |
| Evelyn    |
| Emily     |
| Jonathan  |