# [Card Launch Success [JPMorgan Chase SQL Interview Question]](https://datalemur.com/questions/card-launch-success)

## Table Of Contents
1. [Problem Statement](#problem-statement)
2. [Datasets used](#datasets-used)
3. [Solutions](#solutions)
4. [Result set](#result-set)

## Problem Statement

Your team at JPMorgan Chase is soon launching a new credit card. You are asked to estimate how many cards you'll issue in the first month.

Before you can answer this question, you want to first get some perspective on how well new credit card launches typically do in their first month.

Write a query that outputs the name of the credit card, and how many cards were issued in its launch month. The launch month is the earliest record in the ```monthly_cards_issued``` table for a given card. Order the results starting from the biggest issued amount.

## Datasets used

```monthly_cards_issued``` Table:

|  Column Name  | Type          |
| ------------- | ------------- |
| issue_month |	integer |
| issue_year |	integer |
| card_name |	string |
| issued_amount |	integer |

## Solutions

```sql
SELECT
    card_name,
    issued_amount
FROM (
    SELECT 
        card_name,
        issued_amount,
        MAKE_DATE(issue_year, issue_month, 1) AS issue_date,
        MIN(MAKE_DATE(issue_year, issue_month, 1)) OVER (PARTITION BY card_name) AS launch_date
    FROM monthly_cards_issued
) t1
WHERE issue_date = launch_date
ORDER BY issued_amount DESC;
```

## Result set

| card_name	| issued_amount |
| --------- | ------------- |
| Chase Sapphire Reserve |	150000 |
| Chase Freedom Flex |	55000 |