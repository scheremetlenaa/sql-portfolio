# [1280. Students and Examinations](https://leetcode.com/problems/students-and-examinations/description/)

## Table Of Contents
1. [Problem Statement]()
2. [Datasets used]()
3. [Solutions]()
4. [Result set]()

## Problem Statement

Write a solution to find the number of times each student attended each exam.

Return the result table ordered by student_id and subject_name.

## Datasets used

```Students``` Table:

| Column Name   | Type    |
| ------------- | ------- |
| student_id    | int     |
| student_name  | varchar |

student_id is the primary key (column with unique values) for this table.
Each row of this table contains the ID and the name of one student in the school.

```Subjects``` Table:

| Column Name  | Type    |
| ------------ | ------- |
| subject_name | varchar |

subject_name is the primary key (column with unique values) for this table.
Each row of this table contains the name of one subject in the school.

```Examinations``` Table:

| Column Name  | Type    |
| ------------ | ------- |
| student_id   | int     |
| subject_name | varchar |

There is no primary key (column with unique values) for this table. It may contain duplicates.
Each student from the Students table takes every course from the Subjects table.
Each row of this table indicates that a student with ID student_id attended the exam of subject_name.

## Solutions

```sql
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
```

## Result set

| student_id | student_name | subject_name | attended_exams |
| ---------- | ------------ | ------------ | -------------- |
| 1          | Alice        | Math         | 3              |
| 1          | Alice        | Physics      | 2              |
| 1          | Alice        | Programming  | 1              |
| 2          | Bob          | Math         | 1              |
| 2          | Bob          | Physics      | 0              |
| 2          | Bob          | Programming  | 1              |
| 6          | Alex         | Math         | 0              |
| 6          | Alex         | Physics      | 0              |
| 6          | Alex         | Programming  | 0              |
| 13         | John         | Math         | 1              |
| 13         | John         | Physics      | 1              |
| 13         | John         | Programming  | 1              |