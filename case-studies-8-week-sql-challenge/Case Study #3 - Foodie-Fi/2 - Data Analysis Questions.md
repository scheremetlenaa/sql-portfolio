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

