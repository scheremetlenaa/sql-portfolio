# [185. Department Top Three Salaries](https://leetcode.com/problems/department-top-three-salaries/description/)

## Table Of Contents
1. [Problem Statement](#problem-statement)
2. [Datasets used](#datasets-used)
3. [Solutions](#solutions)
4. [Result set](#result-set)

## Problem Statement

A company's executives are interested in seeing who earns the most money in each of the company's departments. A high earner in a department is an employee who has a salary in the top three unique salaries for that department.

Write a solution to find the employees who are high earners in each of the departments.

Return the result table in any order.

## Datasets used

```Employee``` Table:

| Column Name  | Type    |
| ------------ | ------- |
| id           | int     |
| name         | varchar |
| salary       | int     |
| departmentId | int     |

id is the primary key (column with unique values) for this table.
departmentId is a foreign key (reference column) of the ID from the Department table.
Each row of this table indicates the ID, name, and salary of an employee. It also contains the ID of their department.

```Department``` Table:

| Column Name | Type    |
| ----------- | ------- |
| id          | int     |
| name        | varchar |

id is the primary key (column with unique values) for this table.
Each row of this table indicates the ID of a department and its name.

## Solutions

```sql
WITH CTE1 AS (
    SELECT
        d.name AS Department,
        e.name AS Employee,
        salary
    FROM Employee e
    INNER JOIN Department d
        ON e.departmentId = d.id
),

CTE2 AS (
    SELECT
        Department,
        Employee,
        Salary,
        DENSE_RANK() OVER(PARTITION BY Department ORDER BY Salary DESC) AS dns_rnk
    FROM CTE1
)

SELECT
    Department,
    Employee,
    Salary
FROM CTE2
WHERE dns_rnk <= 3
```

## Result set

| Department | Employee | Salary |
| ---------- | -------- | ------ |
| IT         | Max      | 90000  |
| IT         | Joe      | 85000  |
| IT         | Randy    | 85000  |
| IT         | Will     | 70000  |
| Sales      | Henry    | 80000  |
| Sales      | Sam      | 60000  |