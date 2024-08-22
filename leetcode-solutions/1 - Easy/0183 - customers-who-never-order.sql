-- Write a solution to find all customers who never order anything.
-- Return the result table in any order.

SELECT c.name AS Customers
FROM Customers c
LEFT JOIN Orders o
    ON o.customerId = c.id
    WHERE o.id IS NULL