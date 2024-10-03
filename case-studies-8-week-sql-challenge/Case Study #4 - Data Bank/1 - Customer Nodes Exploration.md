## Case Study Questions

1. How many unique nodes are there on the Data Bank system?
2. What is the number of nodes per region?
3. How many customers are allocated to each region?
4. How many days on average are customers reallocated to a different node?
5. What is the median, 80th and 95th percentile for this same reallocation days metric for each region?

---

## Solutions

---

### 1. How many unique nodes are there on the Data Bank system?

```sql
SELECT 
	COUNT(DISTINCT node_id) AS unique_nodes_cnt 
FROM data_bank.customer_nodes;
```

#### Result set
| unique_nodes_cnt |
| ---------------- |
| 5                |

---

### 2. What is the number of nodes per region?

```sql
SELECT region_name,
       Count(DISTINCT node_id) AS nodes_cnt_per_region
FROM   data_bank.customer_nodes
       inner join data_bank.regions USING(region_id)
GROUP  BY region_name; 
```

#### Result set

| region_name | nodes_cnt_per_region |
| ----------- | -------------------- |
| Africa      | 5                    |
| America     | 5                    |
| Asia        | 5                    |
| Australia   | 5                    |
| Europe      | 5                    |

---

### 3. How many customers are allocated to each region?

```sql
SELECT region_name,
       Count(DISTINCT customer_id) AS customers_cnt_per_region
FROM   data_bank.customer_nodes
       inner join data_bank.regions USING(region_id)
GROUP  BY region_name;
```

#### Result set

| region_name | customers_cnt_per_region |
| ----------- | ------------------------ |
| Africa      | 102                      |
| America     | 105                      |
| Asia        | 95                       |
| Australia   | 110                      |
| Europe      | 88                       |

---

### 4. How many days on average are customers reallocated to a different node?

```sql
WITH cte
     AS (SELECT customer_id,
                start_date,
                end_date,
                Lead(start_date)
                  over(
                    PARTITION BY customer_id
                    ORDER BY start_date) AS next_start_date
         FROM   data_bank.customer_nodes)
SELECT Avg(Extract(day FROM end_date :: timestamp - start_date :: timestamp)) AS
       avg_days_reallocated
FROM   cte
WHERE  next_start_date IS NOT NULL
       AND end_date < next_start_date;
```

#### Result set

| avg_days_reallocated |
| -------------------- |
| 14.634               |

---

### 5. What is the median, 80th and 95th percentile for this same reallocation days metric for each region?

```sql
WITH cte
     AS (SELECT customer_id,
                region_id,
                start_date,
                end_date,
                Lead(start_date)
                  over(
                    PARTITION BY customer_id
                    ORDER BY start_date) AS next_start_date
         FROM   data_bank.customer_nodes),
     cte2
     AS (SELECT *,
                Extract(day FROM end_date :: timestamp - start_date :: timestamp
                ) AS
                days_difference
         FROM   cte
         WHERE  next_start_date IS NOT NULL
                AND end_date < next_start_date)
SELECT region_name,
       Percentile_cont(0.5)
         within GROUP (ORDER BY days_difference) AS median,
       Percentile_cont(0.8)
         within GROUP (ORDER BY days_difference) AS eighteeth_percentile,
       Percentile_cont(0.95)
         within GROUP (ORDER BY days_difference) AS ninety_fifth_percentile
FROM   cte2
       inner join data_bank.regions USING(region_id)
GROUP  BY region_name
ORDER  BY region_name;
```

#### Result set

| region_name | median | eighteeth_percentile | ninety_fifth_percentile |
| ----------- | ------ | -------------------- | ----------------------- |
| Africa      | 15     | 24                   | 28                      |
| America     | 15     | 23                   | 28                      |
| Asia        | 15     | 23                   | 28                      |
| Australia   | 15     | 23                   | 28                      |
| Europe      | 15     | 24                   | 28                      |

---
