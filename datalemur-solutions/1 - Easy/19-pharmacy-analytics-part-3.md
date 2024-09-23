# [Pharmacy Analytics (Part 3) [CVS Health SQL Interview Question]](https://datalemur.com/questions/total-drugs-sales)

## Table Of Contents
1. [Problem Statement](#problem-statement)
2. [Datasets used](#datasets-used)
3. [Solutions](#solutions)
4. [Result set](#result-set)

## Problem Statement

CVS Health wants to gain a clearer understanding of its pharmacy sales and the performance of various products.

Write a query to calculate the total drug sales for each manufacturer. Round the answer to the nearest million and report your results in descending order of total sales. In case of any duplicates, sort them alphabetically by the manufacturer name.

Since this data will be displayed on a dashboard viewed by business stakeholders, please format your results as follows: "$36 million".

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
    CONCAT('$', ROUND(SUM(total_sales)/1000000), ' million') AS sale
FROM pharmacy_sales
GROUP BY manufacturer
ORDER BY SUM(total_sales) DESC, manufacturer;
```

## Result set

| manufacturer | sale |
| ------------ | ---- | 
| AbbVie |	$114 million |
| Eli Lilly |	$77 million |
| Biogen |	$70 million |
| Johnson & Johnson	| $43 million |
| Bayer |	$34 million |
| AstraZeneca |	$32 million |
| Pfizer |	$28 million |
| Novartis |	$26 million |
| Sanofi |	$25 million |
| Merck |	$25 million |
| Roche |	$16 million |
| GlaxoSmithKline | $4 million |