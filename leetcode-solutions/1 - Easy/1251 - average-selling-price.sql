-- Write a solution to find the average selling price for each product. average_price should be rounded to 2 decimal places.
-- Return the result table in any order.

/* Write your T-SQL query statement below */

SELECT 
p.product_id,
ISNULL(ROUND(SUM(price*1.0*units) / SUM(units), 2), 0) AS average_price 
FROM UnitsSold us
RIGHT JOIN Prices p
    ON us.product_id = p.product_id
    AND purchase_date BETWEEN start_date AND end_date
GROUP BY p.product_id;