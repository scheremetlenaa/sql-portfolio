## Case Study Questions

Which areas of the business have the highest negative impact in sales metrics performance in 2020 for the 12 week before and after period?

- region
- platform
- age_band
- demographic
- customer_type

---

## Solution

---

```sql
WITH cte AS
(
         SELECT   region,
                  platform,
                  age_band,
                  demographic,
                  customer_type,
                  SUM(sales) AS total_sales,
                  CASE
                           WHEN week_number < 25 THEN 'Before'
                           ELSE 'After'
                  END AS tp
         FROM     data_mart.clean_weekly_sales
         WHERE    week_number BETWEEN 13 AND      37
         AND      calendar_year = 20
         GROUP BY 1,
                  2,
                  3,
                  4,
                  5,
                  7 )
SELECT   region,
         platform,
         age_band,
         demographic,
         customer_type,
         SUM(
         CASE
                  WHEN tp = 'Before' THEN total_sales
         END) AS before_total_sales_12w,
         SUM(
         CASE
                  WHEN tp = 'After' THEN total_sales
         END) AS after_total_sales_12w,
         ( SUM(
         CASE
                  WHEN tp = 'After' THEN total_sales
         END) - SUM(
         CASE
                  WHEN tp = 'Before' THEN total_sales
         END) ) AS total_sales_change_12w,
         Round(( SUM(
         CASE
                  WHEN tp = 'After' THEN total_sales
         END) - SUM(
         CASE
                  WHEN tp = 'Before' THEN total_sales
         END) ) * 100.0 / SUM(
         CASE
                  WHEN tp = 'Before' THEN total_sales
         END), 2) AS total_sales_change_pct_12w
FROM     cte
GROUP BY 1,
         2,
         3,
         4,
         5
ORDER BY total_sales_change_pct_12w limit 5;
```

#### Result set

| region        | platform | age_band     | demographic | customer_type | before_total_sales_12w | after_total_sales_12w | total_sales_change_12w | total_sales_change_pct_12w |
| ------------- | -------- | ------------ | ----------- | ------------- | ---------------------- | --------------------- | ---------------------- | -------------------------- |
| SOUTH AMERICA | Shopify  | unknown      | unknown     | Existing      | 11785                  | 6808                  | \-4977                 | \-42.23                    |
| EUROPE        | Shopify  | Retirees     | Families    | New           | 7292                   | 4834                  | \-2458                 | \-33.71                    |
| EUROPE        | Shopify  | Young Adults | Families    | New           | 15863                  | 11426                 | \-4437                 | \-27.97                    |
| SOUTH AMERICA | Retail   | unknown      | unknown     | Existing      | 127781                 | 98131                 | \-29650                | \-23.20                    |
| SOUTH AMERICA | Retail   | Retirees     | Families    | New           | 168495                 | 132639                | \-35856                | \-21.28                    |

---
