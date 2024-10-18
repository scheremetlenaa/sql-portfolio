## Case Study Questions

**High Level Sales Analysis**

1. What was the total quantity sold for all products?
2. What is the total generated revenue for all products before discounts?
3. What was the total discount amount for all products?

---

## Solutions

---

### 1. What was the total quantity sold for all products?

```sql
SELECT
	product_name,
	SUM(qty) AS total_quantity
FROM balanced_tree.sales s
INNER JOIN balanced_tree.product_details pd
	ON s.prod_id = pd.product_id
GROUP BY 1
ORDER BY 1;
```

#### Result set

| product_name                     | total_quantity |
| -------------------------------- | -------------- |
| Black Straight Jeans - Womens    | 3786           |
| Blue Polo Shirt - Mens           | 3819           |
| Cream Relaxed Jeans - Womens     | 3707           |
| Grey Fashion Jacket - Womens     | 3876           |
| Indigo Rain Jacket - Womens      | 3757           |
| Khaki Suit Jacket - Womens       | 3752           |
| Navy Oversized Jeans - Womens    | 3856           |
| Navy Solid Socks - Mens          | 3792           |
| Pink Fluro Polkadot Socks - Mens | 3770           |
| Teal Button Up Shirt - Mens      | 3646           |
| White Striped Socks - Mens       | 3655           |
| White Tee Shirt - Mens           | 3800           |

---

### 2. What is the total generated revenue for all products before discounts?

```sql
SELECT
	product_name,
	SUM(qty) * SUM(s.price) AS total_revenue
FROM balanced_tree.sales s
INNER JOIN balanced_tree.product_details pd
	ON s.prod_id = pd.product_id
GROUP BY 1
ORDER BY 1;
```

#### Result set

| product_name                     | total_revenue |
| -------------------------------- | ------------- |
| Black Straight Jeans - Womens    | 150955392     |
| Blue Polo Shirt - Mens           | 276022044     |
| Cream Relaxed Jeans - Womens     | 46078010      |
| Grey Fashion Jacket - Womens     | 266862600     |
| Indigo Rain Jacket - Womens      | 89228750      |
| Khaki Suit Jacket - Womens       | 107611112     |
| Navy Oversized Jeans - Womens    | 63863072      |
| Navy Solid Socks - Mens          | 174871872     |
| Pink Fluro Polkadot Socks - Mens | 137537140     |
| Teal Button Up Shirt - Mens      | 45283320      |
| White Striped Socks - Mens       | 77233805      |
| White Tee Shirt - Mens           | 192736000     |

---

### 3. What was the total discount amount for all products?

```sql
SELECT
	product_name,
	SUM(qty * s.price * discount / 100) AS total_discount
FROM balanced_tree.sales s
INNER JOIN balanced_tree.product_details pd
	ON s.prod_id = pd.product_id
GROUP BY 1
ORDER BY 1;
```

#### Result set

| product_name                     | total_discount |
| -------------------------------- | -------------- |
| Black Straight Jeans - Womens    | 14156          |
| Blue Polo Shirt - Mens           | 26189          |
| Cream Relaxed Jeans - Womens     | 3979           |
| Grey Fashion Jacket - Womens     | 24781          |
| Indigo Rain Jacket - Womens      | 8010           |
| Khaki Suit Jacket - Womens       | 9660           |
| Navy Oversized Jeans - Womens    | 5538           |
| Navy Solid Socks - Mens          | 16059          |
| Pink Fluro Polkadot Socks - Mens | 12344          |
| Teal Button Up Shirt - Mens      | 3925           |
| White Striped Socks - Mens       | 6877           |
| White Tee Shirt - Mens           | 17968          |

---
