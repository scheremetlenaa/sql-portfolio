-- find the mean number of items per order on Alibaba, rounded to 1 decimal place

SELECT
  ROUND(SUM(item_count::DECIMAL * order_occurrences) / SUM(order_occurrences), 1)
FROM items_per_order;