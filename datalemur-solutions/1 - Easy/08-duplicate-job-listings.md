# [Duplicate Job Listings [Linkedin SQL Interview Question]](https://datalemur.com/questions/duplicate-job-listings)

## Table Of Contents
1. [Problem Statement]()
2. [Datasets used]()
3. [Solutions]()
4. [Result set]()

## Problem Statement

Assume you're given a table containing job postings from various companies on the LinkedIn platform. Write a query to retrieve the count of companies that have posted duplicate job listings.

Definition:

- Duplicate job listings are defined as two job listings within the same company that share identical titles and descriptions.

## Datasets used

```job_listings``` Table:

|  Column Name  | Type          |
| ------------- | ------------- |
| job_id | integer |
| company_id | integer |
| title | string |
| description | string |

## Solutions

```sql
SELECT 
    COUNT(*) 
FROM(
    SELECT 
        company_id, 
        title, 
        description, 
        COUNT(job_id) AS job_count
    FROM job_listings
    GROUP BY company_id, title, description
    HAVING COUNT(job_id) > 1
) t1;
```

## Result set

| count |
| ------------ |
| 3 |