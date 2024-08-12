-- Assume you're given a table containing data on Amazon customers and their spending on products in different category.
-- Write a query to identify the top two highest-grossing products within each category in the year 2022. 
-- The output should include the category, product, and total spend.

SELECT
  category,
  product,
  total_spend
FROM (
  SELECT
    category,
    product,
    SUM(spend) AS total_spend,
    RANK() OVER (PARTITION BY category ORDER BY SUM(spend) DESC) AS ranking
  FROM product_spend
  WHERE EXTRACT(YEAR FROM transaction_date) = 2022
  GROUP BY category, product
) t1
WHERE ranking < 3
ORDER BY category, ranking;