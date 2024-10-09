## Case Study Questions

In a single query, perform the following operations and generate a new table in the ```data_mart``` schema named ```clean_weekly_sales```:

- Convert the week_date to a DATE format
- Add a week_number as the second column for each week_date value, for example any value from the 1st of January to 7th of January will be 1, 8th to 14th will be 2 etc
- Add a month_number with the calendar month for each week_date value as the 3rd column
- Add a calendar_year column as the 4th column containing either 2018, 2019 or 2020 values
- Add a new column called age_band after the original segment column using the following mapping on the number inside the segment value
  
| **segment** | **age_band** |
| ----------- | ------------ |
| 1           | Young Adults |
| 2           | Middle Aged  |
| 3 or 4      | Retirees     |

- Add a new demographic column using the following mapping for the first letter in the segment values:

| segment | demographic |
| ------- | ----------- |
| C       | Couples     |
| F       | Families    |

- Ensure all null string values with an "unknown" string value in the original segment column as well as the new age_band and demographic columns
- Generate a new avg_transaction column as the sales value divided by transactions rounded to 2 decimal places for each record

---

## Solutions

---

```sql
DROP TABLE IF exists data_mart.clean_weekly_sales;SELECT To_date(week_date, 'DD/MM/YYYY')                     AS week_date,
       Extract(week FROM To_date(week_date, 'DD/MM/YYYY'))  AS week_number,
       Extract(month FROM To_date(week_date, 'DD/MM/YYYY')) AS month_number,
       Extract(year FROM To_date(week_date, 'DD/MM/YYYY'))  AS calendar_year,
       region,
       platform,
       Coalesce(Nullif(segment, 'null'), 'unknown') AS segment,
       CASE
              WHEN segment LIKE '%1' THEN 'Young Adults'
              WHEN segment LIKE '%2' THEN 'Middle Aged'
              WHEN segment LIKE '%3'
              OR     segment LIKE '%4' THEN 'Retirees'
              ELSE 'unknown'
       END AS age_band,
       CASE
              WHEN segment LIKE 'C%' THEN 'Couples'
              WHEN segment LIKE 'F%' THEN 'Families'
              ELSE 'unknown'
       END AS demographic,
       customer_type,
       transactions,
       sales,
       Round(sales * 1.0 / transactions, 2) AS avg_transaction
INTO   data_mart.clean_weekly_sales
FROM   data_mart.weekly_sales;
```

#### Result set

The result table is truncated.

| week_date                | week_number | month_number | calendar_year | region        | platform | segment | age_band     | demographic | customer_type | transactions | sales    | avg_transaction |
| ------------------------ | ----------- | ------------ | ------------- | ------------- | -------- | ------- | ------------ | ----------- | ------------- | ------------ | -------- | --------------- |
| 0020-08-31T00:00:00.000Z | 36          | 8            | 20            | ASIA          | Retail   | C3      | Retirees     | Couples     | New           | 120631       | 3656163  | 30.31           |
| 0020-08-31T00:00:00.000Z | 36          | 8            | 20            | ASIA          | Retail   | F1      | Young Adults | Families    | New           | 31574        | 996575   | 31.56           |
| 0020-08-31T00:00:00.000Z | 36          | 8            | 20            | USA           | Retail   | unknown | unknown      | unknown     | Guest         | 529151       | 16509610 | 31.20           |
| 0020-08-31T00:00:00.000Z | 36          | 8            | 20            | EUROPE        | Retail   | C1      | Young Adults | Couples     | New           | 4517         | 141942   | 31.42           |
| 0020-08-31T00:00:00.000Z | 36          | 8            | 20            | AFRICA        | Retail   | C2      | Middle Aged  | Couples     | New           | 58046        | 1758388  | 30.29           |
| 0020-08-31T00:00:00.000Z | 36          | 8            | 20            | CANADA        | Shopify  | F2      | Middle Aged  | Families    | Existing      | 1336         | 243878   | 182.54          |
| 0020-08-31T00:00:00.000Z | 36          | 8            | 20            | AFRICA        | Shopify  | F3      | Retirees     | Families    | Existing      | 2514         | 519502   | 206.64          |
| 0020-08-31T00:00:00.000Z | 36          | 8            | 20            | ASIA          | Shopify  | F1      | Young Adults | Families    | Existing      | 2158         | 371417   | 172.11          |
| 0020-08-31T00:00:00.000Z | 36          | 8            | 20            | AFRICA        | Shopify  | F2      | Middle Aged  | Families    | New           | 318          | 49557    | 155.84          |
| 0020-08-31T00:00:00.000Z | 36          | 8            | 20            | AFRICA        | Retail   | C3      | Retirees     | Couples     | New           | 111032       | 3888162  | 35.02           |
| 0020-08-31T00:00:00.000Z | 36          | 8            | 20            | USA           | Shopify  | F1      | Young Adults | Families    | Existing      | 1398         | 260773   | 186.53          |
| 0020-08-31T00:00:00.000Z | 36          | 8            | 20            | OCEANIA       | Shopify  | C2      | Middle Aged  | Couples     | Existing      | 4661         | 882690   | 189.38          |
| 0020-08-31T00:00:00.000Z | 36          | 8            | 20            | SOUTH AMERICA | Retail   | C2      | Middle Aged  | Couples     | Existing      | 1029         | 38762    | 37.67           |
| 0020-08-31T00:00:00.000Z | 36          | 8            | 20            | SOUTH AMERICA | Shopify  | C4      | Retirees     | Couples     | New           | 6            | 917      | 152.83          |
| 0020-08-31T00:00:00.000Z | 36          | 8            | 20            | EUROPE        | Shopify  | F3      | Retirees     | Families    | Existing      | 115          | 35215    | 306.22          |
| 0020-08-31T00:00:00.000Z | 36          | 8            | 20            | OCEANIA       | Retail   | F3      | Retirees     | Families    | Existing      | 551905       | 30371770 | 55.03           |
| 0020-08-31T00:00:00.000Z | 36          | 8            | 20            | ASIA          | Shopify  | C3      | Retirees     | Couples     | Existing      | 1969         | 374327   | 190.11          |
---
