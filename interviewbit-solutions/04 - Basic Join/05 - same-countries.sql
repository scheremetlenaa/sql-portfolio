/* Given a table LABOURERS, match all the pairs of Labourers that are from the same country, along with the country name. 

Keep the ordering by Name of the first laborer, then second laborer, and then Country name. */

/* YOUR QUERY GOES HERE
   Example: SELECT * FROM EMPLOYEE; 
*/

SELECT 
    L1.Name as Labourer1, 
    L2.Name as Labourer2, 
    L1.Country as Country 
from LABOURERS L1
INNER JOIN LABOURERS L2 
    ON L1.Country = L2.Country 
    AND L1.Name <> L2.Name 
ORDER BY L1.Name, L2.Name, L1.Country;