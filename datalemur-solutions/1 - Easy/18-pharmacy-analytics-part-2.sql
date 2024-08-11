-- identify the manufacturers associated with the drugs that resulted in losses for CVS Health and calculate the total amount of losses incurred

SELECT
  manufacturer,
  COUNT(*) AS drug_count,
  ABS(SUM(total_loss)) AS total_loss
FROM (
  SELECT
    manufacturer,
    total_sales - cogs AS total_loss
  FROM pharmacy_sales
  WHERE total_sales - cogs < 0
) t1
GROUP BY manufacturer
ORDER BY total_loss DESC;