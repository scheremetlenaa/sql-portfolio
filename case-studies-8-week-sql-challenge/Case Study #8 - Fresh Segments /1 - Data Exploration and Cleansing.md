## Case Study Questions

1. Update the ```fresh_segments.interest_metrics``` table by modifying the ```month_year``` column to be a date data type with the start of the month
2. What is count of records in the ```fresh_segments.interest_metrics``` for each ```month_year``` value sorted in chronological order (earliest to latest) with the null values appearing first?
3. What do you think we should do with these null values in the ```fresh_segments.interest_metrics```
4. How many ```interest_id``` values exist in the ```fresh_segments.interest_metrics``` table but not in the ```fresh_segments.interest_map``` table? What about the other way around?
5. Summarise the ```id``` values in the ```fresh_segments.interest_map``` by its total record count in this table
6. What sort of table join should we perform for our analysis and why? Check your logic by checking the rows where ```interest_id = 21246``` in your joined output and include all columns from ```fresh_segments.interest_metrics``` and all columns from ```fresh_segments.interest_map``` except from the ```id``` column.
7. Are there any records in your joined table where the ```month_year``` value is before the ```created_at``` value from the ```fresh_segments.interest_map``` table? Do you think these values are valid and why?

---

## Solutions

---

### 1. Update the ```fresh_segments.interest_metrics``` table by modifying the ```month_year``` column to be a date data type with the start of the month

```sql
ALTER TABLE fresh_segments.interest_metrics
ALTER COLUMN month_year TYPE DATE
USING TO_DATE(month_year, 'MM-YYYY');

SELECT * FROM fresh_segments.interest_metrics;
```

#### Result set

| _month | _year | month_year | interest_id | composition | index_value | ranking | percentile_ranking |
| ------ | ----- | ---------- | ----------- | ----------- | ----------- | ------- | ------------------ |
| 7      | 2018  | 2018-07-01 | 32486       | 11.89       | 6.19        | 1       | 99.86              |
| 7      | 2018  | 2018-07-01 | 6106        | 9.93        | 5.31        | 2       | 99.73              |
| 7      | 2018  | 2018-07-01 | 18923       | 10.85       | 5.29        | 3       | 99.59              |
| 7      | 2018  | 2018-07-01 | 6344        | 10.32       | 5.1         | 4       | 99.45              |
| 7      | 2018  | 2018-07-01 | 100         | 10.77       | 5.04        | 5       | 99.31              |
| 7      | 2018  | 2018-07-01 | 69          | 10.82       | 5.03        | 6       | 99.18              |

---

### 2. What is count of records in the ```fresh_segments.interest_metrics``` for each ```month_year``` value sorted in chronological order (earliest to latest) with the null values appearing first?

```sql
SELECT
	  month_year,
    COUNT(*)
FROM fresh_segments.interest_metrics
GROUP BY 1
ORDER BY 1 NULLS FIRST;
```

#### Result set

| month_year | count |
| ---------- | ----- |
| null       | 1194  |
| 2018-07-01 | 729   |
| 2018-08-01 | 767   |
| 2018-09-01 | 780   |
| 2018-10-01 | 857   |
| 2018-11-01 | 928   |
| 2018-12-01 | 995   |
| 2019-01-01 | 973   |
| 2019-02-01 | 1121  |
| 2019-03-01 | 1136  |
| 2019-04-01 | 1099  |
| 2019-05-01 | 857   |
| 2019-06-01 | 824   |
| 2019-07-01 | 864   |
| 2019-08-01 | 1149  |

---

### 4. How many ```interest_id``` values exist in the ```fresh_segments.interest_metrics``` table but not in the ```fresh_segments.interest_map``` table? What about the other way around?

```sql
SELECT
    SUM(CASE WHEN imt.interest_id::NUMERIC IS NULL THEN 1 ELSE 0 END) AS not_in_map,
    SUM(CASE WHEN imp.id IS NULL THEN 1 ELSE 0 END) AS not_in_metrics
FROM fresh_segments.interest_metrics imt
FULL OUTER JOIN fresh_segments.interest_map imp
	ON imt.interest_id::NUMERIC = imp.id;
```

#### Result set

| not_in_map | not_in_metrics |
| ---------- | -------------- |
| 1200       | 1193           |

---

### 5. Summarise the ```id``` values in the ```fresh_segments.interest_map``` by its total record count in this table

```sql
SELECT
	  id,
    COUNT(*) AS records_count
FROM fresh_segments.interest_map
GROUP BY 1;
```

#### Result set

The result table is truncated.

| id    | records_count |
| ----- | ------------- |
| 6062  | 1             |
| 10978 | 1             |
| 7546  | 1             |
| 51    | 1             |
| 45524 | 1             |
| 34647 | 1             |
| 37876 | 1             |
| 6301  | 1             |
| 70    | 1             |
| 21246 | 1             |
| 33961 | 1             |
| 12602 | 1             |
| 40694 | 1             |
| 6108  | 1             |
| 47130 | 1             |
| 37878 | 1             |
| 17803 | 1             |
| 33957 | 1             |

