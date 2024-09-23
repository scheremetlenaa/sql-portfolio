# [52 - Loan Repayment](https://www.namastesql.com/coding-problem/52-loan-repayment)

## Table Of Contents
1. [Problem Statement]()
2. [Datasets used]()
3. [Solutions]()
4. [Result set]()

## Problem Statement

You're working for a large financial institution that provides various types of loans to customers. Your task is to analyze loan repayment data to assess credit risk and improve risk management strategies.

Write an SQL to create 2 flags for each loan as per below rules. Display loan id, loan amount , due date and the 2 flags.

1- fully_paid_flag: 1 if the loan was fully repaid irrespective of payment date else it should be 0.
2- on_time_flag : 1 if the loan was fully repaid on or before due date else 0.

## Datasets used

```loans``` Table:

| COLUMN_NAME | DATA_TYPE |
| ----------- | --------- |
| loan_id     | int       |
| customer_id | int       |
| loan_amount | int       |
| due_date    | date      |

```payments``` Table:

| COLUMN_NAME  | DATA_TYPE |
| ------------ | --------- |
| amount_paid  | int       |
| loan_id      | int       |
| payment_date | date      |
| payment_id   | int       |

## Solutions

```sql
SELECT
	l.loan_id,
    l.loan_amount,
    l.due_date,
    CASE
    	WHEN SUM(p.amount_paid) = l.loan_amount THEN 1
        ELSE 0
    END AS fully_paid_flag,
    CASE
    	WHEN SUM(p.amount_paid) = l.loan_amount THEN
        CASE
			WHEN MAX(payment_date) <= due_date THEN 1
            ELSE 0
        END
       	ELSE 0
    END AS on_time_flag 
FROM loans l
INNER JOIN payments p
	ON l.loan_id = p.loan_id
GROUP BY l.loan_id;
```

## Result set

| loan_id | loan_amount | due_date   | fully_paid_flag | on_time_flag |
| ------- | ----------- | ---------- | --------------- | ------------ | 
|       1 |        5000 | 2023-01-15 |               0 |            0 |
|       2 |        8000 | 2023-02-20 |               1 |            1 |
|       3 |       10000 | 2023-03-10 |               0 |            0 |
|       4 |        6000 | 2023-04-05 |               1 |            1 |
|       5 |        7000 | 2023-05-01 |               1 |            0 |