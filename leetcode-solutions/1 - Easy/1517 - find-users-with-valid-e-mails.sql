-- Write a solution to find the users who have valid emails.
-- A valid e-mail has a prefix name and a domain where:

-- The prefix name is a string that may contain letters (upper or lower case), digits, underscore '_', period '.', and/or dash '-'. 
-- The prefix name must start with a letter.
-- The domain is '@leetcode.com'.

--Return the result table in any order. `

/* Write your T-SQL query statement below */

SELECT user_id, name, mail FROM Users
WHERE mail LIKE '[a-zA-Z]%@leetcode.com'
AND LEFT(mail, LEN(mail) - 13) NOT LIKE '%[^0-9a-zA-Z_.-]%'