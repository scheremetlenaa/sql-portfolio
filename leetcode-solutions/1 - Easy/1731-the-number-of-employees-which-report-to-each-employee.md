# [1731. The Number of Employees Which Report to Each Employee](https://leetcode.com/problems/the-number-of-employees-which-report-to-each-employee/description/)

## Table Of Contents
1. [Problem Statement]()
2. [Datasets used]()
3. [Solutions]()
4. [Result set]()

## Problem Statement

For this problem, we will consider a manager an employee who has at least 1 other employee reporting to them.

Write a solution to report the ids and the names of all managers, the number of employees who report directly to them, and the average age of the reports rounded to the nearest integer.

Return the result table ordered by employee_id.

## Datasets used

```Employees``` Table:

| Column Name | Type     |
| ----------- | -------- |
| employee_id | int      |
| name        | varchar  |
| reports_to  | int      |
| age         | int      |

employee_id is the column with unique values for this table.
This table contains information about the employees and the id of the manager they report to. Some employees do not report to anyone (reports_to is null). 

## Solutions

```sql
SELECT
    e1.employee_id,
    e1.name,
    COUNT(e2.reports_to) AS reports_count,
    ROUND(AVG(e2.age * 1.00), 0) AS average_age
FROM Employees e1
LEFT JOIN Employees e2
    ON e1.employee_id = e2.reports_to   
WHERE e2.reports_to IS NOT NULL
GROUP BY e1.employee_id, e1.name
ORDER BY e1.employee_id;
```

## Result set

| employee_id | name  | reports_count | average_age |
| ----------- | ----- | ------------- | ----------- |
| 9           | Hercy | 2             | 39          |