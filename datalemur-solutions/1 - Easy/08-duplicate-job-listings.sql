--retrieve the count of companies that have posted duplicate job listings

SELECT COUNT(*) FROM(
  SELECT 
    company_id, 
    title, 
    description, 
    COUNT(job_id) AS job_count
  FROM job_listings
  GROUP BY company_id, title, description
  HAVING COUNT(job_id) > 1
) t1;