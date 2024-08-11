-- find the top 3 most profitable drugs sold, and how much profit they made

SELECT
  drug,
  total_sales - cogs AS total_profit
FROM pharmacy_sales
ORDER BY total_profit DESC
LIMIT 3;