/* You are given a table having the marks of one student in every test (Tests are held every day). 

You have to output the tests in which the student has improved his performance. 

For a student to improve his performance he has to score more than the previous test. 

Given that TestIDs are in increasing order, forming a continuous sequence without any missing numbers. */

/* YOUR QUERY GOES HERE
   Example: SELECT * FROM EMPLOYEE; 
*/

SELECT 
    T2.TestId
FROM Tests T1
INNER JOIN Tests T2
    ON T1.TestId = T2.TestId - 1 
    AND T1.marks < T2.marks;