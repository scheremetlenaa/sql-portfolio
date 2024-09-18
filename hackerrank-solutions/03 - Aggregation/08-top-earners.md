# [Top Earners](https://www.hackerrank.com/challenges/earnings-of-employees/)

## Table Of Contents
1. [Problem Statement]()
2. [Datasets used]()
3. [Solutions]()
4. [Result set]()

## Problem Statement

We define an employee's total earnings to be their monthly salary X months worked, and the maximum total earnings to be the maximum total earnings for any employee in the Employee table. Write a query to find the maximum total earnings for all employees as well as the total number of employees who have maximum total earnings. Then print these values as 2 space-separated integers.

## Datasets used

```Employee``` Table:

| Column      | Type    |
| ----------- | ------- |
| employee_id | Integer |
| name        | String  |
| months      | Integer |
| salary      | Integer |

## Solutions

```sql
SELECT 
    salary*months AS total_earnings, 
    COUNT(*)
FROM Employee
GROUP BY total_earnings
HAVING total_earnings = (SELECT MAX(salary*months) FROM Employee);
```

## Result set

| total_earnings | COUNT |
| -------------- | ----- |
| 108064         | 7     |