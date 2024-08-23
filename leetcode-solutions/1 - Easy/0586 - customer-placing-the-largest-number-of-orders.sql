-- Write a solution to find the customer_number for the customer who has placed the largest number of orders.
-- The test cases are generated so that exactly one customer will have placed more orders than any other customer.

SELECT TOP 1 customer_number 
FROM Orders
GROUP BY customer_number
ORDER BY COUNT(customer_number) DESC;