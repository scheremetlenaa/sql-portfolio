## Case Study Questions

1. What is the total amount each customer spent at the restaurant?
2. How many days has each customer visited the restaurant?
3. What was the first item from the menu purchased by each customer?
4. What is the most purchased item on the menu and how many times was it purchased by all customers?
5. Which item was the most popular for each customer?
6. Which item was purchased first by the customer after they became a member?
7. Which item was purchased just before the customer became a member?
8. What is the total items and amount spent for each member before they became a member?
9. If each $1 spent equates to 10 points and sushi has a 2x points multiplier - how many points would each customer have?
10. In the first week after a customer joins the program (including their join date) they earn 2x points on all items, not just sushi - how many points do customer A and B have at the end of January?

### Bonus questions

1. Join all the things
2. Rank all the things

---

## Solutions

---

### 1. What is the total amount each customer spent at the restaurant?

```sql
SELECT
  customer_id,
  SUM(price) AS total_amount
FROM dannys_diner.sales s
INNER JOIN dannys_diner.menu m
	ON s.product_id = m.product_id
GROUP BY customer_id
ORDER BY customer_id;
```
#### Result set

| customer_id | total_amount |
| ----------- | ------------ |
| A           | 76           |
| B           | 74           |
| C           | 36           |

---

### 2. How many days has each customer visited the restaurant?

```sql
SELECT
   customer_id,
   COUNT(DISTINCT order_date) AS days_visited_count
FROM dannys_diner.sales
GROUP BY customer_id
ORDER BY customer_id;
```
#### Result set

| customer_id | days_visited_count |
| ----------- | ------------------ |
| A           | 4                  |
| B           | 6                  |
| C           | 2                  |

---

3. What was the first item from the menu purchased by each customer?

```sql
WITH CTE AS (
  SELECT
      *,
      DENSE_RANK() OVER(PARTITION BY customer_id ORDER BY order_date) AS dns_rnk
  FROM dannys_diner.sales
)

SELECT
    customer_id,
    product_name
FROM CTE
INNER JOIN dannys_diner.menu m
	ON CTE.product_id = m.product_id
WHERE dns_rnk = 1
GROUP BY customer_id, product_name
ORDER BY customer_id;

```
#### Result set

| customer_id | product_name |
| ----------- | ------------ |
| A           | curry        |
| A           | sushi        |
| B           | curry        |
| C           | ramen        |

---

### 4. What is the most purchased item on the menu and how many times was it purchased by all customers?

```sql
SELECT
    product_name,
    COUNT(*) AS purchase_count
FROM dannys_diner.sales s
INNER JOIN dannys_diner.menu m
	ON s.product_id = m.product_id
GROUP BY product_name
ORDER BY purchase_count DESC
LIMIT 1;
```
#### Result set

| product_name | purchase_count |
| ------------ | -------------- |
| ramen        | 8              |

---

### 5. Which item was the most popular for each customer?

```sql
WITH CTE AS (
  SELECT
      customer_id,
      product_name,
      COUNT(*) AS purchase_count
  FROM dannys_diner.sales s
  INNER JOIN dannys_diner.menu m
      ON s.product_id = m.product_id
  GROUP BY customer_id, product_name
  ORDER BY customer_id, purchase_count DESC
),

CTE1 AS (
SELECT
	customer_id,
  	product_name,
  	purchase_count,
  	DENSE_RANK() OVER(PARTITION BY customer_id ORDER BY purchase_count DESC) AS dns_rnk
FROM CTE
)

SELECT
    customer_id,
    product_name,
    purchase_count
FROM CTE1
WHERE dns_rnk = 1;
```
#### Result set

| customer_id | product_name | purchase_count |
| ----------- | ------------ | -------------- |
| A           | ramen        | 3              |
| B           | ramen        | 2              |
| B           | curry        | 2              |
| B           | sushi        | 2              |
| C           | ramen        | 3              |

---

### 6. Which item was purchased first by the customer after they became a member?

```sql
WITH CTE AS (
  SELECT
      s.customer_id,
      s.order_date,
      mn.product_name,
      DENSE_RANK() OVER(PARTITION BY s.customer_id ORDER BY s.order_date) AS dns_rnk
  FROM dannys_diner.sales s
  INNER JOIN dannys_diner.members mmb
      ON s.customer_id = mmb.customer_id
      AND order_date >= join_date
  INNER JOIN dannys_diner.menu mn
      ON s.product_id = mn.product_id
)

SELECT
    customer_id,
    product_name
FROM CTE
WHERE dns_rnk = 1;
```
#### Result set

| customer_id | product_name |
| ----------- | ------------ |
| A           | curry        |
| B           | sushi        |