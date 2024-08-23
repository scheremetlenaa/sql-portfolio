-- Write a solution to delete all duplicate emails, keeping only one unique email with the smallest id.
-- For SQL users, please note that you are supposed to write a DELETE statement and not a SELECT one.
-- The final order of the Person table does not matter.

DELETE FROM Person
WHERE id IN (
    SELECT t.id
    FROM (
        SELECT 
        id, 
        email, 
        ROW_NUMBER() OVER (PARTITION BY email ORDER BY id) AS rw_nm 
        FROM Person
    ) t
    WHERE t.rw_nm > 1 
);