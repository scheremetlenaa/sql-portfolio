/* Samantha interviews many candidates from different colleges using coding challenges and contests. 

Write a query to print the contest_id, hacker_id, name, and the sums of total_submissions, total_accepted_submissions, 
total_views, and total_unique_views for each contest sorted by contest_id. 

Exclude the contest from the result if all four sums are 0. */

WITH sum_submissions AS (
    SELECT
                col.contest_id,
                SUM(total_submissions) AS sum_ts,
                SUM(total_accepted_submissions) AS sum_tas
    FROM        Colleges col
    INNER JOIN  Challenges cha ON col.college_id = cha.college_id
    INNER JOIN  Submission_Stats ss ON cha.challenge_id = ss.challenge_id
    GROUP BY    col.contest_id
),

sum_views AS (
    SELECT
                col.contest_id,
                SUM(total_views) AS sum_tv,
                SUM(total_unique_views) AS sum_tuv
    FROM        Colleges col
    INNER JOIN  Challenges cha ON col.college_id = cha.college_id
    INNER JOIN  View_Stats vs ON cha.challenge_id = vs.challenge_id
    GROUP BY    col.contest_id
)
    
SELECT
            con.contest_id,
            con.hacker_id,
            con.name,
            sum_ts,
            sum_tas,
            sum_tv,
            sum_tuv
FROM        Contests con
INNER JOIN  sum_submissions ON con.contest_id = sum_submissions.contest_id
INNER JOIN  sum_views ON con.contest_id = sum_views.contest_id
WHERE       sum_ts > 0
OR          sum_tas > 0
OR          sum_tv > 0
OR          sum_tuv > 0
ORDER BY    con.contest_id;