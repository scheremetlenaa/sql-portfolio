# [Teams Power Users [Microsoft SQL Interview Question]]()

## Table Of Contents
1. [Problem Statement](#problem-statement)
2. [Datasets used](#datasets-used)
3. [Solutions](#solutions)
4. [Result set](#result-set)

## Problem Statement

Write a query to identify the top 2 Power Users who sent the highest number of messages on Microsoft Teams in August 2022. Display the IDs of these 2 users along with the total number of messages they sent. Output the results in descending order based on the count of the messages.

Assumption:

- No two users have sent the same number of messages in August 2022.

## Datasets used

```messages``` Table:

|  Column Name  | Type          |
| ------------- | ------------- |
| message_id | integer |
| sender_id | integer |
| receiver_id | integer |
| content | varchar |
| sent_date | datetime |

## Solutions

```sql
SELECT 
    sender_id,
    COUNT(*) AS message_count
FROM messages
WHERE EXTRACT(year FROM sent_date) = '2022'
AND EXTRACT(month FROM sent_date) = '8'
GROUP BY sender_id
ORDER BY message_count DESC
LIMIT 2;
```

## Result set

| sender_id | message_count |
| --------- | ------------- |
| 3601 | 4 |
| 2520 | 3 |
