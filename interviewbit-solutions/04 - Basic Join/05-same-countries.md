# [Same Countries](https://www.interviewbit.com/problems/same-countries/)

## Table Of Contents
1. [Problem Statement]()
2. [Datasets used]()
3. [Solutions]()
4. [Result set]()

## Problem Statement

Given a table LABOURERS, match all the pairs of Labourers that are from the same country, along with the country name. Keep the ordering by Name of the first laborer, then second laborer, and then Country name. The output format should be like this:

| Labourer1 | Labourer2 | Country |
| --------- | --------- | ------- |
|           |           |         |

Where Labourer1 and Labourer2 come from the same country.

## Datasets used

```LABOURERS``` Table:

| Field   | Type         |
| ------- | ------------ |
| ID      | INT          |
| Name    | VARCHAR(255) |
| Age     | INT          |
| Country | VARCHAR(255) |

## Solutions

```sql
SELECT 
    L1.Name as Labourer1, 
    L2.Name as Labourer2, 
    L1.Country as Country 
from LABOURERS L1
INNER JOIN LABOURERS L2 
    ON L1.Country = L2.Country 
    AND L1.Name <> L2.Name 
ORDER BY L1.Name, L2.Name, L1.Country;
```

## Result set

| **Labourer1** | **Labourer2** | **Country** |
| ------------- | ------------- | ----------- |
| Amalie        | Lizzie        | Afghanistan |
| Amalie        | Morganica     | Afghanistan |
| Amalie        | Renie         | Afghanistan |
| Amalie        | Sarette       | Afghanistan |
| Anestassia    | Bettine       | Nepal       |
| Anestassia    | Elyssa        | Nepal       |
| Anestassia    | Halette       | Nepal       |
| Anestassia    | Katuscha      | Nepal       |
| Anestassia    | Kore          | Nepal       |
| Annecorinne   | Claresta      | USA         |
| Annecorinne   | Dorice        | USA         |
| Annecorinne   | Millie        | USA         |
| Annecorinne   | Mureil        | USA         |
| Annecorinne   | Tamqrah       | USA         |
| Bettine       | Anestassia    | Nepal       |
| Bettine       | Elyssa        | Nepal       |
| Bettine       | Halette       | Nepal       |
| Bettine       | Katuscha      | Nepal       |
| Bettine       | Kore          | Nepal       |
| Chere         | Esmeralda     | India       |
| Chere         | Gianina       | India       |
| Chere         | Lusa          | India       |
| Chere         | Mahalia       | India       |
| Chere         | Marinna       | India       |
| Chere         | Nelle         | India       |
| Chere         | Robinia       | India       |
| Claresta      | Annecorinne   | USA         |
| Claresta      | Dorice        | USA         |
| Claresta      | Millie        | USA         |
| Claresta      | Mureil        | USA         |
| Claresta      | Tamqrah       | USA         |
| Dorice        | Annecorinne   | USA         |
| Dorice        | Claresta      | USA         |
| Dorice        | Millie        | USA         |
| Dorice        | Mureil        | USA         |
| Dorice        | Tamqrah       | USA         |
| Elyssa        | Anestassia    | Nepal       |
| Elyssa        | Bettine       | Nepal       |
| Elyssa        | Halette       | Nepal       |
| Elyssa        | Katuscha      | Nepal       |
| Elyssa        | Kore          | Nepal       |
| Esmeralda     | Chere         | India       |
| Esmeralda     | Gianina       | India       |
| Esmeralda     | Lusa          | India       |
| Esmeralda     | Mahalia       | India       |
| Esmeralda     | Marinna       | India       |
| Esmeralda     | Nelle         | India       |
| Esmeralda     | Robinia       | India       |
| Gianina       | Chere         | India       |
| Gianina       | Esmeralda     | India       |
| Gianina       | Lusa          | India       |
| Gianina       | Mahalia       | India       |
| Gianina       | Marinna       | India       |
| Gianina       | Nelle         | India       |
| Gianina       | Robinia       | India       |
| Halette       | Anestassia    | Nepal       |
| Halette       | Bettine       | Nepal       |
| Halette       | Elyssa        | Nepal       |
| Halette       | Katuscha      | Nepal       |
| Halette       | Kore          | Nepal       |
| Katuscha      | Anestassia    | Nepal       |
| Katuscha      | Bettine       | Nepal       |
| Katuscha      | Elyssa        | Nepal       |
| Katuscha      | Halette       | Nepal       |
| Katuscha      | Kore          | Nepal       |
| Kore          | Anestassia    | Nepal       |
| Kore          | Bettine       | Nepal       |
| Kore          | Elyssa        | Nepal       |
| Kore          | Halette       | Nepal       |
| Kore          | Katuscha      | Nepal       |
| Lizzie        | Amalie        | Afghanistan |
| Lizzie        | Morganica     | Afghanistan |
| Lizzie        | Renie         | Afghanistan |
| Lizzie        | Sarette       | Afghanistan |
| Lusa          | Chere         | India       |
| Lusa          | Esmeralda     | India       |
| Lusa          | Gianina       | India       |
| Lusa          | Mahalia       | India       |
| Lusa          | Marinna       | India       |
| Lusa          | Nelle         | India       |
| Lusa          | Robinia       | India       |
| Mahalia       | Chere         | India       |
| Mahalia       | Esmeralda     | India       |
| Mahalia       | Gianina       | India       |
| Mahalia       | Lusa          | India       |
| Mahalia       | Marinna       | India       |
| Mahalia       | Nelle         | India       |
| Mahalia       | Robinia       | India       |
| Marinna       | Chere         | India       |
| Marinna       | Esmeralda     | India       |
| Marinna       | Gianina       | India       |
| Marinna       | Lusa          | India       |
| Marinna       | Mahalia       | India       |
| Marinna       | Nelle         | India       |
| Marinna       | Robinia       | India       |
| Millie        | Annecorinne   | USA         |
| Millie        | Claresta      | USA         |
| Millie        | Dorice        | USA         |
| Millie        | Mureil        | USA         |
| Millie        | Tamqrah       | USA         |
| Morganica     | Amalie        | Afghanistan |
| Morganica     | Lizzie        | Afghanistan |
| Morganica     | Renie         | Afghanistan |
| Morganica     | Sarette       | Afghanistan |
| Mureil        | Annecorinne   | USA         |
| Mureil        | Claresta      | USA         |
| Mureil        | Dorice        | USA         |
| Mureil        | Millie        | USA         |
| Mureil        | Tamqrah       | USA         |
| Nelle         | Chere         | India       |
| Nelle         | Esmeralda     | India       |
| Nelle         | Gianina       | India       |
| Nelle         | Lusa          | India       |
| Nelle         | Mahalia       | India       |
| Nelle         | Marinna       | India       |
| Nelle         | Robinia       | India       |
| Renie         | Amalie        | Afghanistan |
| Renie         | Lizzie        | Afghanistan |
| Renie         | Morganica     | Afghanistan |
| Renie         | Sarette       | Afghanistan |
| Robinia       | Chere         | India       |
| Robinia       | Esmeralda     | India       |
| Robinia       | Gianina       | India       |
| Robinia       | Lusa          | India       |
| Robinia       | Mahalia       | India       |
| Robinia       | Marinna       | India       |
| Robinia       | Nelle         | India       |
| Sarette       | Amalie        | Afghanistan |
| Sarette       | Lizzie        | Afghanistan |
| Sarette       | Morganica     | Afghanistan |
| Sarette       | Renie         | Afghanistan |
| Tamqrah       | Annecorinne   | USA         |
| Tamqrah       | Claresta      | USA         |
| Tamqrah       | Dorice        | USA         |
| Tamqrah       | Millie        | USA         |
| Tamqrah       | Mureil        | USA         |