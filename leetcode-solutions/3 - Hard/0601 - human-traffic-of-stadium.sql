/* Write a solution to display the records with three or more rows with consecutive id's, and the number of people is greater than or equal to 100 for each.

Return the result table ordered by visit_date in ascending order. */

/* Write your T-SQL query statement below */

WITH CTE1 AS (
    SELECT
        id,
        visit_date,
        people,
        id - ROW_NUMBER() OVER (ORDER BY id) AS grp
    FROM Stadium
    WHERE people >= 100
),

CTE2 AS (
    SELECT
        grp,
        COUNT(*) AS cnt
    FROM CTE1
    GROUP BY grp
    HAVING COUNT(*) >= 3
)

SELECT
    id,
    visit_date,
    people
FROM CTE1
INNER JOIN CTE2
    ON CTE1.grp = CTE2.grp
ORDER BY visit_date