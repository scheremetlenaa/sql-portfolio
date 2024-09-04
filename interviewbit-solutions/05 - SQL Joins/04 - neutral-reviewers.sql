-- Write a SQL Query to find the name of all reviewers who have rated their ratings with a NULL value.

SELECT
    reviewer_name
FROM reviewers r
INNER JOIN ratings rat
    ON r.reviewer_id = rat.reviewer_id
WHERE reviewer_stars IS NULL;