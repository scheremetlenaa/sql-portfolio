/* There is a factory website that has several machines each running the same number of processes. 
Write a solution to find the average time each machine takes to complete a process.
The time to complete a process is the 'end' timestamp minus the 'start' timestamp. 
The average time is calculated by the total time to complete every process on the machine divided by the number of processes that were run.
The resulting table should have the machine_id along with the average time as processing_time, which should be rounded to 3 decimal places.
Return the result table in any order. */

/* Write your T-SQL query statement below */

SELECT
    machine_id,
    ROUND(AVG(process_time), 3) AS processing_time
FROM (
    SELECT
        machine_id,
        process_id,
        MAX(CASE WHEN activity_type = 'end' THEN timestamp END) - 
        MIN(CASE WHEN activity_type =     'start' THEN timestamp END) AS process_time
    FROM Activity
    GROUP BY machine_id, process_id
    ) t1
GROUP BY machine_id;