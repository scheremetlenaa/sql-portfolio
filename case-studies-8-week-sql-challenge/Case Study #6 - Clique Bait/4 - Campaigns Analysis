## Case Study Questions

Generate a table that has 1 single row for every unique visit_id record and has the following columns:

- ```user_id```
- ```visit_id```
- ```visit_start_time```: the earliest event_time for each visit
- ```page_views```: count of page views for each visit
- ```cart_adds```: count of product cart add events for each visit
- ```purchase```: 1/0 flag if a purchase event exists for each visit
- ```campaign_name```: map the visit to a campaign if the visit_start_time falls between the start_date and end_date
- ```impression```: count of ad impressions for each visit
- ```click```: count of ad clicks for each visit
- (Optional column) ```cart_products```: a comma separated text value with products added to the cart sorted by the order they were added to the cart (hint: use the sequence_number)
Use the subsequent dataset to generate at least 5 insights for the Clique Bait team - bonus: prepare a single A4 infographic that the team can use for their management reporting sessions, be sure to emphasise the most important points from your findings.

---

## Solutions

---

```sql
WITH CTE AS (
SELECT
	user_id,
    visit_id,
    MIN(event_time) AS visit_start_time,
    SUM(CASE WHEN event_name = 'Page View' THEN 1 ELSE 0 END) AS page_views,
    SUM(CASE WHEN event_name = 'Add to Cart' THEN 1 ELSE 0 END) AS cart_adds,
    MAX(CASE WHEN event_name = 'Purchase' THEN 1 ELSE 0 END) AS purchase,
    SUM(CASE WHEN event_name = 'Ad Impression' THEN 1 ELSE 0 END) AS impression,
    SUM(CASE WHEN event_name = 'Ad Click' THEN 1 ELSE 0 END) AS click,
    STRING_AGG(product_id::VARCHAR, ', ' ORDER BY e.sequence_number) AS cart_products
FROM clique_bait.events e
INNER JOIN clique_bait.users u
	USING(cookie_id)
INNER JOIN clique_bait.event_identifier ei
	USING(event_type)
LEFT JOIN clique_bait.page_hierarchy ph
	USING(page_id)
GROUP BY 1, 2
)

SELECT
	  user_id,
    visit_id,
    visit_start_time,
    page_views,
    cart_adds,
    purchase,
    campaign_name,
    impression,
    click,
    cart_products
FROM CTE
LEFT JOIN clique_bait.campaign_identifier ci
	ON visit_start_time BETWEEN start_date AND end_date
```

#### Result set

The result table is truncated.

| user_id | visit_id | visit_start_time         | page_views | cart_adds | purchase | campaign_name                     | impression | click | cart_products                         |
| ------- | -------- | ------------------------ | ---------- | --------- | -------- | --------------------------------- | ---------- | ----- | ------------------------------------- |
| 430     | 977393   | 2020-03-12T15:39:23.266Z | 5          | 0         | 0        | Half Off - Treat Your Shellf(ish) | 0          | 0     | 2, 3, 6                               |
| 358     | 35e091   | 2020-02-17T16:36:04.282Z | 5          | 0         | 0        | Half Off - Treat Your Shellf(ish) | 0          | 0     | 2, 5, 6                               |
| 389     | 15fb7a   | 2020-01-02T05:47:02.872Z | 6          | 1         | 1        | BOGOF - Fishing For Compliments   | 0          | 0     | 3, 3, 4, 7                            |
| 29      | fbfdcb   | 2020-02-16T00:07:08.503Z | 1          | 0         | 0        | Half Off - Treat Your Shellf(ish) | 0          | 0     | null                                  |
| 105     | bf771e   | 2020-02-21T13:53:03.962Z | 7          | 3         | 0        | Half Off - Treat Your Shellf(ish) | 0          | 0     | 1, 1, 2, 2, 4, 8, 8, 9                |
| 270     | 3f50b8   | 2020-02-25T02:56:43.376Z | 9          | 6         | 1        | Half Off - Treat Your Shellf(ish) | 1          | 1     | 1, 1, 3, 3, 4, 6, 6, 7, 7, 8, 8, 9, 9 |

---
