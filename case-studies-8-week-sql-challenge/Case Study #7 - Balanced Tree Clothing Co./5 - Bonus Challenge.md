## Case Study Questions

Use a single SQL query to transform the product_hierarchy and product_prices datasets to the product_details table.

---

## Solution

---

```sql
WITH CTE AS (
  SELECT
      ph1.id AS category_id,
      ph2.id AS segment_id,
      ph3.id AS style_id,
      ph1.level_text AS category_name,
      ph2.level_text AS segment_name,
      ph3.level_text AS style_name
  FROM balanced_tree.product_hierarchy ph1
  INNER JOIN balanced_tree.product_hierarchy ph2
      ON ph1.id = ph2.parent_id
  INNER JOIN balanced_tree.product_hierarchy ph3
      ON ph2.id = ph3.parent_id
  ORDER BY ph3.id
)

SELECT
    product_id,
    price,
    CONCAT(style_name, ' ', segment_name, ' - ', category_name) AS product_name,
    category_id,
    segment_id,
    style_id,
    category_name,
    segment_name,
    style_name
FROM CTE
INNER JOIN balanced_tree.product_prices pp
	ON CTE.style_id = pp.id;
```

#### Result set

| product_id | price | product_name                     | category_id | segment_id | style_id | category_name | segment_name | style_name          |
| ---------- | ----- | -------------------------------- | ----------- | ---------- | -------- | ------------- | ------------ | ------------------- |
| c4a632     | 13    | Navy Oversized Jeans - Womens    | 1           | 3          | 7        | Womens        | Jeans        | Navy Oversized      |
| e83aa3     | 32    | Black Straight Jeans - Womens    | 1           | 3          | 8        | Womens        | Jeans        | Black Straight      |
| e31d39     | 10    | Cream Relaxed Jeans - Womens     | 1           | 3          | 9        | Womens        | Jeans        | Cream Relaxed       |
| d5e9a6     | 23    | Khaki Suit Jacket - Womens       | 1           | 4          | 10       | Womens        | Jacket       | Khaki Suit          |
| 72f5d4     | 19    | Indigo Rain Jacket - Womens      | 1           | 4          | 11       | Womens        | Jacket       | Indigo Rain         |
| 9ec847     | 54    | Grey Fashion Jacket - Womens     | 1           | 4          | 12       | Womens        | Jacket       | Grey Fashion        |
| 5d267b     | 40    | White Tee Shirt - Mens           | 2           | 5          | 13       | Mens          | Shirt        | White Tee           |
| c8d436     | 10    | Teal Button Up Shirt - Mens      | 2           | 5          | 14       | Mens          | Shirt        | Teal Button Up      |
| 2a2353     | 57    | Blue Polo Shirt - Mens           | 2           | 5          | 15       | Mens          | Shirt        | Blue Polo           |
| f084eb     | 36    | Navy Solid Socks - Mens          | 2           | 6          | 16       | Mens          | Socks        | Navy Solid          |
| b9a74d     | 17    | White Striped Socks - Mens       | 2           | 6          | 17       | Mens          | Socks        | White Striped       |
| 2feb6b     | 29    | Pink Fluro Polkadot Socks - Mens | 2           | 6          | 18       | Mens          | Socks        | Pink Fluro Polkadot |

---
