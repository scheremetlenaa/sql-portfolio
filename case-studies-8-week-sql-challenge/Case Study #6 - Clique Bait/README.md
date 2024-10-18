## [Case Study 6 : Clique Bait](https://8weeksqlchallenge.com/case-study-6/)

<p align="center">
<img src="https://8weeksqlchallenge.com/images/case-study-designs/6.png" alt="Image" width="450" height="450">

## Table Of Contents

1. [Introduction](#introduction)
2. [Datasets used](#datasets-used)
3. [Case Study Questions](#case-study-questions)

## Introduction

Clique Bait is not like your regular online seafood store - the founder and CEO Danny, was also a part of a digital data analytics team and wanted to expand his knowledge into the seafood industry!

In this case study - you are required to support Danny’s vision and analyse his dataset and come up with creative solutions to calculate funnel fallout rates for the Clique Bait online store.

## Datasets used

Key datasets for this case study:

- **```Users```**: Customers who visit the Clique Bait website are tagged via their ```cookie_id```.
- **```Events```**: Customer visits are logged in this ```events``` table at a ```cookie_id``` level and the ```event_type``` and ```page_id``` values can be used to join onto relevant satellite tables to obtain further information about each event. The sequence_number is used to order the events within each visit.
- **```Event Identifier```**: shows the types of events which are captured by Clique Bait’s digital data systems.
- **```Campaign Identifier```**: This table shows information for the 3 campaigns that Clique Bait has ran on their website so far in 2020.
- **```Page Hierarchy```**: This table lists all of the pages on the Clique Bait website which are tagged and have data passing through from user interaction events.

## Case Study Questions

**1. Enterprise Relationship Diagram**

Using the following DDL schema details to create an ERD for all the Clique Bait datasets.

[Click here](https://dbdiagram.io/) to access the DB Diagram tool to create the ERD.

**2. Digital Analysis**

Using the available datasets - answer the following questions using a single query for each one:

1. How many users are there?
2. How many cookies does each user have on average?
3. What is the unique number of visits by all users per month?
4. What is the number of events for each event type?
5. What is the percentage of visits which have a purchase event?
6. What is the percentage of visits which view the checkout page but do not have a purchase event?
7. What are the top 3 pages by number of views?
8. What is the number of views and cart adds for each product category?
9. What are the top 3 products by purchases?

**3. Product Funnel Analysis**

Using a single SQL query - create a new output table which has the following details:

- How many times was each product viewed?
- How many times was each product added to cart?
- How many times was each product added to a cart but not purchased (abandoned)?
- How many times was each product purchased?

Additionally, create another table which further aggregates the data for the above points but this time for each product category instead of individual products.

Use your 2 new output tables - answer the following questions:

1. Which product had the most views, cart adds and purchases?
2. Which product was most likely to be abandoned?
3. Which product had the highest view to purchase percentage?
4. What is the average conversion rate from view to cart add?
5. What is the average conversion rate from cart add to purchase?

**4. Campaigns Analysis**

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
