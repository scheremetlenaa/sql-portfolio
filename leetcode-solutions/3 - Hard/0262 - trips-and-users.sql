/* The cancellation rate is computed by dividing the number of canceled (by client or driver) requests with unbanned users by the total number of requests with unbanned users on that day.

Write a solution to find the cancellation rate of requests with unbanned users (both client and driver must not be banned) each day between "2013-10-01" and "2013-10-03". 

Round Cancellation Rate to two decimal points.

Return the result table in any order. */

/* Write your T-SQL query statement below */

WITH CTE1 AS (
    SELECT
        client_id,
        driver_id,
        role,
        banned,
        status,
        request_at
    FROM Trips t
    INNER JOIN Users u
        ON t.client_id = u.users_id
    WHERE banned = 'No'
),

CTE2 AS (
    SELECT
        client_id,
        driver_id,
        status,
        request_at
    FROM CTE1
    INNER JOIN Users
        ON CTE1.driver_id = Users.users_id
    WHERE request_at BETWEEN '2013-10-01' AND '2013-10-03'
    AND Users.banned = 'No'
)

SELECT
    request_at AS Day,
    ROUND(SUM(CASE
        WHEN status LIKE 'cancelled_by_%' THEN 1
        ELSE 0
    END) * 1.0 / COUNT(status), 2) AS 'Cancellation Rate'
FROM CTE2
GROUP BY request_at