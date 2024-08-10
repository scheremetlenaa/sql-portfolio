-- return the IDs of the Facebook pages that have zero likes. 
-- the output should be sorted in ascending order based on the page IDs.

SELECT page_id
FROM pages
WHERE page_id NOT IN (SELECT page_id FROM page_likes)
ORDER BY page_id ASC;