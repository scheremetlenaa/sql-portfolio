# [New Companies](https://www.hackerrank.com/challenges/the-company/)

## Table Of Contents
1. [Problem Statement](#problem-statement)
2. [Datasets used](#datasets-used)
3. [Solutions](#solutions)
4. [Result set](#result-set)

## Problem Statement

Amber's conglomerate corporation just acquired some new companies. Each of the companies follows this hierarchy: ```Founder -> Lead Manager -> Senior Manager -> Manager -> Employee```.

Given the table schemas below, write a query to print the company_code, founder name, total number of lead managers, total number of senior managers, total number of managers, and total number of employees. Order your output by ascending company_code.

## Datasets used

```Company``` Table:

| Column       | Type   |
| ------------ | ------ |
| company_code | String |
| founder      | String |

The company_code is the code of the company and founder is the founder of the company.

```Lead_Manager``` Table:

| Column            | Type   |
| ----------------- | ------ |
| lead_manager_code | String |
| company_code      | String |

The lead_manager_code is the code of the lead manager, and the company_code is the code of the working company.

```Senior_Manager``` Table:

| Column              | Type   |
| ------------------- | ------ |
| senior_manager_code | String |
| lead_manager_code   | String |
| company_code        | String |

The senior_manager_code is the code of the senior manager, the lead_manager_code is the code of its lead manager, and the company_code is the code of the working company. 

```Manager``` Table:

| Column              | Type   |
| ------------------- | ------ |
| manager_code        | String |
| senior_manager_code | String |
| lead_manager_code   | String |
| company_code        | String |

The manager_code is the code of the manager, the senior_manager_code is the code of its senior manager, the lead_manager_code is the code of its lead manager, and the company_code is the code of the working company. 

```Employee``` Table:

| Column              | Type   |
| ------------------- | ------ |
| employee_code       | String |
| manager_code        | String |
| senior_manager_code | String |
| lead_manager_code   | String |
| company_code        | String |

The employee_code is the code of the employee, the manager_code is the code of its manager, the senior_manager_code is the code of its senior manager, the lead_manager_code is the code of its lead manager, and the company_code is the code of the working company.

## Solutions

```sql
SELECT 
    Employee.company_code, 
    founder, 
    COUNT(DISTINCT lead_manager_code), 
    COUNT(DISTINCT senior_manager_code), 
    COUNT(DISTINCT manager_code), 
    COUNT(DISTINCT employee_code)
FROM Employee
LEFT JOIN Company 
    ON Company.company_code = Employee.company_code
GROUP BY Employee.company_code, founder;
```

## Result set

|      |         |   |   |   |    |
| ---- | ------- | - | - | - | -- |
| C1   | Angela  | 1 | 2 | 5 | 13 |
| C10  | Earl    | 1 | 1 | 2 | 3  |
| C100 | Aaron   | 1 | 2 | 4 | 10 |
| C11  | Robert  | 1 | 1 | 1 | 1  |
| C12  | Amy     | 1 | 2 | 6 | 14 |
| C13  | Pamela  | 1 | 2 | 5 | 14 |
| C14  | Maria   | 1 | 1 | 3 | 5  |
| C15  | Joe     | 1 | 1 | 2 | 3  |
| C16  | Linda   | 1 | 1 | 3 | 5  |
| C17  | Melissa | 1 | 2 | 3 | 7  |