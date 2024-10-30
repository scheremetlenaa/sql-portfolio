## Case Study Questions

The ```index_value``` is a measure which can be used to reverse calculate the average composition for Fresh Segments’ clients.

Average composition can be calculated by dividing the ```composition``` column by the ```index_value``` column rounded to 2 decimal places.

1. What is the top 10 interests by the average composition for each month?
2. For all of these top 10 interests - which interest appears the most often?
3. What is the average of the average composition for the top 10 interests for each month?
4. What is the 3 month rolling average of the max average composition value from September 2018 to August 2019 and include the previous top ranking interests in the same output shown below.
5. Provide a possible reason why the max average composition might change from month to month? Could it signal something is not quite right with the overall business model for Fresh Segments?

---

## Solutions

---

### 1. What is the top 10 interests by the average composition for each month?

```sql
WITH avg_composition AS (
  SELECT
  	  month_year,
      interest_id,
      interest_name,
      ROUND((composition / index_value)::NUMERIC, 2) AS avg_composition
  FROM fresh_segments.interest_metrics imt
  INNER JOIN fresh_segments.interest_map imp
      ON imt.interest_id::NUMERIC = imp.id
),

ranked_avg_composition AS (
SELECT
    month_year,
    interest_id,
    interest_name,
    avg_composition,
    DENSE_RANK() OVER(PARTITION BY month_year ORDER BY avg_composition DESC) AS dns_rnk
FROM avg_composition
)

SELECT
    month_year,
    interest_id,
    interest_name,
    avg_composition
FROM ranked_avg_composition
WHERE dns_rnk <= 10
ORDER BY 1, 4 DESC;
```

#### Result set

The result table is truncated.

| month_year | interest_id | interest_name                 | avg_composition |
| ---------- | ----------- | ----------------------------- | --------------- |
| 2018-07-01 | 6324        | Las Vegas Trip Planners       | 7.36            |
| 2018-07-01 | 6284        | Gym Equipment Owners          | 6.94            |
| 2018-07-01 | 4898        | Cosmetics and Beauty Shoppers | 6.78            |
| 2018-07-01 | 77          | Luxury Retail Shoppers        | 6.61            |
| 2018-07-01 | 39          | Furniture Shoppers            | 6.51            |
| 2018-07-01 | 18619       | Asian Food Enthusiasts        | 6.10            |
| 2018-07-01 | 6208        | Recently Retired Individuals  | 5.72            |
| 2018-07-01 | 21060       | Family Adventures Travelers   | 4.85            |
| 2018-07-01 | 21057       | Work Comes First Travelers    | 4.80            |
| 2018-07-01 | 82          | HDTV Researchers              | 4.71            |
| 2018-08-01 | 6324        | Las Vegas Trip Planners       | 7.21            |
| 2018-08-01 | 6284        | Gym Equipment Owners          | 6.62            |
| 2018-08-01 | 77          | Luxury Retail Shoppers        | 6.53            |
| 2018-08-01 | 39          | Furniture Shoppers            | 6.30            |
| 2018-08-01 | 4898        | Cosmetics and Beauty Shoppers | 6.28            |
| 2018-08-01 | 21057       | Work Comes First Travelers    | 5.70            |
| 2018-08-01 | 18619       | Asian Food Enthusiasts        | 5.68            |
| 2018-08-01 | 6208        | Recently Retired Individuals  | 5.58            |
| 2018-08-01 | 7541        | Alabama Trip Planners         | 4.83            |

---

### 2. For all of these top 10 interests - which interest appears the most often?

```sql
WITH avg_composition AS (
  SELECT
  	  month_year,
      interest_id,
      interest_name,
      ROUND((composition / index_value)::NUMERIC, 2) AS avg_composition
  FROM fresh_segments.interest_metrics imt
  INNER JOIN fresh_segments.interest_map imp
      ON imt.interest_id::NUMERIC = imp.id
),

ranked_avg_composition AS (
SELECT
    month_year,
    interest_id,
    interest_name,
    avg_composition,
    DENSE_RANK() OVER(PARTITION BY month_year ORDER BY avg_composition DESC) AS dns_rnk
FROM avg_composition
),

top_10_interests AS (
  SELECT
      month_year,
      interest_id,
      interest_name,
      avg_composition
  FROM ranked_avg_composition
  WHERE dns_rnk <= 10
  ORDER BY 1, 4 DESC
)

SELECT
    interest_id,
    interest_name,
    COUNT(*) AS apperiance_cnt
FROM top_10_interests
GROUP BY 1, 2
HAVING COUNT(*) > 5
ORDER BY 3 DESC;
```

#### Result set

| interest_id | interest_name                                        | apperiance_cnt |
| ----------- | ---------------------------------------------------- | -------------- |
| 7541        | Alabama Trip Planners                                | 10             |
| 5969        | Luxury Bedding Shoppers                              | 10             |
| 6065        | Solar Energy Researchers                             | 10             |
| 18783       | Nursing and Physicians Assistant Journal Researchers | 9              |
| 10981       | New Years Eve Party Ticket Purchasers                | 9              |
| 21245       | Readers of Honduran Content                          | 9              |
| 34          | Teen Girl Clothing Shoppers                          | 8              |
| 21057       | Work Comes First Travelers                           | 8              |
| 10977       | Christmas Celebration Researchers                    | 7              |

---

### 3. What is the average of the average composition for the top 10 interests for each month?

