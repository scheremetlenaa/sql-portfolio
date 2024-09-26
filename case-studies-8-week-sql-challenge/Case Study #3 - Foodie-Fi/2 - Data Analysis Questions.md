## Case Study Questions

1. How many customers has Foodie-Fi ever had?
2. What is the monthly distribution of trial plan start_date values for our dataset - use the start of the month as the group by value
3. What plan start_date values occur after the year 2020 for our dataset? Show the breakdown by count of events for each plan_name
4. What is the customer count and percentage of customers who have churned rounded to 1 decimal place?
5. How many customers have churned straight after their initial free trial - what percentage is this rounded to the nearest whole number?
6. What is the number and percentage of customer plans after their initial free trial?
7. What is the customer count and percentage breakdown of all 5 plan_name values at 2020-12-31?
8. How many customers have upgraded to an annual plan in 2020?
9. How many days on average does it take for a customer to an annual plan from the day they join Foodie-Fi?
10. Can you further breakdown this average value into 30 day periods (i.e. 0-30 days, 31-60 days etc)
11. How many customers downgraded from a pro monthly to a basic monthly plan in 2020?

---

## Solutions

---

### 1. How many customers has Foodie-Fi ever had?

```sql
SELECT
	COUNT(DISTINCT customer_id) AS total_customers
FROM foodie_fi.subscriptions;
```
#### Result set

| total_customers |
| --------------- |
| 1000            |

---

### 2. What is the monthly distribution of trial plan start_date values for our dataset - use the start of the month as the group by value

```sql
WITH CTE AS (
  SELECT
      TO_CHAR(s.start_date, 'MM') AS month,
      COUNT(*) AS monthly_dist
  FROM foodie_fi.subscriptions s
  INNER JOIN foodie_fi.plans p
      ON s.plan_id = p.plan_id
      AND plan_name = 'trial'
  GROUP BY 1
  ORDER BY 1
)

SELECT
	CASE
        WHEN month = '01' THEN 'January'
        WHEN month = '02' THEN 'February'
        WHEN month = '03' THEN 'March'
        WHEN month = '04' THEN 'April'
        WHEN month = '05' THEN 'May'
        WHEN month = '06' THEN 'June'
        WHEN month = '07' THEN 'July'
        WHEN month = '08' THEN 'August'
        WHEN month = '09' THEN 'September'
        WHEN month = '10' THEN 'October'
        WHEN month = '11' THEN 'November'
        WHEN month = '12' THEN 'December'
        ELSE month
    END AS month,
    monthly_dist
FROM CTE;
```
#### Result set

| month     | monthly_dist |
| --------- | ------------ |
| January   | 88           |
| February  | 68           |
| March     | 94           |
| April     | 81           |
| May       | 88           |
| June      | 79           |
| July      | 89           |
| August    | 88           |
| September | 87           |
| October   | 79           |
| November  | 75           |
| December  | 84           |

---

### 3. What plan start_date values occur after the year 2020 for our dataset? Show the breakdown by count of events for each plan_name

```sql
SELECT
    p.plan_name,
    COUNT(*) AS dist
FROM foodie_fi.subscriptions s
INNER JOIN foodie_fi.plans p
	ON s.plan_id = p.plan_id
WHERE EXTRACT(YEAR FROM s.start_date) > 2020
GROUP BY 1
ORDER BY 1;
```
#### Result set

| plan_name     | dist |
| ------------- | ---- |
| basic monthly | 8    |
| churn         | 71   |
| pro annual    | 63   |
| pro monthly   | 60   |

---

### 4. What is the customer count and percentage of customers who have churned rounded to 1 decimal place?

```sql
SELECT
    COUNT(*) AS churned_customers,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(DISTINCT customer_id) FROM foodie_fi.subscriptions), 1) AS churned_pct
FROM foodie_fi.subscriptions s
INNER JOIN foodie_fi.plans p
    ON s.plan_id = p.plan_id
WHERE plan_name = 'churn';
```
#### Result set

| churned_customers | churned_pct |
| ----------------- | ----------- |
| 307               | 30.7        |

---

### 5. How many customers have churned straight after their initial free trial - what percentage is this rounded to the nearest whole number?

```sql
WITH CTE AS (
SELECT
    s.customer_id,
    p.plan_name,
    LEAD(plan_name) OVER(PARTITION BY customer_id ORDER BY start_date) AS next_plan
FROM foodie_fi.subscriptions s
INNER JOIN foodie_fi.plans p
    ON s.plan_id = p.plan_id
)

SELECT
    COUNT(*) AS cnt_churn_after_trial,
    FLOOR(COUNT(*) * 100.0 / (SELECT COUNT(DISTINCT customer_id) FROM foodie_fi.subscriptions)) AS pct_churn_after_trial
FROM CTE
WHERE plan_name = 'trial'
AND next_plan = 'churn';
```
#### Result set

| cnt_churn_after_trial | pct_churn_after_trial |
| --------------------- | --------------------- |
| 92                    | 9                     |

---

### 6. What is the number and percentage of customer plans after their initial free trial?

```sql
WITH CTE AS (
SELECT
    s.customer_id,
    p.plan_name,
    LEAD(plan_name) OVER(PARTITION BY customer_id ORDER BY start_date) AS next_plan
FROM foodie_fi.subscriptions s
INNER JOIN foodie_fi.plans p
	ON s.plan_id = p.plan_id
)

SELECT
    next_plan AS plan_name,
    COUNT(*) AS subs_cnt,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(DISTINCT customer_id) FROM foodie_fi.subscriptions), 0) AS subs_pct
FROM CTE
WHERE plan_name = 'trial'
AND next_plan <> 'churn'
GROUP BY next_plan;
```
#### Result set

