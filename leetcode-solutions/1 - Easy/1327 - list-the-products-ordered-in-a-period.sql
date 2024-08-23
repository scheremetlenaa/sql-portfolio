-- Write a solution to get the names of products that have at least 100 units ordered in February 2020 and their amount.
-- Return the result table in any order.

/* Write your T-SQL query statement below */

SELECT
product_name,
SUM(unit) AS unit
FROM Products p
INNER JOIN Orders o
    ON p.product_id = o.product_id
    AND o.order_date BETWEEN '2020-02-01' AND '2020-02-29'
GROUP BY product_name
HAVING SUM(unit) >= 100;