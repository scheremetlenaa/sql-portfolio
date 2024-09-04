-- Given two tables: accounts, and downloads, find the average number of downloads for free vs paying accounts, broken down by day.

SELECT
    download_date,
    paying_customer,
    ROUND(AVG(downloads), 2) AS average_downloads
FROM downloads d
INNER JOIN accounts a 
    ON d.account_id = a.account_id
GROUP BY download_date, paying_customer;