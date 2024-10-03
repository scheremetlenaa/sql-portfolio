## Case Study Questions

1. What is the unique count and total amount for each transaction type?
2. What is the average total historical deposit counts and amounts for all customers?
3. For each month - how many Data Bank customers make more than 1 deposit and either 1 purchase or 1 withdrawal in a single month?
4. What is the closing balance for each customer at the end of the month?
5. What is the percentage of customers who increase their closing balance by more than 5%?

---

## Solutions

---

### 1. What is the unique count and total amount for each transaction type?

```sql
SELECT txn_type,
       Count(*)        AS unique_txn_cnt,
       SUM(txn_amount) AS total_amount
FROM   data_bank.customer_transactions
GROUP  BY txn_type;
```

#### Result set

| txn_type   | unique_txn_cnt | total_amount |
| ---------- | -------------- | ------------ |
| purchase   | 1617           | 806537       |
| deposit    | 2671           | 1359168      |
| withdrawal | 1580           | 793003       |

---

### 2. What is the average total historical deposit counts and amounts for all customers?

```SQL
WITH CTE AS (
  SELECT
      customer_id,
      COUNT(customer_id) AS dep_cnt,
      ROUND(AVG(txn_amount), 2) AS avg_dep_amount
  FROM data_bank.customer_transactions
  WHERE txn_type = 'deposit'
  GROUP BY 1
)

SELECT
	ROUND(AVG(dep_cnt)) AS avg_dep_cnt,
    ROUND(AVG(avg_dep_amount), 2) AS avg_dep_amount
FROM CTE;
```

#### Result

| avg_dep_cnt | avg_dep_amount |
| ----------- | -------------- |
| 5           | 508.61         |

---

### 3. For each month - how many Data Bank customers make more than 1 deposit and either 1 purchase or 1 withdrawal in a single month?

```sql
WITH cte
     AS (SELECT To_char(txn_date, 'MM-YYYY') AS txn_month,
                customer_id,
                SUM(CASE
                      WHEN txn_type = 'deposit' THEN 1
                      ELSE 0
                    END)                     AS dep_cnt,
                SUM(CASE
                      WHEN txn_type = 'purchase' THEN 1
                      ELSE 0
                    END)                     AS purchase_cnt,
                SUM(CASE
                      WHEN txn_type = 'withdrawal' THEN 1
                      ELSE 0
                    END)                     AS withdrawal_cnt
         FROM   data_bank.customer_transactions
         GROUP  BY 1,
                   2
         ORDER  BY 2,
                   1)
SELECT txn_month,
       Count(customer_id) AS customer_cnt
FROM   cte
WHERE  dep_cnt > 1
       AND ( purchase_cnt = 1
              OR withdrawal_cnt = 1 )
GROUP  BY txn_month;
```

#### Result set

| txn_month | customer_cnt |
| --------- | ------------ |
| 01-2020   | 115          |
| 02-2020   | 108          |
| 03-2020   | 113          |
| 04-2020   | 50           |

---

### 4. What is the closing balance for each customer at the end of the month?

```sql
WITH cte
     AS (SELECT To_char(txn_date, 'MM-YYYY') AS txn_month,
                customer_id,
                SUM(CASE
                      WHEN txn_type = 'deposit' THEN txn_amount
                      ELSE -( txn_amount )
                    END)                     AS amount_sum
         FROM   data_bank.customer_transactions
         GROUP  BY 1,
                   2
         ORDER  BY 2,
                   1)
SELECT customer_id,
       txn_month,
       SUM(amount_sum)
         over(
           PARTITION BY customer_id
           ORDER BY txn_month) AS closing_balance
FROM   cte;
```

#### Result set

The result table is truncated.

| customer_id | txn_month | closing_balance |
| ----------- | --------- | --------------- |
| 1           | 01-2020   | 312             |
| 1           | 03-2020   | \-640           |
| 2           | 01-2020   | 549             |
| 2           | 03-2020   | 610             |
| 3           | 01-2020   | 144             |
| 3           | 02-2020   | \-821           |
| 3           | 03-2020   | \-1222          |
| 3           | 04-2020   | \-729           |
| 4           | 01-2020   | 848             |
| 4           | 03-2020   | 655             |
| 5           | 01-2020   | 954             |
| 5           | 03-2020   | \-1923          |

---

### 5. What is the percentage of customers who increase their closing balance by more than 5%?

```sql
WITH cte
     AS (SELECT To_char(txn_date, 'MM-YYYY') AS txn_month,
                customer_id,
                SUM(CASE
                      WHEN txn_type = 'deposit' THEN txn_amount
                      ELSE -( txn_amount )
                    END)                     AS amount_sum
         FROM   data_bank.customer_transactions
         GROUP  BY 1,
                   2
         ORDER  BY 2,
                   1),
     cte2
     AS (SELECT customer_id,
                txn_month,
                SUM(amount_sum)
                  over(
                    PARTITION BY customer_id
                    ORDER BY txn_month) AS closing_balance
         FROM   cte),
     cte3
     AS (SELECT customer_id,
                txn_month,
                closing_balance,
                CASE
                  WHEN Lag(closing_balance)
                         over(
                           PARTITION BY customer_id
                           ORDER BY txn_month) = 0 THEN NULL
                  ELSE Round(( closing_balance - Lag(closing_balance)
                                                   over(
                                                     PARTITION BY customer_id
                                                     ORDER BY txn_month) ) * 100
                             / (
                             Lag
                             (
                                    closing_balance)
                                          over(
                                            PARTITION BY customer_id
                                            ORDER BY txn_month) ), 2)
                END AS balance_increase_pct
         FROM   cte2)
SELECT Round(Count(DISTINCT customer_id) * 100.0 / (SELECT
             Count(DISTINCT customer_id)
                                                    FROM
                    data_bank.customer_transactions), 2) AS customers_pct
FROM   cte3
WHERE  balance_increase_pct > 5;
```

#### Result set

| customers_pct |
| ------------- |
| 75.80         |

---
