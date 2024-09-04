-- Given 2 tables EMPLOYEE and EVALUATION, query for the count of names whose Rating is less than 3. Also, query for the count of names whose Rating is greater than 8.

/* YOUR QUERY GOES HERE
   Example: SELECT * FROM EMPLOYEE; 
*/

SELECT
    COUNT(Name)
FROM EMPLOYEE EM
LEFT JOIN EVALUATION EV
    ON EM.Points BETWEEN EV.Lower AND EV.Upper
WHERE Rating < 3;

SELECT
    COUNT(Name)
FROM EMPLOYEE EM
LEFT JOIN EVALUATION EV
    ON EM.Points BETWEEN EV.Lower AND EV.Upper
WHERE Rating > 8;