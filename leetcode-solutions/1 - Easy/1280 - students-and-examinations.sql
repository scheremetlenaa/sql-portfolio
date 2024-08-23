-- Write a solution to find the number of times each student attended each exam.
-- Return the result table ordered by student_id and subject_name.

/* Write your T-SQL query statement below */

WITH CTE AS (
    SELECT
    st.student_id,
    st.student_name,
    sb.subject_name
    FROM Students st, Subjects sb
)

SELECT
CTE.student_id,
CTE.student_name,
CTE.subject_name,
SUM(CASE WHEN ex.subject_name IS NULL THEN 0 ELSE 1 END) AS attended_exams
FROM CTE
LEFT JOIN Examinations ex
    ON CTE.student_id = ex.student_id
    AND CTE.subject_name = ex.subject_name
GROUP BY CTE.student_id, CTE.student_name, CTE.subject_name