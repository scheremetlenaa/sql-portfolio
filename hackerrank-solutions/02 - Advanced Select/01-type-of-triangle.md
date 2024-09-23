# [Type of Triangle](https://www.hackerrank.com/challenges/what-type-of-triangle/)

## Table Of Contents
1. [Problem Statement](#problem-statement)
2. [Datasets used](#datasets-used)
3. [Solutions](#solutions)
4. [Result set](#result-set)

## Problem Statement

Write a query identifying the type of each record in the TRIANGLES table using its three side lengths. Output one of the following statements for each record in the table:

- Equilateral: It's a triangle with  sides of equal length.
- Isosceles: It's a triangle with  sides of equal length.
- Scalene: It's a triangle with  sides of differing lengths.
- Not A Triangle: The given values of A, B, and C don't form a triangle.

## Datasets used

```TRIANGLES``` Table:

| Column | Type    |
| ------ | ------- |
| A      | Integer |
| B      | Integer |
| C      | Integer |

## Solutions

```sql
SELECT 
CASE
    WHEN A = B AND B = C THEN 'Equilateral'
    WHEN A + B > C AND B + C > A AND C + A > B AND A = B OR B = C OR C = A THEN 'Isosceles'
    WHEN A != B AND B != C AND A != C AND A + B > C AND B + C > A AND C + A > B THEN 'Scalene'
    ELSE 'Not A Triangle'
END AS triangle_type
FROM TRIANGLES;
```

## Result set

| triangle_type  |
| -------------- |
| Equilateral    |
| Equilateral    |
| Isosceles      |
| Equilateral    |
| Isosceles      |
| Equilateral    |
| Scalene        |
| Not A Triangle |
| Scalene        |
| Scalene        |
| Scalene        |
| Not A Triangle |
| Not A Triangle |
| Scalene        |
| Equilateral    |