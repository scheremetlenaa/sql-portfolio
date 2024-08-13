-- A phone call is considered an international call when the person calling is in a different country than the person receiving the call.
-- What percentage of phone calls are international? Round the result to 1 decimal.

SELECT
  ROUND(100.0 * SUM(CASE
    WHEN caller_country != receiver_country THEN 1
    ELSE 0
  END) / COUNT(*), 1) AS international_calls_pct
FROM (
SELECT
  caller.country_id AS caller_country,
  receiver.country_id AS receiver_country
FROM phone_calls
LEFT JOIN phone_info caller
  ON phone_calls.caller_id = caller.caller_id
LEFT JOIN phone_info receiver
  ON phone_calls.receiver_id = receiver.caller_id
) t1;