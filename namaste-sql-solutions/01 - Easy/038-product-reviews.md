# [38 - Product Reviews](https://www.namastesql.com/coding-problem/38-product-reviews)

## Table Of Contents
1. [Problem Statement]()
2. [Datasets used]()
3. [Solutions]()
4. [Result set]()

## Problem Statement

Suppose you are a data analyst working for a retail company, and your team is interested in analysing customer feedback to identify trends and patterns in product reviews.

Your task is to write an SQL query to find all product reviews containing the word "excellent" or "amazing" in the review text. However, you want to exclude reviews that contain the word "not" immediately before "excellent" or "amazing". Please note that the words can be in upper or lower case or combination of both. 

Your query should return the review_id,product_id, and review_text for each review meeting the criteria, display the output in ascending order of review_id.

## Datasets used

```product_reviews``` Table:

| COLUMN_NAME | DATA_TYPE    |
| ----------- | ------------ | 
| review_id   | int          |
| product_id  | int          |
| review_text | varchar(40)  |

## Solutions

```sql
SELECT
	review_id,
    product_id,
    review_text
FROM product_reviews
WHERE (LOWER(review_text) LIKE '%excellent%'
OR LOWER(review_text) LIKE '%amazing%')
AND LOWER(review_text) NOT LIKE '%not excellent%'
AND LOWER(review_text) NOT LIKE '%not amazing%';
```

## Result set

| review_id | product_id | review_text                     |
| --------- | ---------- | ------------------------------- |
|         1 |        101 | The product is excellent!       |
|         2 |        102 | This product is Amazing.        |
|         3 |        103 | Not an excellent product.       |
|         4 |        104 | The quality is Excellent.       |
|         5 |        105 | An amazing product!             |
|         6 |        106 | This is not an amazing product. |