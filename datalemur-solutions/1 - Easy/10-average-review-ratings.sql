--retrieve the average star rating for each product, grouped by month

SELECT
  EXTRACT(month FROM submit_date) AS mth,
  product_id AS product,
  ROUND(AVG(stars), 2) AS avg_stars
FROM reviews
GROUP BY product_id, EXTRACT(month FROM submit_date)
ORDER BY EXTRACT(month FROM submit_date), product_id;