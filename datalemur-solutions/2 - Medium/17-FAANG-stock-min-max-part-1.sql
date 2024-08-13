-- For each FAANG stock, display the ticker symbol, the month and year ('Mon-YYYY') with the corresponding highest and lowest open prices. 
-- Ensure that the results are sorted by ticker symbol.

WITH highest_prices AS (
  SELECT
    ticker,
    TO_CHAR(date, 'Mon-YYYY') AS highest_mth,
    MAX(open) AS highest_open,
    ROW_NUMBER() OVER (PARTITION BY ticker
                      ORDER BY open DESC) AS row_num
  FROM stock_prices
  GROUP BY ticker, TO_CHAR(date, 'Mon-YYYY'), open
),
lowest_prices AS (
  SELECT
    ticker,
    TO_CHAR(date, 'Mon-YYYY') AS lowest_mth,
    MIN(open) AS lowest_open,
    ROW_NUMBER() OVER (PARTITION BY ticker
                      ORDER BY open ASC) AS row_num
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