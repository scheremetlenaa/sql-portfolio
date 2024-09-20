# [8 - Library Borrowing Habits](https://www.namastesql.com/coding-problem/8-library-borrowing-habits)

## Table Of Contents
1. [Problem Statement]()
2. [Datasets used]()
3. [Solutions]()
4. [Result set]()

## Problem Statement

Imagine you're working for a library and you're tasked with generating a report on the borrowing habits of patrons. You have two tables in your database: Books and Borrowers.

Write an SQL to display the name of each borrower along with a comma-separated list of the books they have borrowed in alphabetical order, display the output in ascending order of Borrower Name.

## Datasets used

```Books``` Table:

| COLUMN_NAME | DATA_TYPE   |
| ----------- | ----------- |
| BookID      | int         |
| BookName    | varchar(30) |
| Genre       | varchar(20) |

```Borrowers``` Table:

| COLUMN_NAME  | DATA_TYPE   |
| ------------ | ----------- | 
| BorrowerID   | int         |
| BorrowerName | varchar(10) |
| BookID       | int         |


## Solutions

```sql
SELECT
	BorrowerName,
    GROUP_CONCAT(BookName)
FROM Borrowers brw
INNER JOIN Books bks
	ON brw.BookID = bks.BookID
GROUP BY BorrowerName;
```

## Result set

| BorrowerName | GROUP_CONCAT(BookName)                  |
| ------------ | --------------------------------------- |
| Alice        | The Great Gatsby,Pride and Prejudice    |
| Bob          | To Kill a Mockingbird,Romeo and Juliet  |
| Charlie      | 1984,The Notebook                       |
| David        | The Catcher in the Rye,The Hunger Games |
| Eve          | Pride and Prejudice                     |
| Frank        | Romeo and Juliet,Foundation             |
| Grace        | The Notebook                            |
| Harry        | To Kill a Mockingbird                   |
| Ivy          | 1984                                    |