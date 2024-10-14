## Case Study Questions

Using the following DDL schema details to create an ERD for all the Clique Bait datasets.

[Click here](https://dbdiagram.io/) to access the DB Diagram tool to create the ERD.

```sql
CREATE TABLE clique_bait.event_identifier (
  "event_type" INTEGER,
  "event_name" VARCHAR(13)
);

CREATE TABLE clique_bait.campaign_identifier (
  "campaign_id" INTEGER,
  "products" VARCHAR(3),
  "campaign_name" VARCHAR(33),
  "start_date" TIMESTAMP,
  "end_date" TIMESTAMP
);

CREATE TABLE clique_bait.page_hierarchy (
  "page_id" INTEGER,
  "page_name" VARCHAR(14),
  "product_category" VARCHAR(9),
  "product_id" INTEGER
);

CREATE TABLE clique_bait.users (
  "user_id" INTEGER,
  "cookie_id" VARCHAR(6),
  "start_date" TIMESTAMP
);

CREATE TABLE clique_bait.events (
  "visit_id" VARCHAR(6),
  "cookie_id" VARCHAR(6),
  "page_id" INTEGER,
  "event_type" INTEGER,
  "sequence_number" INTEGER,
  "event_time" TIMESTAMP
);
```

---

## Solutions

---

```sql
// Use DBML to define your database structure
// Docs: https://dbml.dbdiagram.io/docs

Table clique_bait.event_identifier {
  event_type integer
  event_name varchar(13)
}

Table clique_bait.campaign_identifier {
  campaign_id integer
  products varchar(3)
  campaign_name varchar(33)
  start_date timestamp
  end_date timestamp
}

Table clique_bait.page_hierarchy {
  page_id integer
  page_name varchar(14)
  product_category varchar(9)
  product_id integer
}

Table clique_bait.users {
  user_id integer
  cookie_id varchar(6)
  start_date timestamp
}

Table clique_bait.events {
  visit_id varchar(6)
  cookie_id varchar(6)
  page_id integer
  event_type integer
  sequence_number integer
  event_time timestamp
}

Ref: clique_bait.event_identifier.event_type > clique_bait.events.event_type

Ref: clique_bait.page_hierarchy.page_id > clique_bait.events.page_id

Ref: clique_bait.users.cookie_id > clique_bait.events.cookie_id
```

![image](https://github.com/user-attachments/assets/0ee74e2f-957a-40fd-8fe7-0a755f05cb63)
