## Case Study Questions

1. How many unique transactions were there?
2. What is the average unique products purchased in each transaction?
3. What are the 25th, 50th and 75th percentile values for the revenue per transaction?
4. What is the average discount value per transaction?
5. What is the percentage split of all transactions for members vs non-members?
6. What is the average revenue for member transactions and non-member transactions?

---

## Solutions

---

### 1. How many unique transactions were there?

```sql
SELECT
	COUNT(DISTINCT txn_id) AS txn_amount
FROM balanced_tree.sales s;
```

#### Result set

| txn_amount |
| ---------- |
| 2500       |

---

### 2. What is the average unique products purchased in each transaction?

```sql
WITH CTE AS (
  SELECT
      txn_id,
      SUM(qty) AS total_quantity
  FROM balanced_tree.sales s
  GROUP BY 1
)

SELECT
	ROUND(AVG(total_quantity)) AS avg_unique_prod
FROM CTE;
```

#### Result set

| avg_unique_prod |
| --------------- |
| 18              |

---

### 3. What are the 25th, 50th and 75th percentile values for the revenue per transaction?

```sql
WITH CTE AS (
  SELECT
      txn_id,
      SUM(qty * price) AS total_revenue
  FROM balanced_tree.sales s
  GROUP BY 1
)

SELECT
	  PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY total_revenue) AS t_25th_percentile,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY total_revenue) AS t_50th_percentile,
    PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY total_revenue) AS t_75th_percentile
FROM CTE;
```

#### Result set

| t_25th_percentile | t_50th_percentile | t_75th_percentile |
| ----------------- | ----------------- | ----------------- |
| 375.75            | 509.5             | 647               |

---

### 4. What is the average discount value per transaction?

```sql
WITH CTE AS (
  SELECT
      txn_id,
      SUM(qty * price * discount / 100) AS total_disc
  FROM balanced_tree.sales s
  GROUP BY 1
)

SELECT
	ROUND(AVG(total_disc), 2) AS avg_disc
FROM CTE;
```

#### Result set

| avg_disc |
| -------- |
| 59.79    |

---

### 5. What is the percentage split of all transactions for members vs non-members?

```sql
SELECT
	  member,
    ROUND(COUNT(txn_id) * 100.0 / (SELECT COUNT(txn_id) FROM balanced_tree.sales), 2) AS txn_cnt
FROM balanced_tree.sales
GROUP BY 1;
```

#### Result set

| member | txn_cnt |
| ------ | ------- |
| false  | 39.97   |
| true   | 60.03   |

---

### 6. What is the average revenue for member transactions and non-member transactions?

```sql
WITH CTE AS (
  SELECT
      member,
      txn_id,
      SUM(qty * price) AS total_revenue
  FROM balanced_tree.sales
  GROUP BY 1, 2
)

SELECT
	  member,
    ROUND(AVG(total_revenue), 2) AS avg_total_revenue
FROM CTE
GROUP BY 1;
```

#### Result set

| member | avg_total_revenue |
| ------ | ----------------- |
| false  | 515.04            |
| true   | 516.27            |

---
