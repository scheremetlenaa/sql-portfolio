# [184. Department Highest Salary](https://leetcode.com/problems/department-highest-salary/description/)

## Table Of Contents
1. [Problem Statement]()
2. [Datasets used]()
3. [Solutions]()
4. [Result set]()

## Problem Statement

Write a solution to find employees who have the highest salary in each of the departments.

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
departmentId is a foreign key (reference columns) of the ID from the Department table.
Each row of this table indicates the ID, name, and salary of an employee. It also contains the ID of their department.

```Department``` Table:

| Column Name | Type    |
| ----------- | ------- |
| id          | int     |
| name        | varchar |

id is the primary key (column with unique values) for this table. It is guaranteed that department name is not NULL.
Each row of this table indicates the ID of a department and its name.

## Solutions

```sql
WITH CTE AS (
    SELECT
        e.name AS Employee,
        salary,
        d.name AS Department,
        DENSE_RANK() OVER(PARTITION BY d.name ORDER BY salary DESC) AS dns_rnk
    FROM Employee e
    INNER JOIN Department d
        ON e.departmentId = d.id
)

SELECT
    Department,
    Employee,
    Salary
FROM CTE
WHERE dns_rnk = 1;
```

## Result set

| Department | Employee | Salary |
| ---------- | -------- | ------ |
| IT         | Jim      | 90000  |
| IT         | Max      | 90000  |
| Sales      | Henry    | 80000  |