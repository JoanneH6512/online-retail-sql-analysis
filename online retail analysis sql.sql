-- 1. Check the size of the data
SELECT COUNT(*) AS total_rows
FROM online_retail;

-- 2. View table structure and column data types
DESCRIBE online_retail;

-- 3. Preview a few rows to understand the data
SELECT *
FROM online_retail
LIMIT 10;

-- 4. Check for missing values in key columns
SELECT
  SUM(CASE WHEN CustomerID IS NULL THEN 1 ELSE 0 END) AS missing_customer_id,
  SUM(CASE WHEN Description IS NULL THEN 1 ELSE 0 END) AS missing_description,
  SUM(CASE WHEN Country IS NULL THEN 1 ELSE 0 END) AS missing_country
FROM online_retail;

-- Data cleaning (create a cleaned view)
CREATE VIEW retail_clean AS
SELECT
    InvoiceNo,
    StockCode,
    Description,
    Quantity,
    UnitPrice,
    CustomerID,
    Country,
    DATE(InvoiceDate) AS invoice_date,
    Quantity * UnitPrice AS revenue
FROM online_retail
WHERE Quantity > 0
  AND UnitPrice > 0;
  
  -- Verify the cleaned view
  SELECT *
  FROM retail_clean
  LIMIT 10;
  
  -- 5. Calucate total revenue
  SELECT
    ROUND(SUM(revenue), 2) AS total_revenue
FROM retail_clean;

-- 6. Analyze revenue by country
SELECT
    Country,
    ROUND(SUM(revenue), 2) AS revenue
FROM retail_clean
GROUP BY Country
ORDER BY revenue DESC
LIMIT 10;

-- 7. Identify top-seling products by quantity
SELECT
    Description,
    SUM(Quantity) AS total_units_sold
FROM retail_clean
GROUP BY Description
ORDER BY total_units_sold DESC
LIMIT 10;

-- 8. Analyze monthly revenue trends
SELECT
    DATE_FORMAT(invoice_date, '%Y-%m') AS month,
    ROUND(SUM(revenue), 2) AS monthly_revenue
FROM retail_clean
GROUP BY month
ORDER BY month;











