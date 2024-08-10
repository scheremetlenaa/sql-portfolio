-- identify the top 2 Power Users who sent the highest number of messages on Microsoft Teams in August 2022
-- Display the IDs of these 2 users along with the total number of messages they sent.

SELECT 
  sender_id,
  COUNT(*) AS message_count
FROM messages
WHERE EXTRACT(year FROM sent_date) = '2022'
AND EXTRACT(month FROM sent_date) = '8'
GROUP BY sender_id
ORDER BY message_count DESC
LIMIT 2;