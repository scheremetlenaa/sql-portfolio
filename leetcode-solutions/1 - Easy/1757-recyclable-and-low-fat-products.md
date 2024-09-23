# [1757. Recyclable and Low Fat Products](https://leetcode.com/problems/recyclable-and-low-fat-products/description/)

## Table Of Contents
1. [Problem Statement](#problem-statement)
2. [Datasets used](#datasets-used)
3. [Solutions](#solutions)
4. [Result set](#result-set)

## Problem Statement

Write a solution to find the ids of products that are both low fat and recyclable.

Return the result table in any order.

## Datasets used

```Products``` Table:

| Column Name | Type    |
| ----------- | ------- |
| product_id  | int     |
| low_fats    | enum    |
| recyclable  | enum    |

product_id is the primary key (column with unique values) for this table.
low_fats is an ENUM (category) of type ('Y', 'N') where 'Y' means this product is low fat and 'N' means it is not.
recyclable is an ENUM (category) of types ('Y', 'N') where 'Y' means this product is recyclable and 'N' means it is not.

## Solutions

```sql
SELECT
    product_id
FROM Products
WHERE low_fats = 'Y'
AND recyclable = 'Y';
```

## Result set

| product_id |
| ---------- |
| 1          |
| 3          |