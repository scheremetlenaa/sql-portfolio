# [1693. Daily Leads and Partners](https://leetcode.com/problems/daily-leads-and-partners/description/)

## Table Of Contents
1. [Problem Statement]()
2. [Datasets used]()
3. [Solutions]()
4. [Result set]()

## Problem Statement

For each date_id and make_name, find the number of distinct lead_id's and distinct partner_id's.

Return the result table in any order.

## Datasets used

```DailySales``` Table:

| Column Name | Type    |
| ----------- | ------- |
| date_id     | date    |
| make_name   | varchar |
| lead_id     | int     |
| partner_id  | int     |

There is no primary key (column with unique values) for this table. It may contain duplicates.
This table contains the date and the name of the product sold and the IDs of the lead and partner it was sold to.
The name consists of only lowercase English letters.

## Solutions

```sql
SELECT
    date_id,
    make_name,
    COUNT(DISTINCT lead_id) AS unique_leads,
    COUNT(DISTINCT partner_id) AS unique_partners
FROM DailySales
GROUP BY date_id, make_name;
```

## Result set

| date_id    | make_name | unique_leads | unique_partners |
| ---------- | --------- | ------------ | --------------- |
| 2020-12-07 | honda     | 3            | 2               |
| 2020-12-07 | toyota    | 1            | 2               |
| 2020-12-08 | honda     | 2            | 2               |
| 2020-12-08 | toyota    | 2            | 3               |