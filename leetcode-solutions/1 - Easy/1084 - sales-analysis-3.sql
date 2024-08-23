-- Write a solution to report the products that were only sold in the first quarter of 2019. That is, between 2019-01-01 and 2019-03-31 inclusive.
-- Return the result table in any order.

/* Write your T-SQL query statement below */

SELECT 
p.product_id,
product_name
FROM Product p
INNER JOIN Sales s
    ON p.product_id = s.product_id
GROUP BY p.product_id, product_name
HAVING MIN(sale_date) >= '2019-01-01' AND MAX(sale_date) <= '2019-03-31';