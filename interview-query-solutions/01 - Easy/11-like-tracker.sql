/* The events table tracks every time a user performs a certain action (like, post_enter, etc.) on a platform. 

What query would you write to determine how many different users gave a like on June 6, 2020? */

SELECT
    COUNT(DISTINCT user_id) AS num_users_gave_like
FROM events
WHERE MONTH(created_at) = 6 AND YEAR(created_at) = 2020
AND action = 'like';