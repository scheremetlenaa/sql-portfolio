# [Cards Issued Difference [JPMorgan Chase SQL Interview Question]](https://datalemur.com/questions/cards-issued-difference)

## Table Of Contents
1. [Problem Statement](#problem-statement)
2. [Datasets used](#datasets-used)
3. [Solutions](#solutions)
4. [Result set](#result-set)

## Problem Statement

Your team at JPMorgan Chase is preparing to launch a new credit card, and to gain some insights, you're analyzing how many credit cards were issued each month.

Write a query that outputs the name of each credit card and the difference in the number of issued cards between the month with the highest issuance cards and the lowest issuance. Arrange the results based on the largest disparity.

## Datasets used

```monthly_cards_issued``` Table:

|  Column Name  | Type          |
| ------------- | ------------- |
| card_name |	string |
| issued_amount |	integer |
| issue_month |	integer |
| issue_year |	integer |

## Solutions

```sql
SELECT 
    card_name,
    MAX(issued_amount) - MIN(issued_amount) AS difference
FROM monthly_cards_issued
GROUP BY card_name
ORDER BY difference DESC;
```

## Result set

| card_name | difference |
| --------- | ---------- |
| Chase Sapphire Reserve |	30000 |
| Chase Freedom Flex | 15000 |