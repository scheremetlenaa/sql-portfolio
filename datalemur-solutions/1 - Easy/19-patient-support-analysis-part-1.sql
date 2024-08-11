-- find how many UHG policy holders made three, or more calls

SELECT
  COUNT(*) AS policy_holder_count
FROM (
  SELECT
    policy_holder_id,
    COUNT(*) AS calls_count
  FROM callers
  GROUP BY policy_holder_id
  HAVING COUNT(*) >= 3
) t1;