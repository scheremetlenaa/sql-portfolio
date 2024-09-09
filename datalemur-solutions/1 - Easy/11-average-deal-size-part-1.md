# [Average Deal Size (Part 1) [Salesforce SQL Interview Question]](https://datalemur.com/questions/sql-average-deal-size)

## Table Of Contents
1. [Problem Statement]()
2. [Datasets used]()
3. [Solutions]()
4. [Result set]()

## Problem Statement

Assume that Salesforce customers pay on a per user basis (also referred to as per seat model). Given a table of contracts data, write a query to calculate the average annual revenue per Salesforce customer. Round your answer to 2 decimal places.

Assume each customer only has 1 contract and the yearly seat cost refers to cost per seat.

## Datasets used

```contracts``` Table:

|  Column Name  | Type          |
| ------------- | ------------- |
| customer_id |	integer |
| num_seats |	integer |
| yearly_seat_cost |	integer |


## Solutions

```sql
SELECT
    ROUND(AVG(num_seats * yearly_seat_cost),2) AS average_deal_size
FROM contracts;
```

## Result set

| average_deal_size |
| ------------ |
| 54872.73 |