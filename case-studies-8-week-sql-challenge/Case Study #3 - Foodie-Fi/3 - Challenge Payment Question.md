## Case Study Questions

The Foodie-Fi team wants you to create a new payments table for the year 2020 that includes amounts paid by each customer in the subscriptions table with the following requirements:

- monthly payments always occur on the same day of month as the original start_date of any monthly paid plan
- upgrades from basic to monthly or pro plans are reduced by the current paid amount in that month and start immediately
- upgrades from pro monthly to pro annual are paid at the end of the current billing period and also starts at the end of the month period
- once a customer churns they will no longer make payments

---

## Solution

---

```sql
DROP TABLE IF exists payments;WITH next_dates AS
(
           SELECT     s.customer_id,
                      s.plan_id,
                      Lag(p.plan_name) over(PARTITION BY s.customer_id ORDER BY s.start_date)  AS prev_plan,
                      Lag(s.start_date) over(PARTITION BY s.customer_id ORDER BY s.start_date) AS prev_date,
                      Lag(p.price) over(PARTITION BY s.customer_id ORDER BY s.start_date)      AS prev_price,
                      p.plan_name,
                      s.start_date,
                      p.price,
                      Coalesce(Lead(p.plan_name) over(PARTITION BY s.customer_id ORDER BY s.start_date), p.plan_name)   AS next_plan,
                      Coalesce(Lead(s.start_date) over(PARTITION BY s.customer_id ORDER BY s.start_date), '2020-12-31') AS next_date,
                      Coalesce(Lead(p.price) over(PARTITION BY s.customer_id ORDER BY s.start_date), p.price)           AS next_price
           FROM       foodie_fi.subscriptions s
           inner join foodie_fi.plans p
           ON         s.plan_id = p.plan_id
           WHERE      start_date <= '2020-12-31' ), upgrading_from_basic_to_pro_temp AS
(
       SELECT customer_id,
              plan_id,
              plan_name,
              payment_date,
              price
       FROM   next_dates
       join   lateral generate_series(start_date, next_date, '1 month'::interval) payment_date
       ON     TRUE
       WHERE  ((
                            plan_name = 'basic monthly'
                     AND    next_plan = 'pro monthly')
              OR     (
                            plan_name = 'pro monthly'
                     AND    prev_plan = 'basic monthly')) ), upgrading_from_basic_to_pro AS
(
         SELECT   customer_id,
                  plan_id,
                  plan_name,
                  payment_date,
                  CASE
                           WHEN (
                                             plan_name <> lag(plan_name) over(PARTITION BY customer_id ORDER BY payment_date))
                           AND      (
                                             extract(month FROM payment_date) = extract(month FROM lag(payment_date) over(PARTITION BY customer_id ORDER BY payment_date))) THEN (price - lag(price) over(PARTITION BY customer_id ORDER BY payment_date))
                           ELSE price
                  END AS amount
         FROM     upgrading_from_basic_to_pro_temp
         ORDER BY payment_date ), monthly_subscription AS
(
       SELECT customer_id,
              plan_id,
              plan_name,
              payment_date,
              price AS amount
       FROM   next_dates
       join   lateral generate_series(start_date, next_date, '1 month'::interval) payment_date
       ON     TRUE
       WHERE  (
                     plan_name = 'basic monthly'
              AND    next_plan = 'basic monthly')
       OR     (
                     plan_name = 'pro monthly'
              AND    next_plan = 'pro monthly') ), monthly_subsription_before_churn AS
(
       SELECT customer_id,
              plan_id,
              plan_name,
              payment_date,
              price AS amount
       FROM   next_dates
       join   lateral generate_series(start_date, next_date, '1 month'::interval) payment_date
       ON     TRUE
       WHERE  (
                     plan_name = 'basic monthly'
              AND    next_plan = 'churn')
       OR     (
                     plan_name = 'pro monthly'
              AND    next_plan = 'churn') ), upgrading_from_monthly_to_annual_temp AS
(
       SELECT customer_id,
              plan_id,
              plan_name,
              payment_date,
              price
       FROM   next_dates
       join   lateral generate_series(start_date, next_date, '1 month'::interval) payment_date
       ON     plan_name <> 'pro annual'
       WHERE  ((
                            plan_name = 'basic monthly'
                     AND    next_plan = 'pro annual')
              OR     (
                            plan_name = 'pro monthly'
                     AND    next_plan = 'pro annual'))
       UNION ALL
       SELECT customer_id,
              plan_id,
              plan_name,
              start_date AS payment_date,
              price
       FROM   next_dates
       WHERE  ((
                            prev_plan = 'basic monthly'
                     AND    plan_name = 'pro annual')
              OR     (
                            prev_plan = 'pro monthly'
                     AND    plan_name = 'pro annual')
              OR     (
                            prev_plan = 'trial'
                     AND    plan_name = 'pro annual')) ),
upgrading_from_monthly_to_annual AS
(
         SELECT   customer_id,
                  plan_id,
                  plan_name,
                  payment_date,
                  CASE
                           WHEN (
                                             plan_name <> lag(plan_name) over(PARTITION BY customer_id ORDER BY payment_date))
                           AND      (
                                             extract(month FROM payment_date) = extract(month FROM lag(payment_date) over(PARTITION BY customer_id ORDER BY payment_date))) THEN (price - lag(price) over(PARTITION BY customer_id ORDER BY payment_date))
                           ELSE price
                  END AS amount
         FROM     upgrading_from_monthly_to_annual_temp ), result_table_cte_1 AS
(
       SELECT *
       FROM   upgrading_from_basic_to_pro
       UNION ALL
       SELECT *
       FROM   monthly_subscription
       UNION ALL
       SELECT *
       FROM   monthly_subsription_before_churn
       UNION ALL
       SELECT *
       FROM   upgrading_from_monthly_to_annual ), result_table_cte_2 AS
(
         SELECT   customer_id,
                  plan_id,
                  plan_name,
                  payment_date,
                  min(amount) AS amount
         FROM     result_table_cte_1
         GROUP BY 1,
                  2,
                  3,
                  4
         ORDER BY payment_date )
SELECT   *,
         row_number() over (PARTITION BY customer_id ORDER BY payment_date) AS payment_order
INTO     payments
FROM     result_table_cte_2;SELECT *
FROM   payments;
```
---

