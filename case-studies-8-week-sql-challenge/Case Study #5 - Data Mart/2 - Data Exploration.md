## Case Study Questions

1. What day of the week is used for each week_date value?
2. What range of week numbers are missing from the dataset?
3. How many total transactions were there for each year in the dataset?
4. What is the total sales for each region for each month?
5. What is the total count of transactions for each platform
6. What is the percentage of sales for Retail vs Shopify for each month?
7. What is the percentage of sales by demographic for each year in the dataset?
8. Which age_band and demographic values contribute the most to Retail sales?
9. Can we use the avg_transaction column to find the average transaction size for each year for Retail vs Shopify? If not - how would you calculate it instead?

---

## Solutions

---

### 1. What day of the week is used for each week_date value?

```sql
SELECT To_char(week_date, 'Day') AS day_of_week
FROM   data_mart.clean_weekly_sales;
```

#### Result set

The result table is truncated.

| day_of_week |
| ----------- |
| Monday      |
| Monday      |
| Monday      |
| Monday      |
| Monday      |

---

### 2. What range of week numbers are missing from the dataset?

```sql
WITH all_weeks AS
(
       SELECT Generate_series(1, 52) AS week_number), existing_weeks AS
(
                SELECT DISTINCT extract(week FROM week_date) AS week_number
                FROM            data_mart.clean_weekly_sales)
SELECT     string_agg(all_weeks.week_number::VARCHAR, ', ') AS missing_week_number
FROM       existing_weeks
right join all_weeks
USING     (week_number)
WHERE      existing_weeks.week_number IS NULL;
```

#### Result set

| missing_week_number                                                                                   |
| ----------------------------------------------------------------------------------------------------- |
| 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52 |

---

### 3. How many total transactions were there for each year in the dataset?

```sql
SELECT calendar_year,
       SUM(transactions) AS trs_cnt
FROM   data_mart.clean_weekly_sales
GROUP  BY 1
ORDER  BY 1;
```

#### Result set

| calendar_year | trs_cnt   |
| ------------- | --------- |
| 18            | 346406460 |
| 19            | 365639285 |
| 20            | 375813651 |

---

### 4. What is the total sales for each region for each month?

```sql
SELECT region,
       month_number,
       SUM(sales) AS total_sales
FROM   data_mart.clean_weekly_sales
GROUP  BY 1,
          2
ORDER  BY 1,
          2;
```

#### Result set

| region        | month_number | total_sales |
| ------------- | ------------ | ----------- |
| AFRICA        | 3            | 567767480   |
| AFRICA        | 4            | 1911783504  |
| AFRICA        | 5            | 1647244738  |
| AFRICA        | 6            | 1767559760  |
| AFRICA        | 7            | 1960219710  |
| AFRICA        | 8            | 1809596890  |
| AFRICA        | 9            | 276320987   |
| ASIA          | 3            | 529770793   |
| ASIA          | 4            | 1804628707  |
| ASIA          | 5            | 1526285399  |
| ASIA          | 6            | 1619482889  |
| ASIA          | 7            | 1768844756  |
| ASIA          | 8            | 1663320609  |
| ASIA          | 9            | 252836807   |
| CANADA        | 3            | 144634329   |
| CANADA        | 4            | 484552594   |
| CANADA        | 5            | 412378365   |
| CANADA        | 6            | 443846698   |
| CANADA        | 7            | 477134947   |
| CANADA        | 8            | 447073019   |
| CANADA        | 9            | 69067959    |
| EUROPE        | 3            | 35337093    |
| EUROPE        | 4            | 127334255   |
| EUROPE        | 5            | 109338389   |
| EUROPE        | 6            | 122813826   |
| EUROPE        | 7            | 136757466   |
| EUROPE        | 8            | 122102995   |
| EUROPE        | 9            | 18877433    |
| OCEANIA       | 3            | 783282888   |
| OCEANIA       | 4            | 2599767620  |
| OCEANIA       | 5            | 2215657304  |
| OCEANIA       | 6            | 2371884744  |
| OCEANIA       | 7            | 2563459400  |
| OCEANIA       | 8            | 2432313652  |
| OCEANIA       | 9            | 372465518   |
| SOUTH AMERICA | 3            | 71023109    |
| SOUTH AMERICA | 4            | 238451531   |
| SOUTH AMERICA | 5            | 201391809   |
| SOUTH AMERICA | 6            | 218247455   |
| SOUTH AMERICA | 7            | 235582776   |
| SOUTH AMERICA | 8            | 221166052   |
| SOUTH AMERICA | 9            | 34175583    |
| USA           | 3            | 225353043   |
| USA           | 4            | 759786323   |
| USA           | 5            | 655967121   |
| USA           | 6            | 703878990   |
| USA           | 7            | 760331754   |
| USA           | 8            | 712002790   |
| USA           | 9            | 110532368   |

---

### 5. What is the total count of transactions for each platform

```sql
SELECT platform,
       SUM(transactions) AS total_trs
FROM   data_mart.clean_weekly_sales
GROUP  BY 1
ORDER  BY 1;
```

