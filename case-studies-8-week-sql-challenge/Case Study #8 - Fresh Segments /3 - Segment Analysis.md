## Case Study Questions

1. Using our filtered dataset by removing the interests with less than 6 months worth of data, which are the top 10 and bottom 10 interests which have the largest composition values in any ```month_year```? Only use the maximum composition value for each interest but you must keep the corresponding ```month_year```
2. Which 5 interests had the lowest average ```ranking``` value?
3. Which 5 interests had the largest standard deviation in their ```percentile_ranking``` value?
4. For the 5 interests found in the previous question - what was minimum and maximum ```percentile_ranking``` values for each interest and its corresponding ```year_month``` value? Can you describe what is happening for these 5 interests?
  5. How would you describe our customers in this segment based off their composition and ranking values? What sort of products or services should we show to these customers and what should we avoid?

---

## Solutions

---

### 1. Using our filtered dataset by removing the interests with less than 6 months worth of data, which are the top 10 and bottom 10 interests which have the largest composition values in any ```month_year```? Only use the maximum composition value for each interest but you must keep the corresponding ```month_year```

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
    interest_id,
    MAX(composition) AS max_composition
FROM fresh_segments.interest_metrics imt
WHERE interest_id NOT IN (SELECT interest_id FROM CTE)
GROUP BY 1, 2
ORDER BY 3 DESC
LIMIT 10;
```

#### Result set

| month_year | interest_id | max_composition |
| ---------- | ----------- | --------------- |
| 2018-12-01 | 21057       | 21.2            |
| 2018-10-01 | 21057       | 20.28           |
| 2018-11-01 | 21057       | 19.45           |
| 2019-01-01 | 21057       | 18.99           |
| 2018-07-01 | 6284        | 18.82           |
| 2019-02-01 | 21057       | 18.39           |
| 2018-09-01 | 21057       | 18.18           |
| 2018-07-01 | 39          | 17.44           |
| 2018-07-01 | 77          | 17.19           |
| 2018-10-01 | 12133       | 15.15           |

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
    interest_id,
    MIN(composition) AS min_composition
FROM fresh_segments.interest_metrics imt
WHERE interest_id NOT IN (SELECT interest_id FROM CTE)
GROUP BY 1, 2
ORDER BY 3
LIMIT 10;
```

#### Result set

| month_year | interest_id | min_composition |
| ---------- | ----------- | --------------- |
| 2019-05-01 | 45524       | 1.51            |
| 2019-05-01 | 20768       | 1.52            |
| 2019-06-01 | 35742       | 1.52            |
| 2019-05-01 | 4918        | 1.52            |
| 2019-04-01 | 44449       | 1.52            |
| 2019-05-01 | 39336       | 1.52            |
| 2019-06-01 | 34083       | 1.52            |
| 2019-05-01 | 6127        | 1.53            |
| 2019-06-01 | 6314        | 1.53            |
| 2019-05-01 | 36877       | 1.53            |

---

### 2. Which 5 interests had the lowest average ```ranking``` value?

```sql
WITH CTE AS (
  SELECT
      interest_id,
      interest_name,
      ROUND(AVG(ranking), 2) AS avg_ranking
  FROM fresh_segments.interest_metrics imt
  INNER JOIN fresh_segments.interest_map imp
      ON imp.id = imt.interest_id::NUMERIC
  GROUP BY 1, 2
),

CTE2 AS (
  SELECT
      interest_id,
      interest_name,
      avg_ranking,
      DENSE_RANK() OVER(ORDER BY avg_ranking) AS dns_rnk
  FROM CTE
)

SELECT
    interest_id,
    interest_name,
    avg_ranking
FROM CTE2
WHERE dns_rnk <= 5;
```

#### Result set

| interest_id | interest_name                  | avg_ranking |
| ----------- | ------------------------------ | ----------- |
| 41548       | Winter Apparel Shoppers        | 1.00        |
| 42203       | Fitness Activity Tracker Users | 4.11        |
| 115         | Mens Shoe Shoppers             | 5.93        |
| 48154       | Elite Cycling Gear Shoppers    | 7.80        |
| 171         | Shoe Shoppers                  | 9.36        |

