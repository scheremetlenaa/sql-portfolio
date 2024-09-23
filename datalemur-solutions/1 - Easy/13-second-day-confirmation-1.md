# [Second Day Confirmation [TikTok SQL Interview Question]](https://datalemur.com/questions/second-day-confirmation)

## Table Of Contents
1. [Problem Statement](#problem-statement)
2. [Datasets used](#datasets-used)
3. [Solutions](#solutions)
4. [Result set](#result-set)

## Problem Statement

Assume you're given tables with information about TikTok user sign-ups and confirmations through email and text. New users on TikTok sign up using their email addresses, and upon sign-up, each user receives a text message confirmation to activate their account.

Write a query to display the user IDs of those who did not confirm their sign-up on the first day, but confirmed on the second day.

Definition:

- ```action_date``` refers to the date when users activated their accounts and confirmed their sign-up through text messages.

## Datasets used

```emails``` Table:

|  Column Name  | Type          |
| ------------- | ------------- |
| email_id |	integer |
| user_id |	integer |
| signup_date |	datetime |

```texts``` Table:

| Column Name | Type |
| ----------- | ---- |
| text_id |	integer |
| email_id |	integer |
| signup_action |	string ('Confirmed', 'Not confirmed') |
| action_date |	datetime |

## Solutions

```sql
SELECT
    user_id
FROM emails
INNER JOIN texts ON emails.email_id = texts.email_id
WHERE EXTRACT(day FROM (action_date - signup_date)) = 1
AND signup_action = 'Confirmed';
```

## Result set

| user_id |
| ------- |
| 1052 |
| 1235 |