-- Assume you're given a table containing information on Facebook user actions. 
-- Write a query to obtain number of monthly active users (MAUs) in July 2022, including the month in numerical format "1, 2, 3".

SELECT 
  EXTRACT(MONTH from event_date) AS month,
  COUNT(DISTINCT user_id) AS monthly_active_users
FROM user_actions
WHERE EXTRACT(MONTH from event_date) = 7
AND user_id IN 
(
  SELECT user_id 
  FROM user_actions 
  WHERE EXTRACT(MONTH from event_date) = 6
)
GROUP BY EXTRACT(MONTH from event_date)
ORDER BY month, monthly_active_users;