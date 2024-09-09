# [IBM db2 Product Analytics [IBM SQL Interview Question]](https://datalemur.com/questions/sql-ibm-db2-product-analytics)

## Table Of Contents
1. [Problem Statement]()
2. [Datasets used]()
3. [Solutions]()
4. [Result set]()

## Problem Statement

IBM is analyzing how their employees are utilizing the Db2 database by tracking the SQL queries executed by their employees. The objective is to generate data to populate a histogram that shows the number of unique queries run by employees during the third quarter of 2023 (July to September). Additionally, it should count the number of employees who did not run any queries during this period.

Display the number of unique queries as histogram categories, along with the count of employees who executed that number of unique queries.

## Datasets used

```queries``` Table:

|  Column Name  | Type          | Description |
| ------------- | ------------- | ----------- |
| employee_id | integer |	The ID of the employee who executed the query. |
| query_id |	integer	| The unique identifier for each query (Primary Key). |
| query_starttime |	datetime |	The timestamp when the query started. |
| execution_time |	integer	| The duration of the query execution in seconds. |

```employees``` Table:

Assume that the table below displays all employees in the table:

| Column Name |	Type | Description |
| ----------- | ---- | ----------- |
| employee_id |	integer |	The ID of the employee who executed the query. |
| full_name |	string |	The full name of the employee. |
| gender |	string |	The gender of the employee. |

## Solutions

```sql
SELECT
  unique_queries,
  COUNT(employee_id) AS employee_count
FROM (
    SELECT
        employees.employee_id,
        COALESCE(COUNT(DISTINCT query_id), 0) AS unique_queries
    FROM employees
    LEFT JOIN queries 
    ON queries.employee_id = employees.employee_id
    AND query_starttime >= '07/01/2023 00:00:00'
    AND query_starttime < '10/01/2023 00:00:00'
    GROUP BY employees.employee_id
) t1
GROUP BY unique_queries
ORDER BY unique_queries;
```

## Result set

| unique_queries | employee_count |
| -------------- | -------------- |
| 0 |	94 |
| 1 |	86 |
| 2 |	46 |
| 3 |	19 |
| 4 |	4 |
| 5 |	1 |