---

### 6. What sort of table join should we perform for our analysis and why? Check your logic by checking the rows where ```interest_id = 21246``` in your joined output and include all columns from ```fresh_segments.interest_metrics``` and all columns from ```fresh_segments.interest_map``` except from the ```id``` column.

```sql
SELECT
  	imt.*,
    imp.interest_name,
    imp.interest_summary,
    imp.created_at,
    imp.last_modified
FROM fresh_segments.interest_metrics imt
LEFT JOIN fresh_segments.interest_map imp
	ON imt.interest_id::NUMERIC = imp.id
WHERE interest_id::NUMERIC = 21246;
```

#### Result set

| _month | _year | month_year | interest_id | composition | index_value | ranking | percentile_ranking | interest_name                    | interest_summary                                      | created_at          | last_modified       |
| ------ | ----- | ---------- | ----------- | ----------- | ----------- | ------- | ------------------ | -------------------------------- | ----------------------------------------------------- | ------------------- | ------------------- |
| 7      | 2018  | 2018-07-01 | 21246       | 2.26        | 0.65        | 722     | 0.96               | Readers of El Salvadoran Content | People reading news from El Salvadoran media sources. | 2018-06-11 17:50:04 | 2018-06-11 17:50:04 |
| 8      | 2018  | 2018-08-01 | 21246       | 2.13        | 0.59        | 765     | 0.26               | Readers of El Salvadoran Content | People reading news from El Salvadoran media sources. | 2018-06-11 17:50:04 | 2018-06-11 17:50:04 |
| 9      | 2018  | 2018-09-01 | 21246       | 2.06        | 0.61        | 774     | 0.77               | Readers of El Salvadoran Content | People reading news from El Salvadoran media sources. | 2018-06-11 17:50:04 | 2018-06-11 17:50:04 |
| 10     | 2018  | 2018-10-01 | 21246       | 1.74        | 0.58        | 855     | 0.23               | Readers of El Salvadoran Content | People reading news from El Salvadoran media sources. | 2018-06-11 17:50:04 | 2018-06-11 17:50:04 |
| 11     | 2018  | 2018-11-01 | 21246       | 2.25        | 0.78        | 908     | 2.16               | Readers of El Salvadoran Content | People reading news from El Salvadoran media sources. | 2018-06-11 17:50:04 | 2018-06-11 17:50:04 |
| 12     | 2018  | 2018-12-01 | 21246       | 1.97        | 0.7         | 983     | 1.21               | Readers of El Salvadoran Content | People reading news from El Salvadoran media sources. | 2018-06-11 17:50:04 | 2018-06-11 17:50:04 |
| 1      | 2019  | 2019-01-01 | 21246       | 2.05        | 0.76        | 954     | 1.95               | Readers of El Salvadoran Content | People reading news from El Salvadoran media sources. | 2018-06-11 17:50:04 | 2018-06-11 17:50:04 |
| 2      | 2019  | 2019-02-01 | 21246       | 1.84        | 0.68        | 1109    | 1.07               | Readers of El Salvadoran Content | People reading news from El Salvadoran media sources. | 2018-06-11 17:50:04 | 2018-06-11 17:50:04 |
| 3      | 2019  | 2019-03-01 | 21246       | 1.75        | 0.67        | 1123    | 1.14               | Readers of El Salvadoran Content | People reading news from El Salvadoran media sources. | 2018-06-11 17:50:04 | 2018-06-11 17:50:04 |
| 4      | 2019  | 2019-04-01 | 21246       | 1.58        | 0.63        | 1092    | 0.64               | Readers of El Salvadoran Content | People reading news from El Salvadoran media sources. | 2018-06-11 17:50:04 | 2018-06-11 17:50:04 |
| null   | null  | null       | 21246       | 1.61        | 0.68        | 1191    | 0.25               | Readers of El Salvadoran Content | People reading news from El Salvadoran media sources. | 2018-06-11 17:50:04 | 2018-06-11 17:50:04 |

---

### 7. Are there any records in your joined table where the ```month_year``` value is before the ```created_at``` value from the ```fresh_segments.interest_map``` table? Do you think these values are valid and why?

```sql
SELECT
	COUNT(*)
FROM fresh_segments.interest_metrics imt
LEFT JOIN fresh_segments.interest_map imp
	ON imt.interest_id::NUMERIC = imp.id
WHERE month_year < created_at;

SELECT
	COUNT(*)
FROM fresh_segments.interest_metrics imt
LEFT JOIN fresh_segments.interest_map imp
	ON imt.interest_id::NUMERIC = imp.id
WHERE month_year < DATE_TRUNC('MONTH', created_at);
```

#### Result set

| count |
| ----- |
| 188   |

| count |
| ----- |
| 0     |

---
