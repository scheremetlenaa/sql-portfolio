# [103 - Employee Mentor](https://www.namastesql.com/coding-problem/103-employee-mentor)

## Table Of Contents
1. [Problem Statement]()
2. [Datasets used]()
3. [Solutions]()
4. [Result set]()

## Problem Statement

You are given a table Employees that contains information about employees in a company. Each employee might have been mentored by another employee. Your task is to find the names of all employees who were not mentored by the employee with id = 3.

## Datasets used

```employees``` Table:

| COLUMN_NAME | DATA_TYPE   |
| ----------- | ----------- |
| id          | int         |    
| name        | varchar(10) |
| mentor_id   | int         |

## Solutions

```sql
SELECT
	DISTINCT name
FROM employees
WHERE mentor_id <> 3
OR mentor_id IS NULL;
```

## Result set

| name   |
| ------ | 
| Arjun  |
| Sneha  |
| Vikram |
| Priya  |
| Rohan  |
| Amit   |