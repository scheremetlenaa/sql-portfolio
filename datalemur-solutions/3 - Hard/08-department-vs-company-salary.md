# [Department vs. Company Salary [FAANG SQL Interview Question]](https://datalemur.com/questions/sql-department-company-salary-comparison)

## Table Of Contents
1. [Problem Statement](#problem-statement)
2. [Datasets used](#datasets-used)
3. [Solutions](#solutions)
4. [Result set](#result-set)

## Problem Statement

You work as a data analyst for a FAANG company that tracks employee salaries over time. The company wants to understand how the average salary in each department compares to the company's overall average salary each month.

Write a query to compare the average salary of employees in each department to the company's average salary for March 2024. Return the comparison result as 'higher', 'lower', or 'same' for each department. Display the department ID, payment month (in MM-YYYY format), and the comparison result.

## Datasets used

```employee``` Table:

|  Column Name  | Type          | Description |
| ------------- | ------------- | ----------- |
| employee_id |	integer	| The unique ID of the employee. |
| name |	string |	The name of the employee. |
| salary |	integer |	The salary of the employee. |
| department_id |	integer |	The department ID of the employee. |
| manager_id |	integer |	The manager ID of the employee. |

```salary``` Table:

| column_name | type | description |
| ----------- | ---- | ----------- |
| salary_id |	integer |	A unique ID for each salary record. |
| employee_id |	integer |	The unique ID of the employee. |
| amount |	integer | The salary of the employee. |
| payment_date |	datetime |	The date and time when the salary was paid to the employee. |


## Solutions

```sql
SELECT
    department_id,
    TO_CHAR(payment_date::date, 'mm-yyyy') AS payment_date,
    CASE
        WHEN AVG(amount) < (SELECT AVG(amount) FROM salary WHERE payment_date BETWEEN '03/01/2024' AND '03/31/2024')
        THEN 'lower'
        WHEN AVG(amount) > (SELECT AVG(amount) FROM salary WHERE payment_date BETWEEN '03/01/2024' AND '03/31/2024')
        THEN 'higher'
        ELSE 'same'
    END AS comparison
FROM employee e
INNER JOIN salary s
    ON e.employee_id = s.employee_id
WHERE payment_date BETWEEN '03/01/2024' AND '03/31/2024'
GROUP BY department_id, TO_CHAR(payment_date::date, 'mm-yyyy');
```

## Result set

| department_id | payment_date | comparison |
| ------------- | ------------ | ---------- |
| 1 |	03-2024 |	lower |
| 2 |	03-2024 |	lower |
| 3 |	03-2024 |	higher |