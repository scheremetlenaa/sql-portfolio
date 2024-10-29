## Case Study Questions

Write a single SQL script that combines all of the previous questions into a scheduled report that the Balanced Tree team can run at the beginning of each month to calculate the previous month’s values.

Imagine that the Chief Financial Officer (which is also Danny) has asked for all of these questions at the end of every month.

He first wants you to generate the data for January only - but then he also wants you to demonstrate that you can easily run the samne analysis for February without many changes (if at all).

Feel free to split up your final outputs into as many tables as you need - but be sure to explicitly reference which table outputs relate to which question for full marks :)

---

## Solution

---

```sql
WITH month_selecting AS (
  SELECT
  DATE_TRUNC('month', CURRENT_DATE - INTERVAL '1 MONTH') AS prev_month
),

-- 1. Top 3 products by total revenue before discount
top_products_by_revenue AS (
SELECT
	pd.product_name,
  SUM(qty) * SUM(s.price) AS total_revenue
FROM balanced_tree.sales s
INNER JOIN balanced_tree.product_details pd
	ON s.prod_id = pd.product_id
WHERE s.start_txn_time >= (SELECT prev_month FROM month_selecting)
AND s.start_txn_time < (SELECT prev_month FROM month_selecting) + INTERVAL '1 MONTH'
GROUP BY 1
ORDER BY 2 DESC
LIMIT 3
),

-- 2. Total quantity, revenue and discount for each segment
segment_metrics AS (
  SELECT
      segment_name,
      SUM(qty) AS total_quantity,
      SUM(qty) * SUM(s.price) AS total_revenue,
      SUM(qty * s.price * discount / 100) AS total_discoount
  FROM balanced_tree.sales s
  INNER JOIN balanced_tree.product_details pd
      ON s.prod_id = pd.product_id
  WHERE s.start_txn_time >= (SELECT prev_month FROM month_selecting)
  AND s.start_txn_time < (SELECT prev_month FROM month_selecting) + INTERVAL '1 MONTH'
  GROUP BY 1
),

-- 3. Top selling product for each segment
top_segment_products_cte AS (
  SELECT
      segment_name,
      product_name,
      SUM(qty) AS total_quantity
  FROM balanced_tree.sales s
  INNER JOIN balanced_tree.product_details pd
      ON s.prod_id = pd.product_id
  WHERE s.start_txn_time >= (SELECT prev_month FROM month_selecting)
  AND s.start_txn_time < (SELECT prev_month FROM month_selecting) + INTERVAL '1 MONTH'
  GROUP BY 1, 2
  ORDER BY 1, 3 DESC
),

top_segment_products_cte2 AS (
  SELECT
      *,
      DENSE_RANK() OVER(PARTITION BY segment_name ORDER BY total_quantity DESC) AS dns_rnk
  FROM top_segment_products_cte
),

top_segment_products AS (
  SELECT
      segment_name,
      product_name,
      total_quantity
  FROM top_segment_products_cte2
  WHERE dns_rnk = 1
),

-- 4. Total quantity, revenue and discount for each category
category_metrics AS (
  SELECT
      category_name,
      SUM(qty) AS total_quantity,
      SUM(qty) * SUM(s.price) AS total_revenue,
      SUM(qty * s.price * discount / 100) AS total_discoount
  FROM balanced_tree.sales s
  INNER JOIN balanced_tree.product_details pd
      ON s.prod_id = pd.product_id
  WHERE s.start_txn_time >= (SELECT prev_month FROM month_selecting)
  AND s.start_txn_time < (SELECT prev_month FROM month_selecting) + INTERVAL '1 MONTH'
  GROUP BY 1
),

-- 5. Top selling product for each category
top_category_products_cte AS (
  SELECT
      category_name,
      product_name,
      SUM(qty) AS total_quantity
  FROM balanced_tree.sales s
  INNER JOIN balanced_tree.product_details pd
      ON s.prod_id = pd.product_id
  WHERE s.start_txn_time >= (SELECT prev_month FROM month_selecting)
  AND s.start_txn_time < (SELECT prev_month FROM month_selecting) + INTERVAL '1 MONTH'
  GROUP BY 1, 2
  ORDER BY 1, 3 DESC
),

top_category_products_cte2 AS (
  SELECT
      *,
      DENSE_RANK() OVER(PARTITION BY category_name ORDER BY total_quantity DESC) AS dns_rnk
  FROM top_category_products_cte
),

top_category_products AS (
  SELECT
      category_name,
      product_name,
      total_quantity
  FROM top_category_products_cte2
  WHERE dns_rnk = 1
),

-- 6. Percentage split of revenue by product for each segment
prod_rev AS (
SELECT
	  segment_name,
    product_name,
    SUM(qty * s.price) AS prod_revenue
FROM balanced_tree.sales s
INNER JOIN balanced_tree.product_details pd
	ON s.prod_id = pd.product_id
GROUP BY 1, 2
),

segment_rev AS (
SELECT
	segment_name,
  SUM(prod_revenue) AS total_revenue
FROM prod_rev
GROUP BY 1
),

segment_product_revenue AS (
  SELECT
      pr.segment_name,
      pr.product_name,
      ROUND(prod_revenue * 100.0 / total_revenue, 2) AS rev_pct
  FROM prod_rev pr
  INNER JOIN segment_rev sr
      USING(segment_name)
  WHERE s.start_txn_time >= (SELECT prev_month FROM month_selecting)
  AND s.start_txn_time < (SELECT prev_month FROM month_selecting) + INTERVAL '1 MONTH'
),

-- 7. Percentage split of revenue by segment for each category
segment_rev2 AS (
SELECT
  	category_name,
	  segment_name,
    SUM(qty * s.price) AS cat_revenue
FROM balanced_tree.sales s
INNER JOIN balanced_tree.product_details pd
	ON s.prod_id = pd.product_id
GROUP BY 1, 2
),

category_rev AS (
SELECT
	  category_name,
    SUM(cat_revenue) AS total_revenue
FROM segment_rev2
GROUP BY 1
),

segment_category_revenue AS (
  SELECT
      sr.category_name,
      sr.segment_name,
      ROUND(cat_revenue * 100.0 / total_revenue, 2) AS rev_pct
  FROM segment_rev2 sr
  INNER JOIN category_rev cr
      USING(category_name)
  WHERE s.start_txn_time >= (SELECT prev_month FROM month_selecting)
  AND s.start_txn_time < (SELECT prev_month FROM month_selecting) + INTERVAL '1 MONTH'
),

-- 8. Percentage split of total revenue by category
total_category_revenue AS (
  SELECT
      category_name,
      ROUND(SUM(qty*s.price) * 100.0 / (SELECT SUM(qty*price) FROM balanced_tree.sales), 2)  AS cat_rev_pct
  FROM balanced_tree.sales s
  INNER JOIN balanced_tree.product_details pd
      ON s.prod_id = pd.product_id
  WHERE s.start_txn_time >= (SELECT prev_month FROM month_selecting)
  AND s.start_txn_time < (SELECT prev_month FROM month_selecting) + INTERVAL '1 MONTH'
  GROUP BY 1
),

-- 9. Total transaction “penetration” for each product
total_transaction_penetration AS (
  SELECT
      product_name,
      ROUND(COUNT(DISTINCT txn_id) * 100.0 / (SELECT COUNT(txn_id) FROM balanced_tree.sales), 2) AS transaction_penetration
  FROM balanced_tree.sales s
  INNER JOIN balanced_tree.product_details pd
      ON s.prod_id = pd.product_id
  WHERE s.start_txn_time >= (SELECT prev_month FROM month_selecting)
  AND s.start_txn_time < (SELECT prev_month FROM month_selecting) + INTERVAL '1 MONTH'
  GROUP BY 1
),

-- 10. Most common combination of at least 1 quantity of any 3 products in a 1 single transaction
product_lists AS (
  SELECT
      txn_id,
      STRING_AGG(product_name, ', ') AS products
  FROM balanced_tree.sales s
  INNER JOIN balanced_tree.product_details pd
      ON s.prod_id = pd.product_id
  WHERE s.start_txn_time >= (SELECT prev_month FROM month_selecting)
  AND s.start_txn_time < (SELECT prev_month FROM month_selecting) + INTERVAL '1 MONTH'
  GROUP BY 1
  HAVING COUNT(DISTINCT product_name) >= 3
),

combinations_cnt AS (
SELECT
	  products,
    COUNT(*) AS combination_cnt
FROM product_lists
GROUP BY 1
ORDER BY 2 DESC
),

product_combinations AS (
  SELECT
      products,
      combination_cnt
  FROM combinations_cnt
  WHERE combination_cnt = (SELECT MAX(combination_cnt) FROM combinations_cnt)
)

SELECT * FROM product_combinations;
```
