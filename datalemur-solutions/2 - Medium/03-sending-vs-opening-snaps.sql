-- Write a query to obtain a breakdown of the time spent sending vs. opening snaps as a percentage of total time spent on these activities grouped by age group. 
-- Round the percentage to 2 decimal places in the output.

SELECT
  age_bucket,
  ROUND(100.0 * SUM(send), 2) AS send_perc,
  ROUND(100.0 * SUM(open), 2) AS open_perc 
FROM (
  SELECT
    age_bucket,
    CASE
      WHEN activity_type = 'open' THEN sum_by_activity / total_sum
      ELSE 0
    END AS open,
    CASE
      WHEN activity_type = 'send' THEN sum_by_activity / total_sum
      ELSE 0
    END AS send
  FROM (
    SELECT
      age_bucket,
      activity_type,
      SUM(time_spent) OVER(PARTITION BY age_bucket, activity_type) AS sum_by_activity,
      SUM(time_spent) OVER(PARTITION BY age_bucket) AS total_sum
    FROM activities
    INNER JOIN age_breakdown
      ON activities.user_id = age_breakdown.user_id
      AND activity_type IN ('send', 'open')
  ) t1
  GROUP BY age_bucket, CASE
      WHEN activity_type = 'open' THEN sum_by_activity / total_sum
      ELSE 0
    END,
    CASE
      WHEN activity_type = 'send' THEN sum_by_activity / total_sum
      ELSE 0
    END
) t2
GROUP BY age_bucket;