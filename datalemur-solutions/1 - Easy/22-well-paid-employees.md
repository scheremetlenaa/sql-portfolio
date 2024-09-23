# [Well Paid Employees [FAANG SQL Interview Question]](https://datalemur.com/questions/sql-well-paid-employees)

## Table Of Contents
1. [Problem Statement](#problem-statement)
2. [Datasets used](#datasets-used)
3. [Solutions](#solutions)
4. [Result set](#result-set)

## Problem Statement

Companies often perform salary analyses to ensure fair compensation practices. One useful analysis is to check if there are any employees earning more than their direct managers.

As a HR Analyst, you're asked to identify all employees who earn more than their direct managers. The result should include the employee's ID and name.

## Datasets used

```employee``` Table:

|  Column Name  | Type          | Description | 
| ------------- | ------------- | ----------- |
| employee_id |	integer |	The unique ID of the employee. |
| name |	string |	The name of the employee. |
| salary |	integer |	The salary of the employee. |
| department_id |	integer	| The department ID of the employee. |
| manager_id |	integer |	The manager ID of the employee.|

## Solutions

```sql
SELECT
    emp.employee_id AS employee_id,
    emp.name AS employee_name
FROM employee mn
INNER JOIN employee emp
    ON mn.employee_id = emp.manager_id
WHERE emp.salary > mn.salary;
```

## Result set

| employee_id | employee_name |
| ----------- | ------------- |
| 3 |	Olivia Smith |
| 12 |	Benjamin Hernandez |