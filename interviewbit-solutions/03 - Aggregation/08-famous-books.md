# [Famous Books](https://www.interviewbit.com/problems/famous-books/)

## Table Of Contents
1. [Problem Statement]()
2. [Datasets used]()
3. [Solutions]()
4. [Result set]()

## Problem Statement

You are given 2 tables, One containing the available Books and the other containing the Books that have been bought by a customer. You have to find the Id’s of all the ‘Famous’ Books. A book is called ‘Famous’ if it is bought by at least 3 customers.

## Datasets used

```Books``` Table:

| Field | Type    |
| ----- | ------- |
| Id    | INT     |
| Name  | Varchar |

```BoughtBooks``` Table:

| Field   | Type |
| ------- | ---- |
| Id      | INT  |
| BooksId | INT  |

## Solutions

```sql
SELECT
    BooksId AS Id
FROM (
    SELECT
        Id,
        BooksId
    FROM BoughtBooks
    GROUP BY Id, BooksId
) t1
GROUP BY BooksId
HAVING COUNT(*) >= 3;
```

## Result set

| **Id** |
| ------ |
| 101    |
| 122    |
| 127    |
| 135    |
| 136    |