# [Maximize Prime Item Inventory [Amazon SQL Interview Question]](https://datalemur.com/questions/prime-warehouse-storage)

## Table Of Contents
1. [Problem Statement](#problem-statement)
2. [Datasets used](#datasets-used)
3. [Solutions](#solutions)
4. [Result set](#result-set)

## Problem Statement

Amazon wants to maximize the storage capacity of its 500,000 square-foot warehouse by prioritizing a specific batch of prime items. The specific prime product batch detailed in the inventory table must be maintained.

So, if the prime product batch specified in the ```item_category``` column included 1 laptop and 1 side table, that would be the base batch. We could not add another laptop without also adding a side table; they come all together as a batch set.

After prioritizing the maximum number of prime batches, any remaining square footage will be utilized to stock non-prime batches, which also come in batch sets and cannot be separated into individual items.

Write a query to find the maximum number of prime and non-prime batches that can be stored in the 500,000 square feet warehouse based on the following criteria:

- Prioritize stocking prime batches
- After accommodating prime items, allocate any remaining space to non-prime batches
Output the ```item_type``` with ```prime_eligible``` first followed by ```not_prime```, along with the maximum number of batches that can be stocked.

Assumptions:

- Again, products must be stocked in batches, so we want to find the largest available quantity of prime batches, and then the largest available quantity of non-prime batches
- Non-prime items must always be available in stock to meet customer demand, so the non-prime item count should never be zero.
- Item count should be whole numbers (integers).

## Datasets used

```inventory``` Table:

|  Column Name  | Type          |
| ------------- | ------------- |
| item_id | integer |
| item_type |	string |
| item_category |	string |
| square_footage |	decimal |

## Solutions

```sql
WITH summary AS (
    SELECT
        item_type,
        COUNT(*) AS item_count,
        SUM(square_footage) AS sum_square_footage
    FROM inventory
    GROUP BY item_type
),
space_for_prime AS (
    SELECT
        item_type,
        sum_square_footage,
        FLOOR(500000/sum_square_footage) AS prime_batch_count,
        FLOOR(500000/sum_square_footage) * item_count AS prime_count
    FROM summary
    WHERE item_type = 'prime_eligible'
)

SELECT
    item_type,
    CASE
        WHEN item_type = 'prime_eligible' 
        THEN FLOOR(500000/sum_square_footage) * item_count
        WHEN item_type = 'not_prime'
        THEN FLOOR((500000 - (SELECT FLOOR(500000/sum_square_footage) * sum_square_footage FROM space_for_prime)) 
            / sum_square_footage) * item_count 
    END AS item_count
FROM summary
ORDER BY item_type DESC;
```

## Result set

| item_type | item_count |
| --------- | ---------- |
| prime_eligible |	5400 |
| not_prime |	8 |