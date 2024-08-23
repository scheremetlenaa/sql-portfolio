-- Write a solution to report the product_name, year, and price for each sale_id in the Sales table.
-- Return the resulting table in any order.

/* Write your T-SQL query statement below */

SELECT
product_name,
year,
price
FROM Sales s
INNER JOIN Product p
    ON s.product_id = p.product_id;