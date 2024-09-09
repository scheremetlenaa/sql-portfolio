# [Laptop vs. Mobile Viewership [New York Times SQL Interview Question]](https://datalemur.com/questions/laptop-mobile-viewership)

## Table Of Contents
1. [Problem Statement]()
2. [Datasets used]()
3. [Solutions]()
4. [Result set]()

## Problem Statement

Assume you're given the table on user viewership categorised by device type where the three types are laptop, tablet, and phone.

Write a query that calculates the total viewership for laptops and mobile devices where mobile is defined as the sum of tablet and phone viewership. Output the total viewership for laptops as ```laptop_reviews``` and the total viewership for mobile devices as ```mobile_views```.

## Datasets used

```viewership``` Table:

|  Column Name  | Type          |
| ------------- | ------------- |
| user_id | integer |
| device_type | string ('laptop', 'tablet', 'phone') |
| view_time | timestamp |

## Solutions

```sql
SELECT 
    SUM(CASE
            WHEN device_type = 'laptop' THEN 1 
            ELSE 0 
        END) 
    AS laptop_views, 
    SUM(CASE
            WHEN device_type IN ('tablet', 'phone') THEN 1 
            ELSE 0 
        END) 
    AS mobile_views 
FROM viewership;
```

## Result set

| laptop_views | mobile_views |
| ------------ | ------------ |
| 2 | 3 |