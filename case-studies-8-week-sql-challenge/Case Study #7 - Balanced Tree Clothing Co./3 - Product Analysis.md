## Case Study Questions

1. What are the top 3 products by total revenue before discount?
2. What is the total quantity, revenue and discount for each segment?
3. What is the top selling product for each segment?
4. What is the total quantity, revenue and discount for each category?
5. What is the top selling product for each category?
6. What is the percentage split of revenue by product for each segment?
7. What is the percentage split of revenue by segment for each category?
8. What is the percentage split of total revenue by category?
9. What is the total transaction “penetration” for each product? (hint: penetration = number of transactions where at least 1 quantity of a product was purchased divided by total number of transactions)
10. What is the most common combination of at least 1 quantity of any 3 products in a 1 single transaction?

---

## Solutions

---

### 1. What are the top 3 products by total revenue before discount?

```sql
SELECT
	product_name,
    SUM(qty) * SUM(s.price) AS total_revenue
FROM balanced_tree.sales s
INNER JOIN balanced_tree.product_details pd
	ON s.prod_id = pd.product_id
GROUP BY 1
ORDER BY 2 DESC
LIMIT 3;
```

#### Result set

| product_name                 | total_revenue |
| ---------------------------- | ------------- |
| Blue Polo Shirt - Mens       | 276022044     |
| Grey Fashion Jacket - Womens | 266862600     |
| White Tee Shirt - Mens       | 192736000     |

---

### 2. What is the total quantity, revenue and discount for each segment?

```sql
SELECT
	  segment_name,
    SUM(qty) AS total_quantity,
    SUM(qty) * SUM(s.price) AS total_revenue,
    SUM(qty * s.price * discount / 100) AS total_discoount
FROM balanced_tree.sales s
INNER JOIN balanced_tree.product_details pd
	ON s.prod_id = pd.product_id
GROUP BY 1
ORDER BY 1;
```

#### Result set

| segment_name | total_quantity | total_revenue | total_discoount |
| ------------ | -------------- | ------------- | --------------- |
| Jacket       | 11385          | 1380784185    | 42451           |
| Jeans        | 11349          | 781537536     | 23673           |
| Shirt        | 11265          | 1525461240    | 48082           |
| Socks        | 11217          | 1163528193    | 35280           |

---

### 3. What is the top selling product for each segment?

```sql
WITH CTE AS (
  SELECT
      segment_name,
      product_name,
      SUM(qty) AS total_quantity
  FROM balanced_tree.sales s
  INNER JOIN balanced_tree.product_details pd
      ON s.prod_id = pd.product_id
  GROUP BY 1, 2
  ORDER BY 1, 3 DESC
),

CTE2 AS (
  SELECT
      *,
      DENSE_RANK() OVER(PARTITION BY segment_name ORDER BY total_quantity DESC) AS dns_rnk
  FROM CTE
)

SELECT
	  segment_name,
    product_name,
    total_quantity
FROM CTE2
WHERE dns_rnk = 1
```

#### Result set

| segment_name | product_name                  | total_quantity |
| ------------ | ----------------------------- | -------------- |
| Jacket       | Grey Fashion Jacket - Womens  | 3876           |
| Jeans        | Navy Oversized Jeans - Womens | 3856           |
| Shirt        | Blue Polo Shirt - Mens        | 3819           |
| Socks        | Navy Solid Socks - Mens       | 3792           |

---

### 4. What is the total quantity, revenue and discount for each category?

```sql
SELECT
	  category_name,
    SUM(qty) AS total_quantity,
    SUM(qty) * SUM(s.price) AS total_revenue,
    SUM(qty * s.price * discount / 100) AS total_discoount
FROM balanced_tree.sales s
INNER JOIN balanced_tree.product_details pd
	ON s.prod_id = pd.product_id
GROUP BY 1
ORDER BY 1;
```

#### Result set

| category_name | total_quantity | total_revenue | total_discoount |
| ------------- | -------------- | ------------- | --------------- |
| Mens          | 22482          | 5376457890    | 83362           |
| Womens        | 22734          | 4322756430    | 66124           |

---

### 5. What is the top selling product for each category?

