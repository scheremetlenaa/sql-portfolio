--retrieve the top three cities that have the highest number of completed trade orders listed in descending order.
--Output the city name and the corresponding number of completed trade orders.

SELECT
  city,
  COUNT(*) AS total_orders
FROM trades
INNER JOIN users ON trades.user_id = users.user_id
WHERE status = 'Completed'
GROUP BY city
ORDER BY COUNT(*) DESC
LIMIT 3;