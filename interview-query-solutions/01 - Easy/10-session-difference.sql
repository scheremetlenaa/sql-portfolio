-- Given a table of user sessions, write a query to get the number of days between each user’s first session and last session for the year 2020. 

SELECT
    user_id,
    DATEDIFF(MAX(created_at), MIN(created_at)) AS no_of_days
FROM user_sessions
WHERE YEAR(created_at) = 2020
GROUP BY user_id
ORDER BY user_id;