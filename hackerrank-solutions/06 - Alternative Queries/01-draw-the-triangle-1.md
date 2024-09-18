# [Draw The Triangle 1](https://www.hackerrank.com/challenges/draw-the-triangle-1/)

## Table Of Contents
1. [Problem Statement]()
2. [Datasets used]()
3. [Solutions]()
4. [Result set]()

## Problem Statement

P(R) represents a pattern drawn by Julia in R rows. The following pattern represents P(5):

```
* * * * * 
* * * * 
* * * 
* * 
*
```

Write a query to print the pattern P(20).

## Solutions

```sql
DELIMITER //

CREATE PROCEDURE proc_triangle()
BEGIN
    DECLARE i INT DEFAULT 20;
    WHILE i > 0 DO
        SELECT IF(i = 1, '*', REPEAT('* ', i));
        SET i = i - 1;
    END WHILE;
END//

DELIMITER ;

CALL proc_triangle();
```

## Result set

```
* * * * * * * * * * * * * * * * * * * * 
* * * * * * * * * * * * * * * * * * * 
* * * * * * * * * * * * * * * * * * 
* * * * * * * * * * * * * * * * * 
* * * * * * * * * * * * * * * * 
* * * * * * * * * * * * * * * 
* * * * * * * * * * * * * * 
* * * * * * * * * * * * * 
* * * * * * * * * * * * 
* * * * * * * * * * * 
* * * * * * * * * * 
* * * * * * * * * 
* * * * * * * * 
* * * * * * * 
* * * * * * 
* * * * * 
* * * * 
* * * 
* * 
* 
```