## Result set
The result table is truncated.

| customer_id | plan_id | plan_name     | payment_date | amount | payment_order |
| ----------- | ------- | ------------- | ------------ | ------ | ------------- |
| 1           | 1       | basic monthly | 2020-08-08   | 9.90   | 1             |
| 1           | 1       | basic monthly | 2020-09-08   | 9.90   | 2             |
| 1           | 1       | basic monthly | 2020-10-08   | 9.90   | 3             |
| 1           | 1       | basic monthly | 2020-11-08   | 9.90   | 4             |
| 1           | 1       | basic monthly | 2020-12-08   | 9.90   | 5             |
| 2           | 3       | pro annual    | 2020-09-27   | 199.00 | 1             |
| 3           | 1       | basic monthly | 2020-01-20   | 9.90   | 1             |
| 3           | 1       | basic monthly | 2020-02-20   | 9.90   | 2             |
| 3           | 1       | basic monthly | 2020-03-20   | 9.90   | 3             |
| 3           | 1       | basic monthly | 2020-04-20   | 9.90   | 4             |
| 3           | 1       | basic monthly | 2020-05-20   | 9.90   | 5             |
| 3           | 1       | basic monthly | 2020-06-20   | 9.90   | 6             |
| 3           | 1       | basic monthly | 2020-07-20   | 9.90   | 7             |
| 3           | 1       | basic monthly | 2020-08-20   | 9.90   | 8             |
| 3           | 1       | basic monthly | 2020-09-20   | 9.90   | 9             |
| 3           | 1       | basic monthly | 2020-10-20   | 9.90   | 10            |
| 3           | 1       | basic monthly | 2020-11-20   | 9.90   | 11            |
| 3           | 1       | basic monthly | 2020-12-20   | 9.90   | 12            |
| 4           | 1       | basic monthly | 2020-01-24   | 9.90   | 1             |
| 4           | 1       | basic monthly | 2020-02-24   | 9.90   | 2             |
| 4           | 1       | basic monthly | 2020-03-24   | 9.90   | 3             |
| 5           | 1       | basic monthly | 2020-08-10   | 9.90   | 1             |
| 5           | 1       | basic monthly | 2020-09-10   | 9.90   | 2             |
| 5           | 1       | basic monthly | 2020-10-10   | 9.90   | 3             |
| 5           | 1       | basic monthly | 2020-11-10   | 9.90   | 4             |
| 5           | 1       | basic monthly | 2020-12-10   | 9.90   | 5             |
| 6           | 1       | basic monthly | 2020-12-30   | 9.90   | 1             |
| 7           | 1       | basic monthly | 2020-02-12   | 9.90   | 1             |
| 7           | 1       | basic monthly | 2020-03-12   | 9.90   | 2             |
| 7           | 1       | basic monthly | 2020-04-12   | 9.90   | 3             |
| 7           | 1       | basic monthly | 2020-05-12   | 9.90   | 4             |
| 7           | 2       | pro monthly   | 2020-05-22   | 10.00  | 5             |
| 7           | 2       | pro monthly   | 2020-06-22   | 19.90  | 6             |
| 7           | 2       | pro monthly   | 2020-07-22   | 19.90  | 7             |
| 7           | 2       | pro monthly   | 2020-08-22   | 19.90  | 8             |
| 7           | 2       | pro monthly   | 2020-09-22   | 19.90  | 9             |
| 7           | 2       | pro monthly   | 2020-10-22   | 19.90  | 10            |
| 7           | 2       | pro monthly   | 2020-11-22   | 19.90  | 11            |
| 7           | 2       | pro monthly   | 2020-12-22   | 19.90  | 12            |
| 8           | 1       | basic monthly | 2020-06-18   | 9.90   | 1             |
| 8           | 1       | basic monthly | 2020-07-18   | 9.90   | 2             |
| 8           | 2       | pro monthly   | 2020-08-03   | 19.90  | 3             |
| 8           | 2       | pro monthly   | 2020-09-03   | 19.90  | 4             |
| 8           | 2       | pro monthly   | 2020-10-03   | 19.90  | 5             |
| 8           | 2       | pro monthly   | 2020-11-03   | 19.90  | 6             |
| 8           | 2       | pro monthly   | 2020-12-03   | 19.90  | 7             |
| 9           | 3       | pro annual    | 2020-12-14   | 199.00 | 1             |
| 10          | 2       | pro monthly   | 2020-09-26   | 19.90  | 1             |
| 10          | 2       | pro monthly   | 2020-10-26   | 19.90  | 2             |
| 10          | 2       | pro monthly   | 2020-11-26   | 19.90  | 3             |
| 10          | 2       | pro monthly   | 2020-12-26   | 19.90  | 4             |
| 12          | 1       | basic monthly | 2020-09-29   | 9.90   | 1             |
| 12          | 1       | basic monthly | 2020-10-29   | 9.90   | 2             |
| 12          | 1       | basic monthly | 2020-11-29   | 9.90   | 3             |
| 12          | 1       | basic monthly | 2020-12-29   | 9.90   | 4             |
| 13          | 1       | basic monthly | 2020-12-22   | 9.90   | 1             |
| 14          | 1       | basic monthly | 2020-09-29   | 9.90   | 1             |
| 14          | 1       | basic monthly | 2020-10-29   | 9.90   | 2             |
| 14          | 1       | basic monthly | 2020-11-29   | 9.90   | 3             |
| 14          | 1       | basic monthly | 2020-12-29   | 9.90   | 4             |
| 15          | 2       | pro monthly   | 2020-03-24   | 19.90  | 1             |
| 15          | 2       | pro monthly   | 2020-04-24   | 19.90  | 2             |
| 16          | 1       | basic monthly | 2020-06-07   | 9.90   | 1             |
| 16          | 1       | basic monthly | 2020-07-07   | 9.90   | 2             |
| 16          | 1       | basic monthly | 2020-08-07   | 9.90   | 3             |
| 16          | 1       | basic monthly | 2020-09-07   | 9.90   | 4             |
| 16          | 1       | basic monthly | 2020-10-07   | 9.90   | 5             |
| 16          | 3       | pro annual    | 2020-10-21   | 189.10 | 6             |
| 17          | 1       | basic monthly | 2020-08-03   | 9.90   | 1             |
| 17          | 1       | basic monthly | 2020-09-03   | 9.90   | 2             |
| 17          | 1       | basic monthly | 2020-10-03   | 9.90   | 3             |
| 17          | 1       | basic monthly | 2020-11-03   | 9.90   | 4             |
| 17          | 1       | basic monthly | 2020-12-03   | 9.90   | 5             |
| 17          | 3       | pro annual    | 2020-12-11   | 189.10 | 6             |
| 18          | 2       | pro monthly   | 2020-07-13   | 19.90  | 1             |
| 18          | 2       | pro monthly   | 2020-08-13   | 19.90  | 2             |
| 18          | 2       | pro monthly   | 2020-09-13   | 19.90  | 3             |
| 18          | 2       | pro monthly   | 2020-10-13   | 19.90  | 4             |
| 18          | 2       | pro monthly   | 2020-11-13   | 19.90  | 5             |
| 18          | 2       | pro monthly   | 2020-12-13   | 19.90  | 6             |
| 19          | 2       | pro monthly   | 2020-06-29   | 19.90  | 1             |
| 19          | 2       | pro monthly   | 2020-07-29   | 19.90  | 2             |
| 19          | 3       | pro annual    | 2020-08-29   | 179.10 | 3             |
| 19          | 2       | pro monthly   | 2020-08-29   | 19.90  | 4             |
| 20          | 1       | basic monthly | 2020-04-15   | 9.90   | 1             |
| 20          | 1       | basic monthly | 2020-05-15   | 9.90   | 2             |
| 20          | 3       | pro annual    | 2020-06-05   | 199.00 | 3             |
| 21          | 1       | basic monthly | 2020-02-11   | 9.90   | 1             |
| 21          | 1       | basic monthly | 2020-03-11   | 9.90   | 2             |
| 21          | 1       | basic monthly | 2020-04-11   | 9.90   | 3             |
| 21          | 1       | basic monthly | 2020-05-11   | 9.90   | 4             |
| 21          | 2       | pro monthly   | 2020-06-03   | 19.90  | 5             |
| 21          | 2       | pro monthly   | 2020-07-03   | 19.90  | 6             |
| 21          | 2       | pro monthly   | 2020-08-03   | 19.90  | 7             |
| 21          | 2       | pro monthly   | 2020-09-03   | 19.90  | 8             |
| 22          | 2       | pro monthly   | 2020-01-17   | 19.90  | 1             |
| 22          | 2       | pro monthly   | 2020-02-17   | 19.90  | 2             |
| 22          | 2       | pro monthly   | 2020-03-17   | 19.90  | 3             |
| 22          | 2       | pro monthly   | 2020-04-17   | 19.90  | 4             |
| 22          | 2       | pro monthly   | 2020-05-17   | 19.90  | 5             |
| 22          | 2       | pro monthly   | 2020-06-17   | 19.90  | 6             |
| 22          | 2       | pro monthly   | 2020-07-17   | 19.90  | 7             |
| 22          | 2       | pro monthly   | 2020-08-17   | 19.90  | 8             |
| 22          | 2       | pro monthly   | 2020-09-17   | 19.90  | 9             |
| 22          | 2       | pro monthly   | 2020-10-17   | 19.90  | 10            |
| 22          | 2       | pro monthly   | 2020-11-17   | 19.90  | 11            |
| 22          | 2       | pro monthly   | 2020-12-17   | 19.90  | 12            |
| 23          | 3       | pro annual    | 2020-05-20   | 199.00 | 1             |
| 24          | 2       | pro monthly   | 2020-11-17   | 19.90  | 1             |
| 24          | 2       | pro monthly   | 2020-12-17   | 19.90  | 2             |
| 25          | 1       | basic monthly | 2020-05-17   | 9.90   | 1             |
| 25          | 2       | pro monthly   | 2020-06-16   | 19.90  | 2             |
| 25          | 2       | pro monthly   | 2020-07-16   | 19.90  | 3             |
| 25          | 2       | pro monthly   | 2020-08-16   | 19.90  | 4             |
| 25          | 2       | pro monthly   | 2020-09-16   | 19.90  | 5             |
| 25          | 2       | pro monthly   | 2020-10-16   | 19.90  | 6             |
| 25          | 2       | pro monthly   | 2020-11-16   | 19.90  | 7             |
| 25          | 2       | pro monthly   | 2020-12-16   | 19.90  | 8             |
