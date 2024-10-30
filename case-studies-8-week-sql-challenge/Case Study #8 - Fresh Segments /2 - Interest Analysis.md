## Case Study Questions

1. Which interests have been present in all ```month_year``` dates in our dataset?
2. Using this same ```total_months``` measure - calculate the cumulative percentage of all records starting at 14 months - which ```total_months``` value passes the 90% cumulative percentage value?
3. If we were to remove all ```interest_id``` values which are lower than the ```total_months``` value we found in the previous question - how many total data points would we be removing?
4. Does this decision make sense to remove these data points from a business perspective? Use an example where there are all 14 months present to a removed ```interest``` example for your arguments - think about what it means to have less months present from a segment perspective.
5. After removing these interests - how many unique interests are there for each month?

---

## Solutions

---

### 1. Which interests have been present in all ```month_year``` dates in our dataset?

```sql
WITH CTE AS (
    SELECT 
    interest_id, 
    COUNT(DISTINCT month_year) AS total_months
  FROM fresh_segments.interest_metrics
  WHERE month_year IS NOT NULL
  GROUP BY 1
)

SELECT
    total_months,
    COUNT(DISTINCT interest_id) AS interest_cnt
FROM CTE
WHERE total_months = 14
GROUP BY 1;
```

#### Result set

| total_months | interest_cnt |
| ------------ | ------------ |
| 14           | 480          |

---

### 2. Using this same ```total_months``` measure - calculate the cumulative percentage of all records starting at 14 months - which ```total_months``` value passes the 90% cumulative percentage value?

```sql
WITH CTE AS (
  SELECT 
    interest_id, 
    COUNT(DISTINCT month_year) AS total_months
  FROM fresh_segments.interest_metrics
  WHERE month_year IS NOT NULL
  GROUP BY 1
),

CTE2 AS (
  SELECT
    total_months,
    COUNT(DISTINCT interest_id) AS interest_cnt
  FROM CTE
  GROUP BY 1
  ORDER BY 1 DESC
)

SELECT
    total_months,
    interest_cnt,
    ROUND(SUM(interest_cnt) OVER(ORDER BY total_months DESC) * 100.0 / SUM(interest_cnt) OVER(), 2) AS cumulative_pct
FROM CTE2
```

#### Result set

| total_months | interest_cnt | cumulative_pct |
| ------------ | ------------ | -------------- |
| 14           | 480          | 39.93          |
| 13           | 82           | 46.76          |
| 12           | 65           | 52.16          |
| 11           | 94           | 59.98          |
| 10           | 86           | 67.14          |
| 9            | 95           | 75.04          |
| 8            | 67           | 80.62          |
| 7            | 90           | 88.10          |
| 6            | 33           | 90.85          |
| 5            | 38           | 94.01          |
| 4            | 32           | 96.67          |
| 3            | 15           | 97.92          |
| 2            | 12           | 98.92          |
| 1            | 13           | 100.00         |

---

### 3. If we were to remove all ```interest_id``` values which are lower than the ```total_months``` value we found in the previous question - how many total data points would we be removing?

```sql
WITH CTE AS (
  SELECT 
      interest_id,
      COUNT(DISTINCT month_year)
  FROM fresh_segments.interest_metrics
  WHERE interest_id IS NOT NULL
  GROUP BY interest_id
  HAVING COUNT(DISTINCT month_year) < 6
)

SELECT
	COUNT(interest_id)
FROM fresh_segments.interest_metrics
WHERE interest_id IN (SELECT interest_id FROM CTE);
```

#### Result set

| count |
| ----- |
| 400   |

---

### 4. Does this decision make sense to remove these data points from a business perspective? Use an example where there are all 14 months present to a removed ```interest``` example for your arguments - think about what it means to have less months present from a segment perspective.

```sql
WITH CTE AS (
  SELECT 
      interest_id,
      COUNT(DISTINCT month_year) AS month_cnt
  FROM fresh_segments.interest_metrics
  WHERE interest_id IS NOT NULL
  GROUP BY interest_id
  HAVING COUNT(DISTINCT month_year) < 6
),

removed_interests AS (
SELECT
    month_year,
    COUNT(*) AS removed_interest
FROM fresh_segments.interest_metrics
WHERE interest_id IN (SELECT interest_id FROM CTE)
AND month_year IS NOT NULL
GROUP BY 1
),

present_interests AS (
  SELECT
      month_year,
      COUNT(*) AS present_interest
  FROM fresh_segments.interest_metrics
  WHERE interest_id NOT IN (SELECT interest_id FROM CTE)
  AND month_year IS NOT NULL
  GROUP BY 1
)

SELECT
    ri.month_year,
    removed_interest,
    present_interest,
    ROUND(removed_interest * 100.0 / (removed_interest + present_interest), 2) AS removed_pct
FROM removed_interests ri
INNER JOIN present_interests pi
	USING(month_year)
ORDER BY 1
```

#### Result set

| month_year | removed_interest | present_interest | removed_pct |
| ---------- | ---------------- | ---------------- | ----------- |
| 2018-07-01 | 20               | 709              | 2.74        |
| 2018-08-01 | 15               | 752              | 1.96        |
| 2018-09-01 | 6                | 774              | 0.77        |
| 2018-10-01 | 4                | 853              | 0.47        |
| 2018-11-01 | 3                | 925              | 0.32        |
| 2018-12-01 | 9                | 986              | 0.90        |
| 2019-01-01 | 7                | 966              | 0.72        |
| 2019-02-01 | 49               | 1072             | 4.37        |
| 2019-03-01 | 58               | 1078             | 5.11        |
| 2019-04-01 | 64               | 1035             | 5.82        |
| 2019-05-01 | 30               | 827              | 3.50        |
| 2019-06-01 | 20               | 804              | 2.43        |
| 2019-07-01 | 28               | 836              | 3.24        |
| 2019-08-01 | 87               | 1062             | 7.57        |

---

### 5. After removing these interests - how many unique interests are there for each month?

```sql
WITH CTE AS (
  SELECT 
      interest_id,
      COUNT(DISTINCT month_year) AS month_cnt
  FROM fresh_segments.interest_metrics
  WHERE interest_id IS NOT NULL
  GROUP BY interest_id
  HAVING COUNT(DISTINCT month_year) < 6
)

SELECT
	month_year,
	COUNT(*) AS present_interest
FROM fresh_segments.interest_metrics
WHERE interest_id NOT IN (SELECT interest_id FROM CTE)
AND month_year IS NOT NULL
GROUP BY 1
ORDER BY 1;
```

#### Result set

| month_year | present_interest |
| ---------- | ---------------- |
| 2018-07-01 | 709              |
| 2018-08-01 | 752              |
| 2018-09-01 | 774              |
| 2018-10-01 | 853              |
| 2018-11-01 | 925              |
| 2018-12-01 | 986              |
| 2019-01-01 | 966              |
| 2019-02-01 | 1072             |
| 2019-03-01 | 1078             |
| 2019-04-01 | 1035             |
| 2019-05-01 | 827              |
| 2019-06-01 | 804              |
| 2019-07-01 | 836              |
| 2019-08-01 | 1062             |

---
