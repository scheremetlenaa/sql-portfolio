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

### 7. Which item was purchased just before the customer became a member?

```sql
WITH CTE AS (
  SELECT
      s.customer_id,
      s.order_date,
      mn.product_name,
      DENSE_RANK() OVER(PARTITION BY s.customer_id ORDER BY s.order_date DESC) AS dns_rnk
  FROM dannys_diner.sales s
  INNER JOIN dannys_diner.members mmb
      ON s.customer_id = mmb.customer_id
      AND order_date < join_date
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
| A           | sushi        |
| A           | curry        |
| B           | sushi        |

---

### 8. What is the total items and amount spent for each member before they became a member?

```sql
SELECT
    s.customer_id,
    COUNT(product_name) AS item_count,
    SUM(price) AS amount_spent
FROM dannys_diner.sales s
INNER JOIN dannys_diner.members mmb
    ON s.customer_id = mmb.customer_id
    AND order_date < join_date
INNER JOIN dannys_diner.menu mn
    ON s.product_id = mn.product_id
GROUP BY s.customer_id
ORDER BY customer_id;
```
#### Result set

| customer_id | item_count | amount_spent |
| ----------- | ---------- | ------------ |
| A           | 2          | 25           |
| B           | 3          | 40           |

---

### 9. If each $1 spent equates to 10 points and sushi has a 2x points multiplier - how many points would each customer have?

```sql
SELECT
    customer_id,
    SUM(CASE
    		WHEN product_name = 'sushi' THEN price*20
        	ELSE price*10
    	END) AS points
FROM dannys_diner.sales s
INNER JOIN dannys_diner.menu mn
	ON s.product_id = mn.product_id
GROUP BY customer_id
ORDER BY customer_id;
```
#### Result set

| customer_id | points |
| ----------- | ------ |
| A           | 860    |
| B           | 940    |
| C           | 360    |

---

### 10. In the first week after a customer joins the program (including their join date) they earn 2x points on all items, not just sushi - how many points do customer A and B have at the end of January?

```sql
WITH CTE AS (
  SELECT
      customer_id,
      join_date,
      join_date + INTERVAL '6' DAY AS program_last_date
  FROM dannys_diner.members mmb
)

SELECT
    s.customer_id,
    SUM(CASE
       	WHEN order_date BETWEEN join_date AND program_last_date THEN price*20
        WHEN order_date < join_date OR order_date > program_last_date THEN
        CASE
            WHEN product_name = 'sushi' THEN price*20
            ELSE price*10
        END
    END) AS points
FROM dannys_diner.sales s
INNER JOIN dannys_diner.menu mn
	ON s.product_id = mn.product_id
INNER JOIN CTE
	ON s.customer_id = CTE.customer_id
WHERE order_date < '2021-02-01'
GROUP BY s.customer_id;
```
#### Result set

| customer_id | points |
| ----------- | ------ |
| A           | 1370   |
| B           | 820    |

---

### Bonus questions

1. Join all the things

The following questions are related creating basic data tables that Danny and his team can use to quickly derive insights without needing to join the underlying tables using SQL.

```sql
SELECT
    s.customer_id,
    TO_CHAR(s.order_date, 'YYYY-MM-DD') AS order_date,
    mn.product_name,
    mn.price,
    CASE
        WHEN s.order_date >= mmb.join_date THEN 'Y'
        ELSE 'N'
    END AS member
FROM dannys_diner.sales s
INNER JOIN dannys_diner.menu mn
	ON s.product_id = mn.product_id
LEFT JOIN dannys_diner.members mmb
	ON s.customer_id = mmb.customer_id
ORDER BY customer_id, order_date;
```
#### Result set

| customer_id | order_date    | product_name | price | member |
| ----------- | ---------- | ------------ | ----- | ------ |
| A           | 2021-01-01 | sushi        | 10    | N      |
| A           | 2021-01-01 | curry        | 15    | N      |
| A           | 2021-01-07 | curry        | 15    | Y      |
| A           | 2021-01-10 | ramen        | 12    | Y      |
| A           | 2021-01-11 | ramen        | 12    | Y      |
| A           | 2021-01-11 | ramen        | 12    | Y      |
| B           | 2021-01-01 | curry        | 15    | N      |
| B           | 2021-01-02 | curry        | 15    | N      |
| B           | 2021-01-04 | sushi        | 10    | N      |
| B           | 2021-01-11 | sushi        | 10    | Y      |
| B           | 2021-01-16 | ramen        | 12    | Y      |
| B           | 2021-02-01 | ramen        | 12    | Y      |
| C           | 2021-01-01 | ramen        | 12    | N      |
| C           | 2021-01-01 | ramen        | 12    | N      |
| C           | 2021-01-07 | ramen        | 12    | N      |

---

2. Rank All The Things

Danny also requires further information about the ```ranking``` of customer products, but he purposely does not need the ranking for non-member purchases so he expects null ```ranking``` values for the records when customers are not yet part of the loyalty program.

```sql
WITH CTE AS (
  SELECT
      s.customer_id,
      TO_CHAR(s.order_date, 'YYYY-MM-DD') AS order_date,
      mn.product_name,
      mn.price,
      CASE
          WHEN s.order_date >= mmb.join_date THEN 'Y'
          ELSE 'N'
      END AS member
  FROM dannys_diner.sales s
  INNER JOIN dannys_diner.menu mn
      ON s.product_id = mn.product_id
  LEFT JOIN dannys_diner.members mmb
      ON s.customer_id = mmb.customer_id
  ORDER BY customer_id, order_date
)

SELECT
    *,
    CASE
    	WHEN member = 'N' THEN NULL
        ELSE DENSE_RANK() OVER(PARTITION BY customer_id, member ORDER BY order_date)
    END AS ranking
FROM CTE;
```
#### Result set

| customer_id | order_date | product_name | price | member | ranking |
| ----------- | ---------- | ------------ | ----- | ------ | ------- |
| A           | 2021-01-01 | sushi        | 10    | N      | NULL    |
| A           | 2021-01-01 | curry        | 15    | N      | NULL    |
| A           | 2021-01-07 | curry        | 15    | Y      | 1       |
| A           | 2021-01-10 | ramen        | 12    | Y      | 2       |
| A           | 2021-01-11 | ramen        | 12    | Y      | 3       |
| A           | 2021-01-11 | ramen        | 12    | Y      | 3       |
| B           | 2021-01-01 | curry        | 15    | N      | NULL    |
| B           | 2021-01-02 | curry        | 15    | N      | NULL    |
| B           | 2021-01-04 | sushi        | 10    | N      | NULL    |
| B           | 2021-01-11 | sushi        | 10    | Y      | 1       |
| B           | 2021-01-16 | ramen        | 12    | Y      | 2       |
| B           | 2021-02-01 | ramen        | 12    | Y      | 3       |
| C           | 2021-01-01 | ramen        | 12    | N      | NULL    |
| C           | 2021-01-01 | ramen        | 12    | N      | NULL    |
| C           | 2021-01-07 | ramen        | 12    | N      | NULL    |
---
