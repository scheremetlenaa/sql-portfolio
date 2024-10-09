## Case Study Questions

To test out a few different hypotheses - the Data Bank team wants to run an experiment where different groups of customers would be allocated data using 3 different options:

- Option 1: data is allocated based off the amount of money at the end of the previous month
- Option 2: data is allocated on the average amount of money kept in the account in the previous 30 days
- Option 3: data is updated real-time

For this multi-part challenge question - you have been requested to generate the following data elements to help the Data Bank team estimate how much data will need to be provisioned for each option:

- running customer balance column that includes the impact each transaction
- customer balance at the end of each month
- minimum, average and maximum values of the running balance for each customer

Using all of the data available - how much data would have been required for each option on a monthly basis?

---

## Solution

---

### 1. Running customer balance column that includes the impact each transaction

```sql
SELECT customer_id,
       txn_date,
       txn_type,
       txn_amount,
       SUM(CASE
             WHEN txn_type = 'deposit' THEN txn_amount
             ELSE -txn_amount
           END)
         over(
           PARTITION BY customer_id
           ORDER BY txn_date) AS running_balance
FROM   data_bank.customer_transactions
```

#### Result set

The result table is truncated.

| customer_id | txn_date                 | txn_type   | txn_amount | running_balance |
| ----------- | ------------------------ | ---------- | ---------- | --------------- |
| 1           | 2020-01-02T00:00:00.000Z | deposit    | 312        | 312             |
| 1           | 2020-03-05T00:00:00.000Z | purchase   | 612        | \-300           |
| 1           | 2020-03-17T00:00:00.000Z | deposit    | 324        | 24              |
| 1           | 2020-03-19T00:00:00.000Z | purchase   | 664        | \-640           |
| 2           | 2020-01-03T00:00:00.000Z | deposit    | 549        | 549             |
| 2           | 2020-03-24T00:00:00.000Z | deposit    | 61         | 610             |
| 3           | 2020-01-27T00:00:00.000Z | deposit    | 144        | 144             |
| 3           | 2020-02-22T00:00:00.000Z | purchase   | 965        | \-821           |
| 3           | 2020-03-05T00:00:00.000Z | withdrawal | 213        | \-1034          |
| 3           | 2020-03-19T00:00:00.000Z | withdrawal | 188        | \-1222          |
| 3           | 2020-04-12T00:00:00.000Z | deposit    | 493        | \-729           |
| 4           | 2020-01-07T00:00:00.000Z | deposit    | 458        | 458             |
| 4           | 2020-01-21T00:00:00.000Z | deposit    | 390        | 848             |
| 4           | 2020-03-25T00:00:00.000Z | purchase   | 193        | 655             |

---

### 2. Customer balance at the end of each month

```sql
WITH cte
     AS (SELECT customer_id,
                txn_date,
                txn_type,
                txn_amount,
                SUM(CASE
                      WHEN txn_type = 'deposit' THEN txn_amount
                      ELSE -txn_amount
                    END)
                  over(
                    PARTITION BY customer_id
                    ORDER BY txn_date) AS running_balance
         FROM   data_bank.customer_transactions)
SELECT customer_id,
       To_char(Date_trunc('MONTH', txn_date), 'YYYY-MM-DD') AS month_end_date,
       SUM(running_balance)                                 AS month_end_balance
FROM   cte
GROUP  BY 1,
          2
ORDER  BY 1,
          2; 
```

#### Result set

The result table is truncated.

| customer_id | month_end_date | month_end_balance |
| ----------- | -------------- | ----------------- |
| 1           | 2020-01-01     | 312               |
| 1           | 2020-03-01     | \-916             |
| 2           | 2020-01-01     | 549               |
| 2           | 2020-03-01     | 610               |
| 3           | 2020-01-01     | 144               |
| 3           | 2020-02-01     | \-821             |
| 3           | 2020-03-01     | \-2256            |
| 3           | 2020-04-01     | \-729             |
| 4           | 2020-01-01     | 1306              |
| 4           | 2020-03-01     | 655               |
| 5           | 2020-01-01     | 3708              |
| 5           | 2020-03-01     | \-2785            |
| 5           | 2020-04-01     | \-2413            |

---

### 3. Minimum, average and maximum values of the running balance for each customer

