# [Pharmacy Analytics (Part 2) [CVS Health SQL Interview Question]](https://datalemur.com/questions/non-profitable-drugs)

## Table Of Contents
1. [Problem Statement]()
2. [Datasets used]()
3. [Solutions]()
4. [Result set]()

## Problem Statement

CVS Health is analyzing its pharmacy sales data, and how well different products are selling in the market. Each drug is exclusively manufactured by a single manufacturer.

Write a query to identify the manufacturers associated with the drugs that resulted in losses for CVS Health and calculate the total amount of losses incurred.

Output the manufacturer's name, the number of drugs associated with losses, and the total losses in absolute value. Display the results sorted in descending order with the highest losses displayed at the top.

## Datasets used

```pharmacy_sales``` Table:

|  Column Name  | Type          |
| ------------- | ------------- |
| product_id |	integer |
| units_sold |	integer |
| total_sales |	decimal |
| cogs |	decimal |
| manufacturer |	varchar |
| drug |	varchar |

## Solutions

```sql
SELECT
    manufacturer,
    COUNT(*) AS drug_count,
    ABS(SUM(total_loss)) AS total_loss
FROM (
    SELECT
        manufacturer,
        total_sales - cogs AS total_loss
    FROM pharmacy_sales
    WHERE total_sales - cogs < 0
) t1
GROUP BY manufacturer
ORDER BY total_loss DESC;
```

## Result set

| manufacturer | drug_count | total_loss |
| ------------ | ---------- | ---------- |
| Johnson & Johnson |	6 |	894913.13 |
| Eli Lilly | 	4	| 447352.90 | 
| Biogen | 	3	| 417018.89 | 
| AbbVie | 	2	| 413991.10 | 
| Roche	| 2	| 159741.62 | 
| Bayer	| 1	| 28785.28 | 