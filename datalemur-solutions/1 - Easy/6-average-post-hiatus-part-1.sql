--find the number of days between each user’s first post of the year 
--and last post of the year in the year 2021

SELECT user_id, EXTRACT(day FROM MAX(post_date) - MIN(post_date)) AS days_between
FROM posts
WHERE EXTRACT(year FROM post_date) = 2021
GROUP BY user_id
HAVING COUNT(*) > 1;