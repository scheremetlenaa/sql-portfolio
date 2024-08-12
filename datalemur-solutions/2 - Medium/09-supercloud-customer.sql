-- A Microsoft Azure Supercloud customer is defined as a customer who has purchased at least one product from every product category listed in the products table.
-- Write a query that identifies the customer IDs of these Supercloud customers.

SELECT
  customer_id
FROM (
  SELECT
    DISTINCT customer_id,
    product_category
  FROM customer_contracts
  INNER JOIN products
    ON customer_contracts.product_id = products.product_id
  GROUP BY customer_id, product_category
) t1
GROUP BY customer_id
HAVING COUNT(*) = (SELECT COUNT(DISTINCT product_category) FROM products)