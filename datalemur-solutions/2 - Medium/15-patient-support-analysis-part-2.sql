-- Calls to the Advocate4Me call centre are classified into various categories, but some calls cannot be neatly categorised. 
-- These uncategorised calls are labeled as “n/a”, or are left empty when the support agent does not enter anything into the call category field.
-- Write a query to calculate the percentage of calls that cannot be categorised. Round your answer to 1 decimal place.

SELECT
  ROUND(100.0 * COUNT(*) FILTER (WHERE call_category IS NULL OR call_category = 'n/a')
  / COUNT(*), 1) AS uncategorised_call_pct
FROM callers