/* You work at a ride-sharing company and are given a table containing information about the rides of users.

Write a query to get the duration (in minutes) of each ride longer than two hours. Sort the results by duration in descending order. */

SELECT
    TIMESTAMPDIFF(minute, start_dt, end_dt) AS duration_minutes
FROM rides
WHERE TIMESTAMPDIFF(minute, start_dt, end_dt) >= 120;