---

### 3. Which 5 interests had the largest standard deviation in their ```percentile_ranking``` value?

```sql
WITH CTE AS (
  SELECT
      interest_id,
      interest_name,
      ROUND(STDDEV(ranking::NUMERIC), 2) AS stddev
  FROM fresh_segments.interest_metrics imt
  INNER JOIN fresh_segments.interest_map imp
      ON imp.id = imt.interest_id::NUMERIC
  GROUP BY 1, 2
),

CTE2 AS (
  SELECT
      interest_id,
      interest_name,
      stddev,
      DENSE_RANK() OVER(ORDER BY stddev DESC) AS dns_rnk
  FROM CTE
  WHERE stddev IS NOT NULL
)

SELECT
    interest_id,
    interest_name,
    stddev
FROM CTE2
WHERE dns_rnk <= 5;
```

#### Result set

| interest_id | interest_name                          | stddev_pc |
| ----------- | -------------------------------------- | --------- |
| 6260        | Blockbuster Movie Fans                 | 41.3      |
| 131         | Android Fans                           | 30.7      |
| 150         | TV Junkies                             | 30.4      |
| 23          | Techies                                | 30.2      |
| 20764       | Entertainment Industry Decision Makers | 29.0      |

---

### 4. For the 5 interests found in the previous question - what was minimum and maximum ```percentile_ranking``` values for each interest and its corresponding ```year_month``` value? Can you describe what is happening for these 5 interests?

```sql
WITH interests AS (
SELECT
    interest_id,
    interest_name,
    ROUND(STDDEV(percentile_ranking)::NUMERIC, 2) AS stddev_pr
FROM fresh_segments.interest_metrics imt
INNER JOIN fresh_segments.interest_map imp
	ON imt.interest_id::NUMERIC = imp.id
WHERE month_year IS NOT NULL
GROUP BY 1, 2
HAVING STDDEV(percentile_ranking) IS NOT NULL
ORDER BY 3 DESC
LIMIT 5
),

percentiles AS (
  SELECT
      i.interest_id,
      i.interest_name,
      MAX(percentile_ranking) AS max_pctl,
      MIN(percentile_ranking) AS min_pctl
  FROM fresh_segments.interest_metrics imt
  INNER JOIN interests i
      USING(interest_id)
  GROUP BY 1, 2
),

max_percentile AS (
  SELECT
      p.interest_id,
      p.interest_name,
      month_year AS max_year,
      max_pctl
  FROM fresh_segments.interest_metrics imt
  INNER JOIN percentiles p
      USING(interest_id)
  WHERE max_pctl = percentile_ranking
),

min_percentile AS (
  SELECT
      p.interest_id,
      p.interest_name,
      month_year AS min_year,
      min_pctl
  FROM fresh_segments.interest_metrics imt
  INNER JOIN percentiles p
      USING(interest_id)
  WHERE min_pctl = percentile_ranking
)

SELECT
    ma.interest_id,
    ma.interest_name,
    min_year,
    min_pctl,
    max_year,
    max_pctl
FROM max_percentile ma
INNER JOIN min_percentile mi 
	USING(interest_id);
```

#### Result set

| interest_id | interest_name                          | min_year   | min_pctl | max_year   | max_pctl |
| ----------- | -------------------------------------- | ---------- | -------- | ---------- | -------- |
| 131         | Android Fans                           | 2019-03-01 | 4.84     | 2018-07-01 | 75.03    |
| 150         | TV Junkies                             | 2019-08-01 | 10.01    | 2018-07-01 | 93.28    |
| 20764       | Entertainment Industry Decision Makers | 2019-08-01 | 11.23    | 2018-07-01 | 86.15    |
| 23          | Techies                                | 2019-08-01 | 7.92     | 2018-07-01 | 86.69    |
| 6260        | Blockbuster Movie Fans                 | 2019-08-01 | 2.26     | 2018-07-01 | 60.63    |

---
