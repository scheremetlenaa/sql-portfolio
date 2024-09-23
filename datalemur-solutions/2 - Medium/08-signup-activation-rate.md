# [Signup Activation Rate [TikTok SQL Interview Question]](https://datalemur.com/questions/signup-confirmation-rate)

## Table Of Contents
1. [Problem Statement](#problem-statement)
2. [Datasets used](#datasets-used)
3. [Solutions](#solutions)
4. [Result set](#result-set)

## Problem Statement

New TikTok users sign up with their emails. They confirmed their signup by replying to the text confirmation to activate their accounts. Users may receive multiple text messages for account confirmation until they have confirmed their new account.

A senior analyst is interested to know the activation rate of specified users in the ```emails``` table. Write a query to find the activation rate. Round the percentage to 2 decimal places.

Definitions:

- ```emails``` table contain the information of user signup details.
- ```texts``` table contains the users' activation information.

Assumptions:

- The analyst is interested in the activation rate of specific users in the ```emails``` table, which may not include all users that could potentially be found in the ```texts``` table.
- For example, user 123 in the ```emails``` table may not be in the ```texts``` table and vice versa.

## Datasets used

```emails``` Table:

|  Column Name  | Type          |
| ------------- | ------------- |
| email_id | integer |
| user_id |	integer |
| signup_date |	datetime |

```texts``` Table:

| Column Name | Type |
| ----------- | ---- |
| text_id |	integer |
| email_id |	integer |
| signup_action |	varchar |

## Solutions

```sql
SELECT
    ROUND(COUNT(texts.email_id)::DECIMAL 
        / COUNT(DISTINCT emails.email_id), 2) AS activation_rate
FROM emails
LEFT JOIN texts
    ON emails.email_id = texts.email_id
    AND texts.signup_action = 'Confirmed';
```

## Result set

| activation_rate |
| ------------ |
| 0.33 |