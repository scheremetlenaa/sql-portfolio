/* Write a solution to find for each user, the join date and the number of orders they made as a buyer in 2019.

Return the result table in any order. */

/* Write your T-SQL query statement below */

SELECT
    user_id AS buyer_id,
    join_date,
    SUM(CASE WHEN order_id IS NOT NULL THEN 1 ELSE 0 END) AS orders_in_2019 
FROM Users u
LEFT JOIN Orders o
    ON u.user_id = o.buyer_id
    AND YEAR(order_date) = 2019
GROUP BY user_id, join_date
ORDER BY user_id