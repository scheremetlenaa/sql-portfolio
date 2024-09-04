/* You work as a data analyst for a FAANG company that tracks employee salaries over time. 

The company wants to understand how the average salary in each department compares to the company's overall average salary each month.

Write a query to compare the average salary of employees in each department to the company's average salary for March 2024. 

Return the comparison result as 'higher', 'lower', or 'same' for each department. 

Display the department ID, payment month (in MM-YYYY format), and the comparison result. */

SELECT
  department_id,
  TO_CHAR(payment_date::date, 'mm-yyyy') AS payment_date,
  CASE
    WHEN AVG(amount) < (SELECT AVG(amount) FROM salary WHERE payment_date BETWEEN '03/01/2024' AND '03/31/2024')
    THEN 'lower'
    WHEN AVG(amount) > (SELECT AVG(amount) FROM salary WHERE payment_date BETWEEN '03/01/2024' AND '03/31/2024')
    THEN 'higher'
    ELSE 'same'
  END AS comparison
FROM employee e
INNER JOIN salary s
  ON e.employee_id = s.employee_id
WHERE payment_date BETWEEN '03/01/2024' AND '03/31/2024'
GROUP BY department_id, TO_CHAR(payment_date::date, 'mm-yyyy');