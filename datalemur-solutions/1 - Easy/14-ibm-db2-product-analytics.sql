--generate data to populate a histogram that shows the number of unique queries run by employees during the third quarter of 2023

FROM (
  SELECT
    employees.employee_id,
    COALESCE(COUNT(DISTINCT query_id), 0) AS unique_queries
  FROM employees
  LEFT JOIN queries 
    ON queries.employee_id = employees.employee_id
      AND query_starttime >= '07/01/2023 00:00:00'
      AND query_starttime < '10/01/2023 00:00:00'
  GROUP BY employees.employee_id
) t1
GROUP BY unique_queries
ORDER BY unique_queries;