```sql
WITH CTE AS (
  SELECT
      category_name,
      product_name,
      SUM(qty) AS total_quantity
  FROM balanced_tree.sales s
  INNER JOIN balanced_tree.product_details pd
      ON s.prod_id = pd.product_id
  GROUP BY 1, 2
  ORDER BY 1, 3 DESC
),

CTE2 AS (
  SELECT
      *,
      DENSE_RANK() OVER(PARTITION BY category_name ORDER BY total_quantity DESC) AS dns_rnk
  FROM CTE
)

SELECT
	  category_name,
    product_name,
    total_quantity
FROM CTE2
WHERE dns_rnk = 1
```

#### Result set

| category_name | product_name                 | total_quantity |
| ------------- | ---------------------------- | -------------- |
| Mens          | Blue Polo Shirt - Mens       | 3819           |
| Womens        | Grey Fashion Jacket - Womens | 3876           |

---

### 6. What is the percentage split of revenue by product for each segment?

```sql
WITH prod_rev AS (
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
)

SELECT
	  pr.segment_name,
    pr.product_name,
    ROUND(prod_revenue * 100.0 / total_revenue, 2) AS rev_pct
FROM prod_rev pr
INNER JOIN segment_rev sr
	USING(segment_name)
ORDER BY 1, 3 DESC;
```

#### Result set

| segment_name | product_name                     | rev_pct |
| ------------ | -------------------------------- | ------- |
| Jacket       | Grey Fashion Jacket - Womens     | 57.03   |
| Jacket       | Khaki Suit Jacket - Womens       | 23.51   |
| Jacket       | Indigo Rain Jacket - Womens      | 19.45   |
| Jeans        | Black Straight Jeans - Womens    | 58.15   |
| Jeans        | Navy Oversized Jeans - Womens    | 24.06   |
| Jeans        | Cream Relaxed Jeans - Womens     | 17.79   |
| Shirt        | Blue Polo Shirt - Mens           | 53.60   |
| Shirt        | White Tee Shirt - Mens           | 37.43   |
| Shirt        | Teal Button Up Shirt - Mens      | 8.98    |
| Socks        | Navy Solid Socks - Mens          | 44.33   |
| Socks        | Pink Fluro Polkadot Socks - Mens | 35.50   |
| Socks        | White Striped Socks - Mens       | 20.18   |

---

### 7. What is the percentage split of revenue by segment for each category?

```sql
WITH segment_rev AS (
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
FROM segment_rev
GROUP BY 1
)

SELECT
	  sr.category_name,
    sr.segment_name,
    ROUND(cat_revenue * 100.0 / total_revenue, 2) AS rev_pct
FROM segment_rev sr
INNER JOIN category_rev cr
	USING(category_name)
ORDER BY 1, 3 DESC;
```

#### Result set

| category_name | segment_name | rev_pct |
| ------------- | ------------ | ------- |
| Mens          | Shirt        | 56.87   |
| Mens          | Socks        | 43.13   |
| Womens        | Jacket       | 63.79   |
| Womens        | Jeans        | 36.21   |

---

### 8. What is the percentage split of total revenue by category?

```sql
SELECT
	  category_name,
    ROUND(SUM(qty*s.price) * 100.0 / (SELECT SUM(qty*price) FROM balanced_tree.sales), 2)  AS cat_rev_pct
FROM balanced_tree.sales s
INNER JOIN balanced_tree.product_details pd
	ON s.prod_id = pd.product_id
GROUP BY 1;
```

#### Result set

| category_name | cat_rev_pct |
| ------------- | ----------- |
| Mens          | 55.38       |
| Womens        | 44.62       |

---

### 9. What is the total transaction “penetration” for each product?

```SQL
SELECT
	  product_name,
    ROUND(COUNT(DISTINCT txn_id) * 100.0 / (SELECT COUNT(txn_id) FROM balanced_tree.sales), 2) AS transaction_penetration
FROM balanced_tree.sales s
INNER JOIN balanced_tree.product_details pd
	ON s.prod_id = pd.product_id
GROUP BY 1;
```

#### Result set

