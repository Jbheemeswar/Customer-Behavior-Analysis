-- Show current database
SELECT current_database() AS database_name;

-- List all tables in this database
SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'public';

-- If customer_behavior table exists, show total rows
SELECT COUNT(*) AS total_rows
FROM customer_behavior;

-- Show first 50 rows of data
SELECT *
FROM customer_behavior
LIMIT 50;

-- KPI values
SELECT COUNT(*) AS total_customers FROM customer_behavior;
SELECT AVG(purchase_amount) AS avg_purchase_amount FROM customer_behavior;
SELECT AVG(review_rating) AS avg_review_rating FROM customer_behavior;

-- Revenue by Category
SELECT category,
       SUM(purchase_amount) AS total_revenue
FROM customer_behavior
GROUP BY category
ORDER BY total_revenue DESC;

-- Sales Count by Category
SELECT category,
       COUNT(*) AS total_sales
FROM customer_behavior
GROUP BY category
ORDER BY total_sales DESC;

-- Subscription Status % Report
SELECT subscription_status,
       COUNT(*) AS customer_count,
       ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 2) AS percentage
FROM customer_behavior
GROUP BY subscription_status
ORDER BY customer_count DESC;

-- Revenue by Age
SELECT age,
       SUM(purchase_amount) AS total_revenue
FROM customer_behavior
GROUP BY age
ORDER BY age;

-- Sales Count by Age
SELECT age,
       COUNT(*) AS total_customers
FROM customer_behavior
GROUP BY age
ORDER BY age;

-- Gender Analysis
SELECT gender,
       COUNT(*) AS total_customers,
       SUM(purchase_amount) AS total_revenue
FROM customer_behavior
GROUP BY gender
ORDER BY total_revenue DESC;

-- Shipping Type Analysis
SELECT shipping_type,
       COUNT(*) AS total_orders,
       SUM(purchase_amount) AS total_revenue
FROM customer_behavior
GROUP BY shipping_type
ORDER BY total_revenue DESC;

-- Age Group Summary
SELECT
    CASE
        WHEN age BETWEEN 18 AND 25 THEN 'Young Adult'
        WHEN age BETWEEN 26 AND 35 THEN 'Adult'
        WHEN age BETWEEN 36 AND 50 THEN 'Middle-aged'
        WHEN age > 50 THEN 'Senior'
        ELSE 'Unknown'
    END AS age_group,
    COUNT(*) AS total_customers,
    SUM(purchase_amount) AS total_revenue
FROM customer_behavior
GROUP BY
    CASE
        WHEN age BETWEEN 18 AND 25 THEN 'Young Adult'
        WHEN age BETWEEN 26 AND 35 THEN 'Adult'
        WHEN age BETWEEN 36 AND 50 THEN 'Middle-aged'
        WHEN age > 50 THEN 'Senior'
        ELSE 'Unknown'
    END
ORDER BY total_revenue DESC;
