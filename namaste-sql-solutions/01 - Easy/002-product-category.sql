/* You are provided with a table named Products containing information about various products, including their names and prices. 

Write a SQL query to count number of products in each category based on its price into three categories below. 

Display the output in descending order of no of products. */

WITH Categories AS (
  SELECT
      product_name,
      CASE
          WHEN price < 100 THEN 'Low Price'
          WHEN price BETWEEN 100 AND 500 THEN 'Medium Price'
          WHEN price > 500 THEN 'High Price'
      END AS price_category
  FROM products
)

SELECT
	price_category,
    COUNT(*) AS cnt
FROM Categories
GROUP BY price_category
ORDER BY cnt DESC;