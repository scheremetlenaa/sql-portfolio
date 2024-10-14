## Case Study Questions

Using the available datasets - answer the following questions using a single query for each one:

1. How many users are there?
2. How many cookies does each user have on average?
3. What is the unique number of visits by all users per month?
4. What is the number of events for each event type?
5. What is the percentage of visits which have a purchase event?
6. What is the percentage of visits which view the checkout page but do not have a purchase event?
7. What are the top 3 pages by number of views?
8. What is the number of views and cart adds for each product category?
9. What are the top 3 products by purchases?

---

## Solutions

---

### 1. How many users are there?

```sql
SELECT Count(DISTINCT users) AS users_cnt
FROM   clique_bait.users;
```

#### Result set

| users_cnt |
| --------- |
| 1782      |

---

### 2. How many cookies does each user have on average?

```sql
WITH cte
     AS (SELECT user_id,
                Count(cookie_id) AS cookies_cnt_per_user
         FROM   clique_bait.users
         GROUP  BY 1)
SELECT Round(Avg(cookies_cnt_per_user), 2) AS avg_cookies_cnt
FROM   cte;
```

#### Result set

| avg_cookies_cnt |
| --------------- |
| 3.56            |

---

### 3. What is the unique number of visits by all users per month?

```sql
SELECT
	  EXTRACT(MONTH FROM event_time) AS month,
    COUNT(DISTINCT visit_id) AS visits_cnt
FROM clique_bait.events
GROUP BY 1
ORDER BY 1;
```

#### Result set

| month | visits_cnt |
| ----- | ---------- |
| 1     | 876        |
| 2     | 1488       |
| 3     | 916        |
| 4     | 248        |
| 5     | 36         |

---

### 4. What is the number of events for each event type?

```sql
SELECT 
	  event_name,
    COUNT(*) AS events_cnt
FROM clique_bait.events
INNER JOIN clique_bait.event_identifier USING(event_type)
GROUP BY 1
ORDER BY 2 DESC;
```

#### Result set 

| event_name    | events_cnt |
| ------------- | ---------- |
| Page View     | 20928      |
| Add to Cart   | 8451       |
| Purchase      | 1777       |
| Ad Impression | 876        |
| Ad Click      | 702        |

---

### 5. What is the percentage of visits which have a purchase event?

```sql
SELECT
	ROUND(COUNT(DISTINCT visit_id) * 100.0 / (SELECT COUNT(DISTINCT visit_id) FROM clique_bait.events), 2) AS purchase_events_pct
FROM clique_bait.events
INNER JOIN clique_bait.event_identifier
	USING(event_type)
WHERE event_name = 'Purchase';
```

#### Result set

| purchase_events_pct |
| ------------------- |
| 49.86               |

---

### 6. What is the percentage of visits which view the checkout page but do not have a purchase event?

```sql
WITH CTE AS (
  SELECT
      visit_id,
      MAX(CASE WHEN event_name = 'Page View' AND page_name = 'Checkout' THEN 1 ELSE 0 END) AS checkout,
      MAX(CASE WHEN event_name = 'Purchase' THEN 1 ELSE 0 END) AS purchase
  FROM clique_bait.events
  INNER JOIN clique_bait.event_identifier ei
      USING(event_type)
  INNER JOIN clique_bait.page_hierarchy ph
      USING(page_id)
  GROUP BY 1
)

SELECT
	  ROUND(SUM(CASE WHEN checkout = 1 AND purchase = 0 THEN 1 ELSE 0 END) * 100.0 / SUM(checkout), 2) AS checkout_without_purchase_pct
FROM CTE
```

#### Result set

| checkout_without_purchase_pct |
| ----------------------------- |
| 15.50                         |

---

### 7. What are the top 3 pages by number of views?

```sql
SELECT
	page_name,
    COUNT(*) AS page_views
FROM clique_bait.events e
INNER JOIN clique_bait.event_identifier ei
	USING(event_type)
INNER JOIN clique_bait.page_hierarchy ph
	USING(page_id)
WHERE event_name = 'Page View'
GROUP BY 1
ORDER BY 2 DESC
LIMIT 3;
```

#### Result set

| page_name    | page_views |
| ------------ | ---------- |
| All Products | 3174       |
| Checkout     | 2103       |
| Home Page    | 1782       |

---

### 8. What is the number of views and cart adds for each product category?

```sql
SELECT
	  product_category,
    SUM(CASE
    	WHEN event_name = 'Page View' THEN 1
        ELSE 0
    END) AS category_views,
    SUM(CASE
    	WHEN event_name = 'Add to Cart' THEN 1
        ELSE 0
    END) AS category_cart_adds
FROM clique_bait.events e
INNER JOIN clique_bait.event_identifier ei
	USING(event_type)
INNER JOIN clique_bait.page_hierarchy ph
	USING(page_id)
WHERE (event_name = 'Page View'
OR event_name = 'Add to Cart')
AND product_category IS NOT NULL
GROUP BY 1;
```

| product_category | category_views | category_cart_adds |
| ---------------- | -------------- | ------------------ |
| Luxury           | 3032           | 1870               |
| Shellfish        | 6204           | 3792               |
| Fish             | 4633           | 2789               |

---

### 9. What are the top 3 products by purchases?

```sql
SELECT
	ph.product_id,
    COUNT(*) AS purchase_count
FROM clique_bait.events e
INNER JOIN clique_bait.event_identifier ei
	USING(event_type)
INNER JOIN clique_bait.page_hierarchy ph
	USING(page_id)
WHERE event_name = 'Purchase'
GROUP BY 1;
```

#### Result set

| product_id | purchase_count |
| ---------- | -------------- |
| null       | 1777           |

---