| plan_name     | subs_cnt | subs_pct |
| ------------- | -------- | -------- |
| basic monthly | 546      | 55       |
| pro annual    | 37       | 4        |
| pro monthly   | 325      | 33       |

---

### 7. What is the customer count and percentage breakdown of all 5 plan_name values at 2020-12-31?

```sql
WITH CTE AS (
  SELECT
      s.customer_id,
      p.plan_name,
      s.start_date,
      LEAD(s.start_date) OVER(PARTITION BY s.customer_id ORDER BY s.start_date) AS next_date
  FROM foodie_fi.subscriptions s
  INNER JOIN foodie_fi.plans p
      ON s.plan_id = p.plan_id
  WHERE s.start_date <= '2020-12-31'
)

SELECT
    plan_name,
    COUNT(DISTINCT customer_id) AS customer_cnt,
    ROUND(COUNT(DISTINCT customer_id) * 100.0 / (SELECT COUNT(DISTINCT customer_id) FROM foodie_fi.subscriptions), 0) AS customer_pct
FROM CTE
WHERE next_date IS NULL
GROUP BY 1;
```
#### Result set
| plan_name     | customer_cnt | customer_pct |
| ------------- | ------------ | ------------ |
| basic monthly | 224          | 22           |
| churn         | 236          | 24           |
| pro annual    | 195          | 20           |
| pro monthly   | 326          | 33           |
| trial         | 19           | 2            |

---

### 8. How many customers have upgraded to an annual plan in 2020?

```sql
SELECT
    COUNT(*) AS pro_yearly_cnt
FROM foodie_fi.subscriptions s
INNER JOIN foodie_fi.plans p
    ON s.plan_id = p.plan_id
WHERE EXTRACT(YEAR FROM start_date) = 2020
AND p.plan_name = 'pro annual';
```
#### Result set

| pro_yearly_cnt |
| -------------- |
| 195            |

---

### 9. How many days on average does it take for a customer to an annual plan from the day they join Foodie-Fi?

```sql
WITH CTE AS (
  SELECT
      *
  FROM foodie_fi.subscriptions s
  INNER JOIN foodie_fi.plans p
      ON s.plan_id = p.plan_id
  WHERE p.plan_name = 'trial'
),

CTE1 AS (
  SELECT
      *
  FROM foodie_fi.subscriptions s
  INNER JOIN foodie_fi.plans p
      ON s.plan_id = p.plan_id
  WHERE p.plan_name = 'pro annual'
)

SELECT
    ROUND(AVG(CTE1.start_date - CTE.start_date)) AS avg_conversion
FROM CTE
INNER JOIN CTE1
    ON CTE.customer_id = CTE1.customer_id;
```
#### Result set

| avg_conversion |
| -------------- |
| 105            |

---

### 10. Can you further breakdown this average value into 30 day periods (i.e. 0-30 days, 31-60 days etc)

```sql
WITH CTE AS (
  SELECT
      *
  FROM foodie_fi.subscriptions s
  INNER JOIN foodie_fi.plans p
      ON s.plan_id = p.plan_id
  WHERE p.plan_name = 'trial'
),

CTE1 AS (
  SELECT
      *
  FROM foodie_fi.subscriptions s
  INNER JOIN foodie_fi.plans p
      ON s.plan_id = p.plan_id
  WHERE p.plan_name = 'pro annual'
),

CTE3 AS (
SELECT
	(CTE1.start_date - CTE.start_date) AS conversion
FROM CTE
INNER JOIN CTE1
	ON CTE.customer_id = CTE1.customer_id
)

SELECT
    CASE
    	WHEN conversion <= 30 THEN '0-30 days'
        WHEN conversion > 30 AND conversion <= 60 THEN '31-60 days'
        WHEN conversion > 60 AND conversion <= 90 THEN '61-90 days'
        WHEN conversion > 90 AND conversion <= 120 THEN '90-120 days'
        ELSE 'over 120 days'
    END AS period,
    COUNT(*) AS customers_cnt,
    ROUND(AVG(conversion)) AS avg_conversion
FROM CTE3
GROUP BY 1
ORDER BY 1;
```
#### Result set

| period        | customers_cnt | avg_conversion |
| ------------- | ------------- | -------------- |
| 0-30 days     | 49            | 10             |
| 31-60 days    | 24            | 42             |
| 61-90 days    | 34            | 71             |
| 90-120 days   | 35            | 101            |
| over 120 days | 116           | 168            |

---

### 11. How many customers downgraded from a pro monthly to a basic monthly plan in 2020?

```sql
WITH CTE AS (
  SELECT
      s.customer_id,
      p.plan_name,
      LEAD(p.plan_name) OVER(PARTITION BY s.customer_id ORDER BY s.start_date) AS next_plan,
      LEAD(s.start_date) OVER(PARTITION BY s.customer_id ORDER BY s.start_date) AS next_date
  FROM foodie_fi.subscriptions s
  INNER JOIN foodie_fi.plans p
      ON s.plan_id = p.plan_id
)

SELECT
    COUNT(*) AS downgrade_cnt
FROM CTE
WHERE plan_name = 'pro monthly'
AND next_plan = 'basic monthly'
AND EXTRACT(YEAR FROM next_date) = 2020;
```
#### Result set
| downgrade_cnt |
| ------------- |
| 0             |

---
