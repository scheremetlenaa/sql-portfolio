-- Write a query to calculate the sum of odd-numbered and even-numbered measurements separately for a particular day and display the results in two different columns.

SELECT
  measurement_day,
  SUM(measurement_value) FILTER (WHERE measurement_num % 2 != 0) AS odd_sum,
  SUM(measurement_value) FILTER (WHERE measurement_num % 2 = 0) AS even_sum
FROM (
  SELECT
    CAST(measurement_time AS DATE) AS measurement_day,
    measurement_value,
    ROW_NUMBER() OVER(PARTITION BY CAST(measurement_time AS DATE)
                      ORDER BY measurement_time) AS measurement_num
  FROM measurements
) t1
GROUP BY measurement_day;