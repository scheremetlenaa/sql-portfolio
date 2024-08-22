-- Write a solution to report all the duplicate emails. Note that it's guaranteed that the email field is not NULL.
-- Return the result table in any order.

SELECT email
FROM Person
WHERE email IS NOT NULL
GROUP BY email
HAVING COUNT(*) > 1;