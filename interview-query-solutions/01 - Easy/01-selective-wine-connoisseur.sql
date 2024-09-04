/* Let’s say you run a wine house. You have detailed information about the chemical composition of wines in a wines table.

One day, a customer comes asking specifically for a wine that has

- Greater or equal to than 13% alcohol content
- Ash content less than 2.4
- A color intensity less than 3

Write a query to find the ids of suitable wines for this customer. */

SELECT 
    id
FROM wines
WHERE alcohol >= 13
AND ash < 2.4
AND color_intensity < 3;