```sql
WITH avg_composition AS (
  SELECT
  	  month_year,
      interest_id,
      interest_name,
      ROUND((composition / index_value)::NUMERIC, 2) AS avg_composition
  FROM fresh_segments.interest_metrics imt
  INNER JOIN fresh_segments.interest_map imp
      ON imt.interest_id::NUMERIC = imp.id
),

ranked_avg_composition AS (
SELECT
    month_year,
    interest_id,
    interest_name,
    avg_composition,
    DENSE_RANK() OVER(PARTITION BY month_year ORDER BY avg_composition DESC) AS dns_rnk
FROM avg_composition
),

top_10_interests AS (
  SELECT
      month_year,
      interest_id,
      interest_name,
      avg_composition
  FROM ranked_avg_composition
  WHERE dns_rnk <= 10
  ORDER BY 1, 4 DESC
)

SELECT
    month_year,
    ROUND(AVG(avg_composition), 2) AS avg_avg_composition
FROM top_10_interests
WHERE month_year IS NOT NULL
GROUP BY 1;
```

#### Result set

| month_year | avg_avg_composition |
| ---------- | ------------------- |
| 2018-07-01 | 6.04                |
| 2018-08-01 | 5.95                |
| 2018-09-01 | 6.90                |
| 2018-10-01 | 7.01                |
| 2018-11-01 | 6.62                |
| 2018-12-01 | 6.65                |
| 2019-01-01 | 6.24                |
| 2019-02-01 | 6.58                |
| 2019-03-01 | 6.07                |
| 2019-04-01 | 5.75                |
| 2019-05-01 | 3.50                |
| 2019-06-01 | 2.39                |
| 2019-07-01 | 2.72                |
| 2019-08-01 | 2.62                |

---

### 4. What is the 3 month rolling average of the max average composition value from September 2018 to August 2019 and include the previous top ranking interests in the same output shown below.

```SQL
WITH avg_composition AS (
  SELECT
  	  month_year,
      interest_id,
      interest_name,
      ROUND((composition / index_value)::NUMERIC, 2) AS avg_composition
  FROM fresh_segments.interest_metrics imt
  INNER JOIN fresh_segments.interest_map imp
      ON imt.interest_id::NUMERIC = imp.id
),

max_avg_compositions AS (
  SELECT
      month_year,
      MAX(avg_composition) AS max_avg_comp
  FROM avg_composition
  WHERE month_year IS NOT NULL
  GROUP BY 1
),

rolling_average AS (
SELECT
    month_year,
    interest_id,
    interest_name,
    max_avg_comp AS max_index_composition,
    ROUND(AVG(max_avg_comp) OVER(ORDER BY month_year ROWS BETWEEN 2 PRECEDING AND CURRENT ROW), 2) AS three_month_rolling_average
FROM avg_composition ac
INNER JOIN max_avg_compositions mac
	USING(month_year)
WHERE avg_composition = max_avg_comp
),

one_month_lag AS (
  SELECT
      *,
      CONCAT(LAG(interest_name) OVER(ORDER BY month_year), ': ', LAG(max_index_composition) OVER(ORDER BY month_year)) AS one_month_ago
  FROM rolling_average
),

two_months_lag AS (
SELECT
    *,
    LAG(one_month_ago) OVER(ORDER BY month_year) AS two_months_ago
FROM one_month_lag
)

SELECT
	*
FROM two_months_lag
WHERE month_year BETWEEN '2018-09-01' AND '2019-08-01';
```

#### Result set

| month_year | interest_id | interest_name                 | max_index_composition | three_month_rolling_average | one_month_ago                     | two_months_ago                    |
| ---------- | ----------- | ----------------------------- | --------------------- | --------------------------- | --------------------------------- | --------------------------------- |
| 2018-09-01 | 21057       | Work Comes First Travelers    | 8.26                  | 7.61                        | Las Vegas Trip Planners: 7.21     | Las Vegas Trip Planners: 7.36     |
| 2018-10-01 | 21057       | Work Comes First Travelers    | 9.14                  | 8.20                        | Work Comes First Travelers: 8.26  | Las Vegas Trip Planners: 7.21     |
| 2018-11-01 | 21057       | Work Comes First Travelers    | 8.28                  | 8.56                        | Work Comes First Travelers: 9.14  | Work Comes First Travelers: 8.26  |
| 2018-12-01 | 21057       | Work Comes First Travelers    | 8.31                  | 8.58                        | Work Comes First Travelers: 8.28  | Work Comes First Travelers: 9.14  |
| 2019-01-01 | 21057       | Work Comes First Travelers    | 7.66                  | 8.08                        | Work Comes First Travelers: 8.31  | Work Comes First Travelers: 8.28  |
| 2019-02-01 | 21057       | Work Comes First Travelers    | 7.66                  | 7.88                        | Work Comes First Travelers: 7.66  | Work Comes First Travelers: 8.31  |
| 2019-03-01 | 7541        | Alabama Trip Planners         | 6.54                  | 7.29                        | Work Comes First Travelers: 7.66  | Work Comes First Travelers: 7.66  |
| 2019-04-01 | 6065        | Solar Energy Researchers      | 6.28                  | 6.83                        | Alabama Trip Planners: 6.54       | Work Comes First Travelers: 7.66  |
| 2019-05-01 | 21245       | Readers of Honduran Content   | 4.41                  | 5.74                        | Solar Energy Researchers: 6.28    | Alabama Trip Planners: 6.54       |
| 2019-06-01 | 6324        | Las Vegas Trip Planners       | 2.77                  | 4.49                        | Readers of Honduran Content: 4.41 | Solar Energy Researchers: 6.28    |
| 2019-07-01 | 6324        | Las Vegas Trip Planners       | 2.82                  | 3.33                        | Las Vegas Trip Planners: 2.77     | Readers of Honduran Content: 4.41 |
| 2019-08-01 | 4898        | Cosmetics and Beauty Shoppers | 2.73                  | 2.77                        | Las Vegas Trip Planners: 2.82     | Las Vegas Trip Planners: 2.77     |

---
