-- display the user IDs of those who did not confirm their sign-up on the first day, but confirmed on the second day.

SELECT
  user_id
FROM emails
INNER JOIN texts ON emails.email_id = texts.email_id
WHERE EXTRACT(day FROM (action_date - signup_date)) = 1
AND signup_action = 'Confirmed';