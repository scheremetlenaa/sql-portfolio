/* Write a solution to select the product id, year, quantity, and price for the first year of every product sold.

Return the resulting table in any order. */

/* Write your T-SQL query statement below */

WITH CTE AS (
    SELECT
        product_id,
        year,
        RANK() OVER (PARTITION BY product_id ORDER BY year ASC) AS rnk,
        quantity,
        price
    FROM Sales
)

SELECT
    product_id,
    year AS first_year,
    quantity,
    price
FROM CTE
WHERE rnk = 1;