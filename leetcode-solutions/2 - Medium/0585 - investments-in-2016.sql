/* Write a solution to report the sum of all total investment values in 2016 tiv_2016, for all policyholders who:

- have the same tiv_2015 value as one or more other policyholders, and
- are not located in the same city as any other policyholder (i.e., the (lat, lon) attribute pairs must be unique).

Round tiv_2016 to two decimal places. */

/* Write your T-SQL query statement below */

WITH CTE AS (
    SELECT
        pid,
        tiv_2015,
        tiv_2016,
        COUNT(pid) OVER (PARTITION BY tiv_2015) AS cnt_2015,
        COUNT(pid) OVER (PARTITION BY lat, lon) AS cnt_loc
    FROM Insurance
)

SELECT
    ROUND(SUM(tiv_2016), 2) AS tiv_2016 
FROM CTE
WHERE cnt_2015 > 1  
AND cnt_loc < 2;