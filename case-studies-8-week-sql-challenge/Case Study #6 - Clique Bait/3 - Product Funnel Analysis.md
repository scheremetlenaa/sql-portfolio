## Case Study Questions

Using a single SQL query - create a new output table which has the following details:

- How many times was each product viewed?
- How many times was each product added to cart?
- How many times was each product added to a cart but not purchased (abandoned)?
- How many times was each product purchased?

Additionally, create another table which further aggregates the data for the above points but this time for each product category instead of individual products.

Use your 2 new output tables - answer the following questions:

1. Which product had the most views, cart adds and purchases?
2. Which product was most likely to be abandoned?
3. Which product had the highest view to purchase percentage?
4. What is the average conversion rate from view to cart add?
5. What is the average conversion rate from cart add to purchase?

---

## Solutions

---

Using a single SQL query - create a new output table which has the following details:

- How many times was each product viewed?
- How many times was each product added to cart?
- How many times was each product added to a cart but not purchased (abandoned)?
- How many times was each product purchased?

```sql
WITH add_to_cart_cte AS (
  SELECT
      *
  FROM clique_bait.events
  INNER JOIN clique_bait.event_identifier
      USING(event_type)
  INNER JOIN clique_bait.page_hierarchy
      USING(page_id)
  WHERE event_name = 'Add to Cart'
  ORDER BY visit_id, event_time
),

abandoned_cte AS (
  SELECT
      page_name,
      COUNT(*) AS abandon_count
  FROM add_to_cart_cte atcc
  LEFT JOIN clique_bait.events e
      ON atcc.visit_id = e.visit_id
      AND e.event_type = 3
  WHERE e.event_type IS NULL
  GROUP BY 1
),

views_and_adds AS (
  SELECT
      page_name,
      SUM(CASE WHEN event_name = 'Page View' THEN 1 ELSE 0 END) AS views_count,
      SUM(CASE WHEN event_name = 'Add to Cart' THEN 1 ELSE 0 END) AS add_to_cart_count
  FROM clique_bait.events
  INNER JOIN clique_bait.event_identifier
      USING(event_type)
  INNER JOIN clique_bait.page_hierarchy
      USING(page_id)
  WHERE product_id IS NOT NULL
  GROUP BY 1
),

purchased_cte AS (
  SELECT
      page_name,
      COUNT(*) AS purchase_count
  FROM add_to_cart_cte atcc
  LEFT JOIN clique_bait.events e
      ON atcc.visit_id = e.visit_id
      AND e.event_type = 3
  WHERE e.event_type IS NOT NULL
  GROUP BY 1
)

SELECT
	  page_name,
    views_count,
    add_to_cart_count,
    abandon_count,
    purchase_count
FROM views_and_adds
INNER JOIN abandoned_cte
	USING(page_name)
INNER JOIN purchased_cte
	USING(page_name)
ORDER BY 1;
```

#### Result set

| page_name      | views_count | add_to_cart_count | abandon_count | purchase_count |
| -------------- | ----------- | ----------------- | ------------- | -------------- |
| Abalone        | 1525        | 932               | 233           | 699            |
| Black Truffle  | 1469        | 924               | 217           | 707            |
| Crab           | 1564        | 949               | 230           | 719            |
| Kingfish       | 1559        | 920               | 213           | 707            |
| Lobster        | 1547        | 968               | 214           | 754            |
| Oyster         | 1568        | 943               | 217           | 726            |
| Russian Caviar | 1563        | 946               | 249           | 697            |
| Salmon         | 1559        | 938               | 227           | 711            |
| Tuna           | 1515        | 931               | 234           | 697            |

---

