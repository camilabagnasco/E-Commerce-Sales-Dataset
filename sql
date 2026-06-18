/* =====================================================
AMAZON FASHION SALES ANALYSIS
Author: Camila Bagnasco

Objective:
Analyze sales performance, product demand, customer
geography, operational efficiency, and promotional
impact using Amazon Fashion sales data.
===================================================== */


/* ===============
EXECUTIVE KPIs
================== */

-- Total Revenue Generated
SELECT
ROUND(SUM(Amount),2) AS Total_Sales
FROM amazon_sales_clean;

-- Total Orders
SELECT
    COUNT(DISTINCT `Order ID`) AS Total_Orders
FROM amazon_sales_clean;

-- Average Order Value (AOV)
SELECT
    ROUND(AVG(Amount),2) AS Average_Order_Value
FROM amazon_sales_clean;

-- Cancellation Rate
  SELECT
    ROUND(
        SUM(
            CASE
                WHEN Status LIKE '%Cancelled%'
                THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS Cancellation_Rate
FROM amazon_sales_clean;


/* ==========================
PRODUCT PERFORMANCE ANALYSIS
============================= */

-- Which product categories generate the most revenue?
SELECT
Category,
ROUND(SUM(Amount), 2) AS Revenue
FROM amazon_sales_clean
GROUP BY Category
ORDER BY Revenue DESC;

-- Which product categories generate the highest order volume?
SELECT
Category,
COUNT(DISTINCT `Order ID`) AS Orders
FROM amazon_sales_clean
GROUP BY Category
ORDER BY Orders DESC;

-- Top 10 Products by Revenue
SELECT
SKU,
ROUND(SUM(Amount), 2) AS Revenue
FROM amazon_sales_clean
GROUP BY SKU
ORDER BY Revenue DESC
LIMIT 10;

/* =======================
GEOGRAPHIC SALES ANALYSIS
========================== */

-- Revenue by State
SELECT
`ship-state`,
ROUND(SUM(Amount), 2) AS Revenue
FROM amazon_sales_clean
GROUP BY `ship-state`
ORDER BY Revenue DESC;

-- Order Volume by State
SELECT
`ship-state`,
COUNT(DISTINCT `Order ID`) AS Orders
FROM amazon_sales_clean
GROUP BY `ship-state`
ORDER BY Orders DESC;

-- Best Performing Categories by State
SELECT
`ship-state`,
Category,
ROUND(SUM(Amount), 2) AS Revenue
FROM amazon_sales_clean
GROUP BY `ship-state`, Category
ORDER BY Revenue DESC;

/* ==================
SALES TREND ANALYSIS
===================== */

-- Revenue by Month
SELECT
Month,
ROUND(SUM(Amount), 2) AS Revenue
FROM amazon_sales_clean
GROUP BY Month
ORDER BY Revenue DESC;

/* ===============================
OPERATIONAL PERFORMANCE ANALYSIS
================================= */

-- Order Distribution by Status
SELECT
Status,
COUNT(*) AS Orders
FROM amazon_sales_clean
GROUP BY Status
ORDER BY Orders DESC;

-- Revenue by Order Status
SELECT
Status,
ROUND(SUM(Amount), 2) AS Revenue
FROM amazon_sales_clean
GROUP BY Status
ORDER BY Revenue DESC;

-- Revenue by Fulfillment Method
SELECT
Fulfilment,
ROUND(SUM(Amount), 2) AS Revenue
FROM amazon_sales_clean
GROUP BY Fulfilment
ORDER BY Revenue DESC;

-- Order Volume by Fulfillment Method
SELECT
Fulfilment,
COUNT(*) AS Orders
FROM amazon_sales_clean
GROUP BY Fulfilment
ORDER BY Orders DESC;

/* =====================================================
PROMOTION EFFECTIVENESS ANALYSIS
===================================================== */

-- Revenue Generated With vs Without Promotions
SELECT
Promotion_Used,
ROUND(SUM(Amount), 2) AS Revenue
FROM amazon_sales_clean
GROUP BY Promotion_Used;

-- Average Order Value With vs Without Promotions
SELECT
Promotion_Used,
ROUND(AVG(Amount), 2) AS Average_Order_Value
FROM amazon_sales_clean
GROUP BY Promotion_Used;
