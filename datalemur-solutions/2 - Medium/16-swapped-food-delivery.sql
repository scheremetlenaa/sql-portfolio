-- Recently, Zomato encountered an issue with their delivery system. 
-- Due to an error in the delivery driver instructions, each item's order was swapped with the item in the subsequent row. 
-- As a data analyst, you're asked to correct this swapping error and return the proper pairing of order ID and item.

SELECT
  CASE
    WHEN order_id % 2 != 0 AND order_id != total_orders THEN order_id + 1
    WHEN order_id % 2 != 0 AND order_id = total_orders THEN order_id
    ELSE order_id - 1
  END AS corrected_order_id,
  item
FROM orders
CROSS JOIN (SELECT COUNT(*) AS total_orders FROM orders) total_orders
ORDER BY corrected_order_id;