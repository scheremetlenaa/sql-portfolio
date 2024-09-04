/* Write a query to identify the manager with the biggest team size.

You may assume there is only one manager with the largest team size. */

SELECT
    TOP 1 m.name AS manager,
    COUNT(e.id) AS team_size
FROM managers m
INNER JOIN employees e
    ON m.id = e.manager_id
GROUP BY m.name
ORDER BY team_size DESC;