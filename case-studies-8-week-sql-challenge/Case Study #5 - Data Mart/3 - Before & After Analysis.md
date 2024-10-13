## Case Study Questions

This technique is usually used when we inspect an important event and want to inspect the impact before and after a certain point in time.

Taking the week_date value of 2020-06-15 as the baseline week where the Data Mart sustainable packaging changes came into effect.

We would include all week_date values for 2020-06-15 as the start of the period after the change and the previous week_date values would be before

Using this analysis approach - answer the following questions:

1. What is the total sales for the 4 weeks before and after 2020-06-15? What is the growth or reduction rate in actual values and percentage of sales?
2. What about the entire 12 weeks before and after?
3. How do the sale metrics for these 2 periods before and after compare with the previous years in 2018 and 2019?

---

## Solutions

---

```SQL
SELECT DISTINCT week_number
FROM   data_mart.clean_weekly_sales
WHERE  week_date = '0020-06-15';

WITH cte
     AS (SELECT week_date,
                SUM(sales) AS total_sales,
                CASE
                  WHEN week_number < 25 THEN 'Before'
                  ELSE 'After'
                END        AS tp
         FROM   data_mart.clean_weekly_sales
         WHERE  week_number BETWEEN 21 AND 28
                AND calendar_year = 20
         GROUP  BY 1,
                   3
         ORDER  BY 1)
SELECT SUM(CASE
             WHEN tp = 'Before' THEN total_sales
           END)                                             AS
       before_total_sales,
       SUM(CASE
             WHEN tp = 'After' THEN total_sales
           END)                                             AS after_total_sales
       ,
       ( SUM(CASE
               WHEN tp = 'After' THEN total_sales
             END) - SUM(CASE
                          WHEN tp = 'Before' THEN total_sales
                        END) )                              AS
       total_sales_change,
       Round(( SUM(CASE
                     WHEN tp = 'After' THEN total_sales
                   END) - SUM(CASE
                                WHEN tp = 'Before' THEN total_sales
                              END) ) * 100.0 / SUM(CASE
             WHEN tp = 'Before' THEN total_sales
                                                   END), 2) AS
       total_sales_change_pct
FROM   cte;
```

#### Result set

| week_number |
| ----------- |
| 25          |

| before_total_sales | after_total_sales | total_sales_change | total_sales_change_pct |
| ------------------ | ----------------- | ------------------ | ---------------------- |
| 2345878357         | 2318994169        | \-26884188         | \-1.15                 |

---

### 2. What about the entire 12 weeks before and after?

```sql
SELECT DISTINCT week_number
FROM   data_mart.clean_weekly_sales
WHERE  week_date = '0020-06-15';

WITH cte
     AS (SELECT week_date,
                SUM(sales) AS total_sales,
                CASE
                  WHEN week_number < 25 THEN 'Before'
                  ELSE 'After'
                END        AS tp
         FROM   data_mart.clean_weekly_sales
         WHERE  week_number BETWEEN 13 AND 37
                AND calendar_year = 20
         GROUP  BY 1,
                   3
         ORDER  BY 1)
SELECT SUM(CASE
             WHEN tp = 'Before' THEN total_sales
           END)                                             AS
       before_total_sales,
       SUM(CASE
             WHEN tp = 'After' THEN total_sales
           END)                                             AS after_total_sales
       ,
       ( SUM(CASE
               WHEN tp = 'After' THEN total_sales
             END) - SUM(CASE
                          WHEN tp = 'Before' THEN total_sales
                        END) )                              AS
       total_sales_change,
       Round(( SUM(CASE
                     WHEN tp = 'After' THEN total_sales
                   END) - SUM(CASE
                                WHEN tp = 'Before' THEN total_sales
                              END) ) * 100.0 / SUM(CASE
             WHEN tp = 'Before' THEN total_sales
                                                   END), 2) AS
       total_sales_change_pct
FROM   cte;
```

#### Result set

