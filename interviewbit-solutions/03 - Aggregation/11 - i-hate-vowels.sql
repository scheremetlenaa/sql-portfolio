/* You are given a ‘Students’ table consisting of Id,Name and marks of two tests namely Marks1 and Marks2. 

The teacher wants to sort the table based on their marks(in descending order). 

However the teacher has a particular hate towards students whose Names starts with a vowel. 

Therefore the teacher would take the maximum of the two tests for students whose name doesn’t start with a vowel while sorting, 

and would take the minimum of the two tests for the students whose name starts with a vowel while sorting. */

/* YOUR QUERY GOES HERE
   Example: SELECT * FROM EMPLOYEE; 
*/

SELECT
    Name
FROM Students
ORDER BY
    CASE
        WHEN LOWER(Name) REGEXP '^[aeiou]' THEN Least(Marks1, Marks2)
        ELSE GREATEST(Marks1, Marks2)
    END DESC;