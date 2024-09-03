/* Write a solution to find the prices of all products on 2019-08-16. Assume the price of all products before any change is 10.

Return the result table in any order. */

/* Write your T-SQL query statement below */

WITH price AS (
    SELECT DISTINCT
      product_id,
      FIRST_VALUE (new_price) OVER (PARTITION BY product_id ORDER BY change_date DESC) AS price
    FROM Products
    WHERE change_date <= '2019-08-16'
),

distinct_products AS (
    SELECT
        DISTINCT product_id
    FROM Products
)

SELECT
    dp.product_id,
    ISNULL(price, 10) AS price
FROM distinct_products dp
LEFT JOIN price p
    ON dp.product_id = p.product_id