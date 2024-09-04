/* You're provided with two tables: the advertiser table contains information about advertisers and their respective payment status, 

and the daily_pay table contains the current payment information for advertisers, and it only includes advertisers who have made payments.

Write a query to update the payment status of Facebook advertisers based on the information in the daily_pay table. 

The output should include the user ID and their current payment status, sorted by the user id.

The payment status of advertisers can be classified into the following categories:

- New: Advertisers who are newly registered and have made their first payment.
- Existing: Advertisers who have made payments in the past and have recently made a current payment.
- Churn: Advertisers who have made payments in the past but have not made any recent payment.
- Resurrect: Advertisers who have not made a recent payment but may have made a previous payment and have made a payment again recently. */

SELECT
  CASE
    WHEN a.user_id IS NULL THEN dp.user_id
    ELSE a.user_id
  END AS user_id,
  CASE
    WHEN paid IS NULL THEN 'CHURN'
    WHEN a.user_id IS NULL THEN 'NEW'
    ELSE
        CASE
          WHEN a.status = 'CHURN' THEN 'RESURRECT'
          ELSE 'EXISTING'
        END
  END AS new_status
FROM advertiser a
FULL OUTER JOIN daily_pay dp
  ON a.user_id = dp.user_id
ORDER BY user_id;