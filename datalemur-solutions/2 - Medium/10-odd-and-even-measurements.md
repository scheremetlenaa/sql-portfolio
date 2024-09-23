# [Odd and Even Measurements [Google SQL Interview Question]](https://datalemur.com/questions/odd-even-measurements)

## Table Of Contents
1. [Problem Statement](#problem-statement)
2. [Datasets used](#datasets-used)
3. [Solutions](#solutions)
4. [Result set](#result-set)

## Problem Statement

Assume you're given a table with measurement values obtained from a Google sensor over multiple days with measurements taken multiple times within each day.

Write a query to calculate the sum of odd-numbered and even-numbered measurements separately for a particular day and display the results in two different columns. Refer to the Example Output below for the desired format.

Definition:

- Within a day, measurements taken at 1st, 3rd, and 5th times are considered odd-numbered measurements, and measurements taken at 2nd, 4th, and 6th times are considered even-numbered measurements.

## Datasets used

```measurements``` Table:

|  Column Name  | Type          |
| ------------- | ------------- |
| measurement_id | integer |
| measurement_value |	decimal |
| measurement_time |	datetime |

## Solutions

```sql
SELECT
    measurement_day,
    SUM(measurement_value) FILTER (WHERE measurement_num % 2 != 0) AS odd_sum,
    SUM(measurement_value) FILTER (WHERE measurement_num % 2 = 0) AS even_sum
FROM (
    SELECT
        CAST(measurement_time AS DATE) AS measurement_day,
        measurement_value,
        ROW_NUMBER() OVER(PARTITION BY CAST(measurement_time AS DATE) ORDER BY measurement_time) AS measurement_num
    FROM measurements
) t1
GROUP BY measurement_day;
```

## Result set

| measurement_day | odd_sum | even_sum |
| --------------- | ------- | -------- |
| 07/10/2022 00:00:00 | 2355.75 | 1662.74 |
| 07/11/2022 00:00:00 | 2377.12 | 2480.70 |
| 07/12/2022 00:00:00 | 2903.40 | 1244.30 |