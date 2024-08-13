-- Write a query that outputs the name of the credit card, and how many cards were issued in its launch month. 
-- The launch month is the earliest record in the monthly_cards_issued table for a given card. 
-- Order the results starting from the biggest issued amount.

SELECT
  card_name,
  issued_amount
FROM (
SELECT 
  card_name,
  issued_amount,
  MAKE_DATE(issue_year, issue_month, 1) AS issue_date,
  MIN(MAKE_DATE(issue_year, issue_month, 1)) OVER (PARTITION BY card_name) AS launch_date
FROM monthly_cards_issued
) t1
WHERE issue_date = launch_date
ORDER BY issued_amount DESC;