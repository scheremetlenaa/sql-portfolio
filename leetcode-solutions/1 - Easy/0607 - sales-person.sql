-- Write a solution to find the names of all the salespersons who did not have any orders related to the company with the name "RED".
-- Return the result table in any order.

SELECT name
FROM SalesPerson
WHERE name NOT IN (
    SELECT sp.name
    FROM SalesPerson sp
    LEFT JOIN Orders o
        ON sp.sales_id = o.sales_id
    LEFT JOIN Company c
        ON o.com_id = c.com_id
    WHERE c.name = 'RED'
);