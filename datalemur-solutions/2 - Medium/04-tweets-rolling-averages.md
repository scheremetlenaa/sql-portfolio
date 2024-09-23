# [Tweets' Rolling Averages [Twitter SQL Interview Question]](https://datalemur.com/questions/rolling-average-tweets)

## Table Of Contents
1. [Problem Statement](#problem-statement)
2. [Datasets used](#datasets-used)
3. [Solutions](#solutions)
4. [Result set](#result-set)

## Problem Statement

Given a table of tweet data over a specified time period, calculate the 3-day rolling average of tweets for each user. Output the user ID, tweet date, and rolling averages rounded to 2 decimal places.

Notes:

- A rolling average, also known as a moving average or running mean is a time-series technique that examines trends in data over a specified period of time.
- In this case, we want to determine how the tweet count for each user changes over a 3-day period.

## Datasets used

```tweets``` Table:

|  Column Name  | Type          |
| ------------- | ------------- |
| user_id | integer |
| tweet_date |	timestamp |
| tweet_count |	integer |

## Solutions

```sql
SELECT
    user_id,
    tweet_date,
    ROUND(AVG(tweet_count) OVER(PARTITION BY user_id ORDER BY tweet_date ROWS BETWEEN 2 PRECEDING AND CURRENT ROW), 2) AS rolling_avg_3d
FROM tweets;
```

## Result set

| user_id | tweet_date | rolling_avg_3d |
| ------- | ---------- | -------------- |
| 111	  | 06/01/2022 | 00:00:00 2.00  |
| 111     | 06/02/2022 | 00:00:00 1.50  |
| 111     | 06/03/2022 | 00:00:00 2.00  |
| 111     | 06/04/2022 | 00:00:00 2.67  |
| 111     | 06/05/2022 | 00:00:00 4.00  |
| 111     | 06/06/2022 | 00:00:00 4.33  |
| 111     | 06/07/2022 | 00:00:00 5.00  |
| 199     | 06/01/2022 | 00:00:00 7.00  |
| 199     | 06/02/2022 | 00:00:00 6.00  |
| 199     | 06/03/2022 | 00:00:00 7.00  |
| 199     | 06/04/2022 | 00:00:00 5.00  |
| 199     | 06/05/2022 | 00:00:00 6.00  |
| 199     | 06/06/2022 | 00:00:00 3.67  |
| 199     | 06/07/2022 | 00:00:00 4.00  |
| 254     | 06/01/2022 | 00:00:00 1.00  |
| 254     | 06/02/2022 | 00:00:00 1.00  |
| 254     | 06/03/2022 | 00:00:00 1.33  |
| 254     | 06/04/2022 | 00:00:00 1.33  |
| 254     | 06/05/2022 | 00:00:00 2.00  |
| 254     | 06/06/2022 | 00:00:00 1.67  |
| 254     | 06/07/2022 | 00:00:00 2.33  |