# [FAANG Stock Min-Max (Part 1) [Bloomberg SQL Interview Question]](https://datalemur.com/questions/sql-bloomberg-stock-min-max-1)

## Table Of Contents
1. [Problem Statement](#problem-statement)
2. [Datasets used](#datasets-used)
3. [Solutions](#solutions)
4. [Result set](#result-set)

## Problem Statement

The Bloomberg terminal is the go-to resource for financial professionals, offering convenient access to a wide array of financial datasets. As a Data Analyst at Bloomberg, you have access to historical data on stock performance.

Currently, you're analyzing the highest and lowest open prices for each FAANG stock by month over the years.

For each FAANG stock, display the ticker symbol, the month and year ('Mon-YYYY') with the corresponding highest and lowest open prices (refer to the Example Output format). Ensure that the results are sorted by ticker symbol.

## Datasets used

```stock_prices``` Table:

|  Column Name  | Type          | Description |
| ------------- | ------------- | ----------- |
| date	| datetime |	The specified date (mm/dd/yyyy) of the stock data. |
| ticker |	varchar |	The stock ticker symbol (e.g., AAPL) for the corresponding company. |
| open |	decimal |	The opening price of the stock at the start of the trading day. |
| high |	decimal |	The highest price reached by the stock during the trading day. |
| low |	decimal |	The lowest price reached by the stock during the trading day. |
| close |	decimal |	The closing price of the stock at the end of the trading day. |

## Solutions

```sql
WITH highest_prices AS (
    SELECT
        ticker,
        TO_CHAR(date, 'Mon-YYYY') AS highest_mth,
        MAX(open) AS highest_open,
        ROW_NUMBER() OVER (PARTITION BY ticker ORDER BY open DESC) AS row_num
    FROM stock_prices
    GROUP BY ticker, TO_CHAR(date, 'Mon-YYYY'), open
),
lowest_prices AS (
    SELECT
        ticker,
        TO_CHAR(date, 'Mon-YYYY') AS lowest_mth,
        MIN(open) AS lowest_open,
        ROW_NUMBER() OVER (PARTITION BY ticker ORDER BY open ASC) AS row_num
    FROM stock_prices
    GROUP BY ticker, TO_CHAR(date, 'Mon-YYYY'), open
)

SELECT
    highest_prices.ticker,
    highest_prices.highest_mth,
    highest_prices.highest_open,
    lowest_prices.lowest_mth,
    lowest_prices.lowest_open
FROM highest_prices
INNER JOIN lowest_prices
    ON highest_prices.ticker = lowest_prices.ticker
    AND highest_prices.row_num = 1
    AND lowest_prices.row_num = 1
ORDER BY highest_prices.ticker;
```

## Result set

| ticker | highest_mth | highest_open | lowest_mth | lowest_open |
| ------ | ----------- | ------------ | ---------- | ----------- |
| AAPL   | Jul-2023    | 195.26       | Apr-2020   | 61.63       |
| AMZN   | Dec-2021    | 177.25       | Jan-2023   | 85.46       |
| GOOG   | Nov-2021    | 148.16       | Apr-2020   | 56.10       |
| META   | Sep-2021    | 379.59       | Nov-2022   | 94.33       |
| MSFT   | Jul-2023    | 339.19       | Apr-2020   | 153.00      |
| NFLX   | Nov-2021    | 689.06       | Jul-2022   | 176.49      |