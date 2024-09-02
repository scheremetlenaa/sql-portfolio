WITH dates_with_rnk AS (
    SELECT
        submission_date_dist,
        ROW_NUMBER() OVER (ORDER BY submission_date_dist) AS dates_rnk
    FROM (SELECT DISTINCT submission_date AS submission_date_dist FROM Submissions) t1
),

hackers_with_rnk AS (
    SELECT
        hacker_id,
        submission_date,
        DENSE_RANK() OVER(PARTITION BY hacker_id ORDER BY submission_date, hacker_id) AS dns_rnk
    FROM Submissions
),

grouped_hackers_with_streak AS (
    SELECT
        submission_date_dist,
        hacker_id
    FROM dates_with_rnk dwr
    LEFT JOIN hackers_with_rnk hwr ON dwr.submission_date_dist = hwr.submission_date
    AND dwr.dates_rnk = hwr.dns_rnk
    GROUP BY submission_date_dist, hacker_id
),

submissions_per_day AS (
    SELECT
        submission_date,
        hacker_id,
        COUNT(*) AS counted_submissions
    FROM Submissions
    GROUP BY submission_date, hacker_id
),

submissions_daily AS (
    SELECT
        submission_date,
        hacker_id,
        ROW_NUMBER() OVER(PARTITION BY submission_date ORDER BY counted_submissions DESC, hacker_id) AS rank_hackers_daily
    FROM submissions_per_day 
),

top_submissions_daily AS (
    SELECT
        submission_date,
        sd.hacker_id,
        name
    FROM submissions_daily sd
    INNER JOIN Hackers h ON sd.hacker_id = h.hacker_id
    WHERE rank_hackers_daily = 1
),

total_number_of_unique_hackers AS (
    SELECT
        submission_date_dist,
        COUNT(hacker_id) AS total_unique_hackers
    FROM grouped_hackers_with_streak
    GROUP BY submission_date_dist
)

SELECT
    submission_date_dist,
    total_unique_hackers,
    hacker_id,
    name
FROM total_number_of_unique_hackers tnuh
INNER JOIN top_submissions_daily tsd
ON tnuh.submission_date_dist = tsd.submission_date