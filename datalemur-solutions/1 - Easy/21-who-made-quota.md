# [Who Made Quota? [Oracle SQL Interview Question]](https://datalemur.com/questions/oracle-sales-quota)

## Table Of Contents
1. [Problem Statement]()
2. [Datasets used]()
3. [Solutions]()
4. [Result set]()

## Problem Statement

As a data analyst on the Oracle Sales Operations team, you are given a list of salespeople’s deals, and the annual quota they need to hit.

Write a query that outputs each employee id and whether they hit the quota or not ('yes' or 'no'). Order the results by employee id in ascending order.

Definitions:

- ```deal_size```: Deals acquired by a salesperson in the year. Each salesperson may have more than 1 deal.
- ```quota```: Total annual quota for each salesperson.

## Datasets used

```deals``` Table:

|  Column Name  | Type          |
| ------------- | ------------- |
| employee_id | integer |
| deal_size |	integer |

```sales_quotas``` Table:

| Column Name | Type |
| ----------- | ---- |
| employee_id |	integer |
| quota |	integer |

## Solutions

```sql
SELECT
    deals.employee_id,
    CASE
        WHEN SUM(deal_size) >= quota THEN 'yes'
        ELSE 'no'
    END AS made_quota
FROM deals
INNER JOIN sales_quotas
    ON deals.employee_id = sales_quotas.employee_id
GROUP BY deals.employee_id, quota
ORDER BY deals.employee_id;
```

## Result set

| employee_id | made_quota |
| ----------- | ---------- |
| 1 |	yes |
| 101 |	yes |
| 201 |	yes |
| 301 |	no |
| 405 |	no |