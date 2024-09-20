# [585. Investments in 2016](https://leetcode.com/problems/investments-in-2016/description/)

## Table Of Contents
1. [Problem Statement]()
2. [Datasets used]()
3. [Solutions]()
4. [Result set]()

## Problem Statement

Write a solution to report the sum of all total investment values in 2016 tiv_2016, for all policyholders who:

- have the same tiv_2015 value as one or more other policyholders, and
- are not located in the same city as any other policyholder (i.e., the (lat, lon) attribute pairs must be unique).

Round tiv_2016 to two decimal places.

## Datasets used

```Insurance``` Table:

| Column Name | Type  |
| ----------- | ----- |
| pid         | int   |
| tiv_2015    | float |
| tiv_2016    | float |
| lat         | float |
| lon         | float |

pid is the primary key (column with unique values) for this table.
Each row of this table contains information about one policy where:
pid is the policyholder's policy ID.
tiv_2015 is the total investment value in 2015 and tiv_2016 is the total investment value in 2016.
lat is the latitude of the policy holder's city. It's guaranteed that lat is not NULL.
lon is the longitude of the policy holder's city. It's guaranteed that lon is not NULL.

## Solutions

```sql
WITH CTE AS (
    SELECT
        pid,
        tiv_2015,
        tiv_2016,
        COUNT(pid) OVER (PARTITION BY tiv_2015) AS cnt_2015,
        COUNT(pid) OVER (PARTITION BY lat, lon) AS cnt_loc
    FROM Insurance
)

SELECT
    ROUND(SUM(tiv_2016), 2) AS tiv_2016 
FROM CTE
WHERE cnt_2015 > 1  
AND cnt_loc < 2;
```

## Result set

| tiv_2016 |
| -------- |
| 45       |