| before_total_sales | after_total_sales | total_sales_change | total_sales_change_pct |
| ------------------ | ----------------- | ------------------ | ---------------------- |
| 7126273147         | 6973947753        | \-152325394        | \-2.14                 |

---

### 3. How do the sale metrics for these 2 periods before and after compare with the previous years in 2018 and 2019?

```sql
WITH cte
     AS (SELECT calendar_year,
                week_date,
                SUM(sales) AS total_sales,
                CASE
                  WHEN week_number < 25 THEN 'Before'
                  ELSE 'After'
                END        AS tp
         FROM   data_mart.clean_weekly_sales
         WHERE  week_number BETWEEN 21 AND 28
                AND calendar_year IN ( 18, 19, 20 )
         GROUP  BY 1,
                   2,
                   4
         ORDER  BY 1)
SELECT calendar_year,
       SUM(CASE
             WHEN tp = 'Before' THEN total_sales
           END)                                             AS
       before_total_sales_4w,
       SUM(CASE
             WHEN tp = 'After' THEN total_sales
           END)                                             AS
       after_total_sales_4w,
       ( SUM(CASE
               WHEN tp = 'After' THEN total_sales
             END) - SUM(CASE
                          WHEN tp = 'Before' THEN total_sales
                        END) )                              AS
       total_sales_change_4w,
       Round(( SUM(CASE
                     WHEN tp = 'After' THEN total_sales
                   END) - SUM(CASE
                                WHEN tp = 'Before' THEN total_sales
                              END) ) * 100.0 / SUM(CASE
             WHEN tp = 'Before' THEN total_sales
                                                   END), 2) AS
       total_sales_change_pct_4w
FROM   cte
GROUP  BY 1; 
```

```sql
WITH cte
     AS (SELECT calendar_year,
                week_date,
                SUM(sales) AS total_sales,
                CASE
                  WHEN week_number < 25 THEN 'Before'
                  ELSE 'After'
                END        AS tp
         FROM   data_mart.clean_weekly_sales
         WHERE  week_number BETWEEN 13 AND 37
                AND calendar_year IN ( 18, 19, 20 )
         GROUP  BY 1,
                   2,
                   4
         ORDER  BY 1)
SELECT calendar_year,
       SUM(CASE
             WHEN tp = 'Before' THEN total_sales
           END)                                             AS
       before_total_sales_12w,
       SUM(CASE
             WHEN tp = 'After' THEN total_sales
           END)                                             AS
       after_total_sales_12w,
       ( SUM(CASE
               WHEN tp = 'After' THEN total_sales
             END) - SUM(CASE
                          WHEN tp = 'Before' THEN total_sales
                        END) )                              AS
       total_sales_change_12w,
       Round(( SUM(CASE
                     WHEN tp = 'After' THEN total_sales
                   END) - SUM(CASE
                                WHEN tp = 'Before' THEN total_sales
                              END) ) * 100.0 / SUM(CASE
             WHEN tp = 'Before' THEN total_sales
                                                   END), 2) AS
       total_sales_change_pct_12w
FROM   cte
GROUP  BY 1;
```

#### Result set

| calendar_year | before_total_sales_4w | after_total_sales_4w | total_sales_change_4w | total_sales_change_pct_4w |
| ------------- | --------------------- | -------------------- | --------------------- | ------------------------- |
| 18            | 2125140809            | 2129242914           | 4102105               | 0.19                      |
| 19            | 2249989796            | 2252326390           | 2336594               | 0.10                      |
| 20            | 2345878357            | 2318994169           | \-26884188            | \-1.15                    |

| calendar_year | before_total_sales_12w | after_total_sales_12w | total_sales_change_12w | total_sales_change_pct_12w |
| ------------- | ---------------------- | --------------------- | ---------------------- | -------------------------- |
| 18            | 6396562317             | 6500818510            | 104256193              | 1.63                       |
| 19            | 6883386397             | 6862646103            | \-20740294             | \-0.30                     |
| 20            | 7126273147             | 6973947753            | \-152325394            | \-2.14                     |

