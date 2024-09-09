# [Top Three Salaries [FAANG SQL Interview Question]](https://datalemur.com/questions/sql-top-three-salaries)

## Table Of Contents
1. [Problem Statement]()
2. [Datasets used]()
3. [Solutions]()
4. [Result set]()

## Problem Statement

As part of an ongoing analysis of salary distribution within the company, your manager has requested a report identifying high earners in each department. A 'high earner' within a department is defined as an employee with a salary ranking among the top three salaries within that department.

You're tasked with identifying these high earners across all departments. Write a query to display the employee's name along with their department name and salary. In case of duplicates, sort the results of department name in ascending order, then by salary in descending order. If multiple employees have the same salary, then order them alphabetically.

Note: Ensure to utilize the appropriate ranking window function to handle duplicate salaries effectively.

## Datasets used

```employee``` Table:

|  Column Name  | Type          | Description |
| ------------- | ------------- | ----------- |
| employee_id |	integer	| The unique ID of the employee. |
| name |	string |	The name of the employee. |
| salary |	integer |	The salary of the employee. |
| department_id |	integer |	The department ID of the employee. |
| manager_id |	integer |	The manager ID of the employee. |

## Solutions

```sql
SELECT
    department_name,
    name,
    salary
FROM (
    SELECT
        department_name,
        name,
        salary,
        DENSE_RANK() OVER (PARTITION BY department_name ORDER BY salary DESC) AS ranking
    FROM employee
    INNER JOIN department
        ON department.department_id = employee.department_id
) t1
WHERE ranking <= 3
ORDER BY department_name, salary DESC, name;
```

## Result set

| department_name | name | salary |
| --------------- | ---- | ------ |
| Data Analytics |	Olivia Smith |	7000 |
| Data Analytics |	Amelia Lee |	4000 |
| Data Analytics |	James Anderson |	4000 |
| Data Analytics |	Emma Thompson |	3800 |
| Data Engineering |	Liam Brown |	13000 |
| Data Engineering |	Ava Garcia |	12500 |
| Data Engineering |	Isabella Wilson |	11000 |
| Data Science |	Logan Moore |	8000 |
| Data Science |	Charlotte Miller |	7000 |
| Data Science |	Noah Johnson |	6800 |
| Data Science |	William Davis |	6800 |