# [Advertiser Status [Facebook SQL Interview Question]](https://datalemur.com/questions/updated-status)

## Table Of Contents
1. [Problem Statement](#problem-statement)
2. [Datasets used](#datasets-used)
3. [Solutions](#solutions)
4. [Result set](#result-set)

## Problem Statement

You're provided with two tables: the ```advertiser``` table contains information about advertisers and their respective payment status, and the ```daily_pay``` table contains the current payment information for advertisers, and it only includes advertisers who have made payments.

Write a query to update the payment status of Facebook advertisers based on the information in the ```daily_pay``` table. The output should include the user ID and their current payment status, sorted by the user id.

The payment status of advertisers can be classified into the following categories:

- New: Advertisers who are newly registered and have made their first payment.
- Existing: Advertisers who have made payments in the past and have recently made a current payment.
- Churn: Advertisers who have made payments in the past but have not made any recent payment.
- Resurrect: Advertisers who have not made a recent payment but may have made a previous payment and have made a payment again recently.

Before proceeding with the question, it is important to understand the possible transitions in the advertiser's status based on the payment status. The following table provides a summary of these transitions:

| # | Current Status | Updated Status | Payment on Day T |
| - | -------------- | -------------- | ---------------- |
| 1 | NEW            | EXISTING       | Paid             |
| 2 | NEW            | CHURN	      | Not paid         |
| 3 | EXISTING       | EXISTING	      | Paid             |
| 4 | EXISTING       | CHURN          | Not paid         |
| 5 | CHURN          | RESURRECT      | Paid             |
| 6 | CHURN          | CHURN          | Not paid         |
| 7 | RESURRECT      | EXISTING       | Paid             |
| 8 | RESURRECT      | CHURN          | Not paid         |

- "Current Status" column: Represents the advertiser's current status.
- "Payment Status" column: Represents the updated payment status based on the conditions
- "Payment on Day T" column: Indicates whether the advertiser made a payment on a specific day (T) or not.

The transitions between payment statuses in the provided table can be summarized as follows:

- Rows 2, 4, 6, and 8: If an advertiser does not make a payment on day T, regardless of their previous status, their payment status transitions to "CHURN" as the updated status.
- Rows 1, 3, 5, and 7: If an advertiser makes a payment on day T, the status is updated to either "EXISTING" or "RESURRECT" based on their previous status. If the previous status was "CHURN," the updated status is "RESURRECT." For any other previous status, the updated status is "EXISTING."

## Datasets used

```advertiser``` Table:

|  Column Name  | Type          |
| ------------- | ------------- |
| user_id | string |
| status | string |

```daily_pay``` Table:

| Column Name | Type |
| ----------- | ---- |
| user_id |	string |
| paid |	decimal |

## Solutions

```sql
SELECT
    CASE
        WHEN a.user_id IS NULL THEN dp.user_id
        ELSE a.user_id
    END AS user_id,
    CASE
        WHEN paid IS NULL THEN 'CHURN'
        WHEN a.user_id IS NULL THEN 'NEW'
        ELSE
        CASE
            WHEN a.status = 'CHURN' THEN 'RESURRECT'
            ELSE 'EXISTING'
        END
    END AS new_status
FROM advertiser a
FULL OUTER JOIN daily_pay dp
ON a.user_id = dp.user_id
ORDER BY user_id;
```

## Result set

| user_id | new_status |
| ------- | ---------- |
| alibaba | EXISTING   |
| baidu   | CHURN      |
| bing    | CHURN      |
| chase   | CHURN      |
| fitdata | NEW        |
| morgan  | EXISTING   |
| target  | RESURRECT  |
| tesla   | CHURN      |
| yahoo   | EXISTING   |