/* Given 2 tables EMPLOYEE and EVALUATION, build a report containing the 2 columns, Name and Rating. 

Employees with Ratings less than 6 should appear as NULL in the table. 

The entries in the table should be sorted by descending order of Rating, followed by Names in lexicographic order. */

/* YOUR QUERY GOES HERE
   Example: SELECT * FROM EMPLOYEE; 
*/

SELECT
    CASE
        WHEN EV.Rating < 6 THEN NULL
        ELSE EM.Name
    END AS Names,
    EV.Rating AS Rating
FROM EMPLOYEE EM
LEFT JOIN EVALUATION EV
    ON EM.Points BETWEEN EV.Lower AND EV.Upper
ORDER BY EV.Rating DESC, EM.Name;