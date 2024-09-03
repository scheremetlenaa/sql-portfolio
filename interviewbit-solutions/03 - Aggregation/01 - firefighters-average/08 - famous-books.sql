/* You are given 2 tables, One containing the available Books and the other containing the Books that have been bought by a customer. \

You have to find the Id’s of all the ‘Famous’ Books. 

A book is called ‘Famous’ if it is bought by at least 3 customers. */

/* YOUR QUERY GOES HERE
   Example: SELECT * FROM EMPLOYEE; 
*/

SELECT
    BooksId AS Id
FROM (
    SELECT
        Id,
        BooksId
    FROM BoughtBooks
    GROUP BY Id, BooksId
) t1
GROUP BY BooksId
HAVING COUNT(*) >= 3;