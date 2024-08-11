-- Write a query that outputs each employee id and whether they hit the quota or not ('yes' or 'no'). 
-- Order the results by employee id in ascending order.

SELECT
  deals.employee_id,
  CASE
    WHEN SUM(deal_size) >= quota THEN 'yes'
    ELSE 'no'
  END AS made_quota
FROM deals
INNER JOIN sales_quotas
  ON deals.employee_id = sales_quotas.employee_id
GROUP BY deals.employee_id, quota
ORDER BY deals.employee_id;