#### Result set

| platform | total_trs  |
| -------- | ---------- |
| Retail   | 1081934227 |
| Shopify  | 5925169    |

---

### 6. What is the percentage of sales for Retail vs Shopify for each month?

```sql
WITH cte
     AS (SELECT month_number,
                SUM(CASE
                      WHEN platform = 'Retail' THEN sales
                      ELSE 0
                    END) AS total_retail_sales,
                SUM(CASE
                      WHEN platform = 'Shopify' THEN sales
                      ELSE 0
                    END) AS total_shopify_sales
         FROM   data_mart.clean_weekly_sales
         GROUP  BY 1)
SELECT month_number,
       Round(total_retail_sales * 100.0 / (
             total_retail_sales + total_shopify_sales ),
       2)   AS total_retail_sales_pct,
       Round(total_shopify_sales * 100.0 / (
             total_retail_sales + total_shopify_sales )
       , 2) AS total_shopify_sales_pct
FROM   cte
```

#### Result set

| month_number | total_retail_sales_pct | total_shopify_sales_pct |
| ------------ | ---------------------- | ----------------------- |
| 3            | 97.54                  | 2.46                    |
| 7            | 97.29                  | 2.71                    |
| 8            | 97.08                  | 2.92                    |
| 5            | 97.30                  | 2.70                    |
| 9            | 97.38                  | 2.62                    |
| 4            | 97.59                  | 2.41                    |
| 6            | 97.27                  | 2.73                    |

---

### 7. What is the percentage of sales by demographic for each year in the dataset?

```sql
WITH cte
     AS (SELECT calendar_year,
                SUM(CASE
                      WHEN demographic = 'Couples' THEN sales
                      ELSE 0
                    END) AS couples_sales,
                SUM(CASE
                      WHEN demographic = 'Families' THEN sales
                      ELSE 0
                    END) AS families_sales,
                SUM(CASE
                      WHEN demographic = 'unknown' THEN sales
                      ELSE 0
                    END) AS unknown_sales
         FROM   data_mart.clean_weekly_sales
         GROUP  BY 1
         ORDER  BY 1)
SELECT calendar_year,
       Round(couples_sales * 100.0 / ( couples_sales + families_sales +
                                       unknown_sales )
       , 2)                                 AS couples_sales_pct,
       Round(families_sales * 100.0 / ( couples_sales + families_sales +
                                        unknown_sales
                                      ), 2) AS families_sales_pct,
       Round(unknown_sales * 100.0 / ( couples_sales + families_sales +
                                       unknown_sales )
       , 2)                                 AS unknown_sales_pct
FROM   cte
```

#### Result set

| calendar_year | couples_sales_pct | families_sales_pct | unknown_sales_pct |
| ------------- | ----------------- | ------------------ | ----------------- |
| 18            | 26.38             | 31.99              | 41.63             |
| 19            | 27.28             | 32.47              | 40.25             |
| 20            | 28.72             | 32.73              | 38.55             |

---

### 8. Which age_band and demographic values contribute the most to Retail sales?

```sql
WITH cte
     AS (SELECT age_band,
                demographic,
                SUM(sales) AS total_sales
         FROM   data_mart.clean_weekly_sales
         GROUP  BY 1,
                   2)
SELECT age_band,
       demographic,
       total_sales,
       Round(total_sales * 100.0 / SUM(total_sales)
                                     over(), 2) AS total_sales_pct
FROM   cte
ORDER  BY 4 DESC;
```

#### Result set

| age_band     | demographic | total_sales | total_sales_pct |
| ------------ | ----------- | ----------- | --------------- |
| unknown      | unknown     | 16338612234 | 40.10           |
| Retirees     | Families    | 6750457132  | 16.57           |
| Retirees     | Couples     | 6531115070  | 16.03           |
| Middle Aged  | Families    | 4556141618  | 11.18           |
| Young Adults | Couples     | 2679593130  | 6.58            |
| Middle Aged  | Couples     | 1990499351  | 4.89            |
| Young Adults | Families    | 1897215692  | 4.66            |

---

### 9. Can we use the avg_transaction column to find the average transaction size for each year for Retail vs Shopify? If not - how would you calculate it instead?

```sql
WITH cte
     AS (SELECT calendar_year,
                platform,
                SUM(sales)        AS total_sales,
                SUM(transactions) AS total_transactions
         FROM   data_mart.clean_weekly_sales
         GROUP  BY 1,
                   2
         ORDER  BY 1,
                   2)
SELECT calendar_year,
       platform,
       total_sales / total_transactions AS avg_transaction_size
FROM   cte
ORDER  BY 1,
          2;
```

#### Result set

| calendar_year | platform | avg_transaction_size |
| ------------- | -------- | -------------------- |
| 18            | Retail   | 36                   |
| 18            | Shopify  | 192                  |
| 19            | Retail   | 36                   |
| 19            | Shopify  | 183                  |
| 20            | Retail   | 36                   |
| 20            | Shopify  | 179                  |

---
