-- Write a query to find the maximum number of prime and non-prime batches that can be stored in the 500,000 square feet warehouse based on the following criteria:
-- Prioritize stocking prime batches
-- After accommodating prime items, allocate any remaining space to non-prime batches

WITH summary AS (
  SELECT
    item_type,
    COUNT(*) AS item_count,
    SUM(square_footage) AS sum_square_footage
  FROM inventory
  GROUP BY item_type
),
space_for_prime AS (
  SELECT
    item_type,
    sum_square_footage,
    FLOOR(500000/sum_square_footage) AS prime_batch_count,
    FLOOR(500000/sum_square_footage) * item_count AS prime_count
  FROM summary
  WHERE item_type = 'prime_eligible'
)

SELECT
  item_type,
  CASE
    WHEN item_type = 'prime_eligible' 
      THEN FLOOR(500000/sum_square_footage) * item_count
    WHEN item_type = 'not_prime'
      THEN FLOOR((500000 - (SELECT FLOOR(500000/sum_square_footage) * sum_square_footage FROM space_for_prime)) 
                  / sum_square_footage) * item_count 
  END AS item_count
FROM summary
ORDER BY item_type DESC;