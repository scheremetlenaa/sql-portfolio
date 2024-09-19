# [1978. Employees Whose Manager Left the Company](https://leetcode.com/problems/employees-whose-manager-left-the-company/description/)

## Table Of Contents
1. [Problem Statement]()
2. [Datasets used]()
3. [Solutions]()
4. [Result set]()

## Problem Statement

Find the IDs of the employees whose salary is strictly less than $30000 and whose manager left the company. When a manager leaves the company, their information is deleted from the Employees table, but the reports still have their manager_id set to the manager that left.

Return the result table ordered by employee_id.

## Datasets used

```Employees``` Table:

| Column Name | Type     |
| ----------- | -------- |
| employee_id | int      |
| name        | varchar  |
| manager_id  | int      |
| salary      | int      |

In SQL, employee_id is the primary key for this table.
This table contains information about the employees, their salary, and the ID of their manager. Some employees do not have a manager (manager_id is null). 

## Solutions

```sql
SELECT
    employee_id
FROM Employees
WHERE salary < 30000
AND manager_id NOT IN (
    SELECT
        employee_id
    FROM Employees
)
ORDER BY employee_id;
```

## Result set

| employee_id |
| ----------- |
| 11          |