--write a query to obtain a histogram of tweets posted per user in 2022

SELECT
  groups AS tweet_bucket,
  COUNT(*) AS users_num
FROM (
  SELECT
    COUNT(*) AS groups
  FROM tweets
  WHERE tweet_date BETWEEN '01/01/2022' AND '12/31/2022'
  GROUP BY user_id
) t1
GROUP BY tweet_bucket;