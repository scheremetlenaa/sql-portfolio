/* Find all numbers that appear at least three times consecutively.

Return the result table in any order. */

/* Write your T-SQL query statement below */

SELECT 
    DISTINCT l1.num AS ConsecutiveNums 
FROM Logs l1
INNER JOIN Logs l2 
    ON l1.id = l2.id - 1
INNER JOIN Logs l3 
    ON l1.id = l3.id - 2
WHERE l1.num = l2.num
AND l2.num = l3.num;