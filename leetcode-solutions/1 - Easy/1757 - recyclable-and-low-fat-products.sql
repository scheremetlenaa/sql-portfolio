/* Write a solution to find the ids of products that are both low fat and recyclable.

Return the result table in any order. */

/* Write your T-SQL query statement below */

SELECT
    product_id
FROM Products
WHERE low_fats = 'Y'
AND recyclable = 'Y';