```sql
WITH cte
     AS (SELECT customer_id,
                txn_date,
                txn_type,
                txn_amount,
                SUM(CASE
                      WHEN txn_type = 'deposit' THEN txn_amount
                      ELSE -txn_amount
                    END)
                  over(
                    PARTITION BY customer_id
                    ORDER BY txn_date) AS running_balance
         FROM   data_bank.customer_transactions)
SELECT customer_id,
       Min(running_balance)           AS min_balance,
       Max(running_balance)           AS max_balance,
       Round(Avg(running_balance), 2) AS avg_balance
FROM   cte
GROUP  BY 1
ORDER  BY 1;
```

#### Result set 

The result table is truncated.

| customer_id | min_balance | max_balance | avg_balance |
| ----------- | ----------- | ----------- | ----------- |
| 1           | \-640       | 312         | \-151.00    |
| 2           | 549         | 610         | 579.50      |
| 3           | \-1222      | 144         | \-732.40    |
| 4           | 458         | 848         | 653.67      |
| 5           | \-2413      | 1780        | \-135.45    |

---

### Option 1: data is allocated based off the amount of money at the end of the previous month

```sql
WITH cte
     AS (SELECT customer_id,
                txn_date,
                txn_type,
                txn_amount,
                SUM(CASE
                      WHEN txn_type = 'deposit' THEN txn_amount
                      ELSE -txn_amount
                    END)
                  over(
                    PARTITION BY customer_id
                    ORDER BY txn_date) AS running_balance
         FROM   data_bank.customer_transactions),
     cte2
     AS (SELECT customer_id,
                To_char(Date_trunc('MONTH', txn_date), 'YYYY-MM-DD') AS
                month_end_date,
                SUM(running_balance)                                 AS
                   month_end_balance
         FROM   cte
         GROUP  BY 1,
                   2
         ORDER  BY 1,
                   2)
SELECT Extract(month FROM month_end_date :: DATE) AS month,
       SUM(month_end_balance)                     AS total_end_balance
FROM   cte2
GROUP  BY 1
ORDER  BY 1;
```

#### Result set

| month | total_end_balance |
| ----- | ----------------- |
| 1     | 390315            |
| 2     | 23341             |
| 3     | \-904668          |
| 4     | \-491691          |

---

### Option 2: data is allocated on the average amount of money kept in the account in the previous 30 days

```sql
WITH cte
     AS (SELECT customer_id,
                txn_date,
                txn_type,
                txn_amount,
                SUM(CASE
                      WHEN txn_type = 'deposit' THEN txn_amount
                      ELSE -txn_amount
                    END)
                  over(
                    PARTITION BY customer_id
                    ORDER BY txn_date) AS running_balance
         FROM   data_bank.customer_transactions),
     cte2
     AS (SELECT customer_id,
                Extract(month FROM txn_date)   AS month,
                Min(running_balance)           AS min_balance,
                Max(running_balance)           AS max_balance,
                Round(Avg(running_balance), 2) AS avg_balance
         FROM   cte
         GROUP  BY 1,
                   2
         ORDER  BY 1,
                   2)
SELECT month,
       SUM(avg_balance) AS total_avg_balance
FROM   cte2
GROUP  BY 1
ORDER  BY 1; 
```

#### Result set

| month | total_avg_balance |
| ----- | ----------------- |
| 1     | 182314.05         |
| 2     | 22331.29          |
| 3     | \-125308.81       |
| 4     | \-164041.28       |

---

### Option 3: data is updated real-time

```sql
WITH cte
     AS (SELECT customer_id,
                txn_date,
                txn_type,
                txn_amount,
                SUM(CASE
                      WHEN txn_type = 'deposit' THEN txn_amount
                      ELSE -txn_amount
                    END)
                  over(
                    PARTITION BY customer_id
                    ORDER BY txn_date) AS running_balance
         FROM   data_bank.customer_transactions)
SELECT Extract(month FROM txn_date) AS month,
       SUM(running_balance)         AS total_running_balance
FROM   cte
GROUP  BY 1
ORDER  BY 1; 
```

#### Result set

| month | total_running_balance |
| ----- | --------------------- |
| 1     | 390315                |
| 2     | 23341                 |
| 3     | \-904668              |
| 4     | \-491691              |

---