| product_name                     | transaction_penetration |
| -------------------------------- | ----------------------- |
| Black Straight Jeans - Womens    | 8.25                    |
| Blue Polo Shirt - Mens           | 8.40                    |
| Cream Relaxed Jeans - Womens     | 8.23                    |
| Grey Fashion Jacket - Womens     | 8.45                    |
| Indigo Rain Jacket - Womens      | 8.28                    |
| Khaki Suit Jacket - Womens       | 8.26                    |
| Navy Oversized Jeans - Womens    | 8.44                    |
| Navy Solid Socks - Mens          | 8.49                    |
| Pink Fluro Polkadot Socks - Mens | 8.33                    |
| Teal Button Up Shirt - Mens      | 8.23                    |
| White Striped Socks - Mens       | 8.23                    |
| White Tee Shirt - Mens           | 8.40                    |

---

### 10. What is the most common combination of at least 1 quantity of any 3 products in a 1 single transaction?

```sql
WITH product_lists AS (
  SELECT
      txn_id,
      STRING_AGG(product_name, ', ') AS products
  FROM balanced_tree.sales s
  INNER JOIN balanced_tree.product_details pd
      ON s.prod_id = pd.product_id
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
)

SELECT
	  products,
    combination_cnt
FROM combinations_cnt
WHERE combination_cnt = (SELECT MAX(combination_cnt) FROM combinations_cnt);
```

#### Result set

| products                                                                                                                                                                                        | combination_cnt |
| ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------- |
| Cream Relaxed Jeans - Womens, Navy Solid Socks - Mens, Khaki Suit Jacket - Womens, Navy Oversized Jeans - Womens                                                                                | 2               |
| Blue Polo Shirt - Mens, Indigo Rain Jacket - Womens, Pink Fluro Polkadot Socks - Mens                                                                                                           | 2               |
| Navy Oversized Jeans - Womens, Navy Solid Socks - Mens, Blue Polo Shirt - Mens, Teal Button Up Shirt - Mens                                                                                     | 2               |
| Navy Oversized Jeans - Womens, Black Straight Jeans - Womens, Navy Solid Socks - Mens                                                                                                           | 2               |
| Navy Oversized Jeans - Womens, Grey Fashion Jacket - Womens, White Tee Shirt - Mens, Teal Button Up Shirt - Mens, White Striped Socks - Mens                                                    | 2               |
| Teal Button Up Shirt - Mens, Navy Oversized Jeans - Womens, Black Straight Jeans - Womens                                                                                                       | 2               |
| White Tee Shirt - Mens, Navy Oversized Jeans - Womens, Cream Relaxed Jeans - Womens                                                                                                             | 2               |
| White Striped Socks - Mens, Cream Relaxed Jeans - Womens, Khaki Suit Jacket - Womens, Indigo Rain Jacket - Womens, White Tee Shirt - Mens, Blue Polo Shirt - Mens, Navy Solid Socks - Mens      | 2               |
| White Striped Socks - Mens, Pink Fluro Polkadot Socks - Mens, Navy Oversized Jeans - Womens                                                                                                     | 2               |
| Navy Oversized Jeans - Womens, Navy Solid Socks - Mens, Grey Fashion Jacket - Womens                                                                                                            | 2               |
| Cream Relaxed Jeans - Womens, Pink Fluro Polkadot Socks - Mens, Indigo Rain Jacket - Womens                                                                                                     | 2               |
| Khaki Suit Jacket - Womens, Indigo Rain Jacket - Womens, White Tee Shirt - Mens, White Striped Socks - Mens                                                                                     | 2               |
| Khaki Suit Jacket - Womens, Navy Solid Socks - Mens, Navy Oversized Jeans - Womens                                                                                                              | 2               |
| Teal Button Up Shirt - Mens, Navy Oversized Jeans - Womens, Khaki Suit Jacket - Womens, White Tee Shirt - Mens, Navy Solid Socks - Mens, Pink Fluro Polkadot Socks - Mens                       | 2               |
| Khaki Suit Jacket - Womens, Navy Solid Socks - Mens, Blue Polo Shirt - Mens, Indigo Rain Jacket - Womens                                                                                        | 2               |
| Navy Solid Socks - Mens, Navy Oversized Jeans - Womens, Black Straight Jeans - Womens, Indigo Rain Jacket - Womens, White Tee Shirt - Mens, Teal Button Up Shirt - Mens, Blue Polo Shirt - Mens | 2               |

---
