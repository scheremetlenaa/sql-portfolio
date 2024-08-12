-- Output the user's most recent transaction date, user ID, and the number of products, sorted in chronological order by the transaction date.

SELECT
  transaction_date,
  user_id,
  COUNT(product_id) AS purchase_count
FROM (
  SELECT
    transaction_date,
    user_id,
    product_id,
    RANK() OVER(PARTITION BY user_id
                ORDER BY transaction_date DESC) AS transaction_rank
  FROM user_transactions
      ) t1
WHERE transaction_rank = 1
GROUP BY user_id, transaction_date
ORDER BY transaction_date;