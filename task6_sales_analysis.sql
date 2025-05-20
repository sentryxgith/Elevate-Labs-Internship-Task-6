
-- 1️⃣ Extract year and month from order_date
SELECT 
    order_id,
    order_date,
    EXTRACT(YEAR FROM order_date) AS year,
    EXTRACT(MONTH FROM order_date) AS month
FROM 
    public."orders"
LIMIT 10;


-- 2️⃣ Calculate monthly revenue from payments
SELECT 
    EXTRACT(YEAR FROM o.order_date) AS year,
    EXTRACT(MONTH FROM o.order_date) AS month,
    SUM(p.amount) AS monthly_revenue
FROM 
    public."orders" o
JOIN 
    public."payment" p ON o.order_id = p.order_id
GROUP BY 
    year, month
ORDER BY 
    year, month;


-- 3️⃣ Monthly order volume
SELECT 
    EXTRACT(YEAR FROM order_date) AS year,
    EXTRACT(MONTH FROM order_date) AS month,
    COUNT(DISTINCT order_id) AS monthly_order_volume
FROM 
    public."orders"
GROUP BY 
    year, month
ORDER BY 
    year, month;


-- 4️⃣ Combine monthly revenue and order volume
SELECT 
    EXTRACT(YEAR FROM o.order_date) AS year,
    EXTRACT(MONTH FROM o.order_date) AS month,
    SUM(p.amount) AS total_revenue,
    COUNT(DISTINCT o.order_id) AS total_orders
FROM 
    public."orders" o
JOIN 
    public."payment" p ON o.order_id = p.order_id
GROUP BY 
    year, month
ORDER BY 
    year, month;


-- 5️⃣ Filter only 2024 orders
SELECT 
    EXTRACT(YEAR FROM o.order_date) AS year,
    EXTRACT(MONTH FROM o.order_date) AS month,
    SUM(p.amount) AS revenue_2024,
    COUNT(DISTINCT o.order_id) AS orders_2024
FROM 
    public."orders" o
JOIN 
    public."payment" p ON o.order_id = p.order_id
WHERE 
    EXTRACT(YEAR FROM o.order_date) = 2024
GROUP BY 
    year, month
ORDER BY 
    month;


-- 6️⃣ Top 3 months by revenue
SELECT 
    TO_CHAR(o.order_date, 'YYYY-MM') AS month,
    SUM(p.amount) AS monthly_revenue
FROM 
    public."orders" o
JOIN 
    public."payment" p ON o.order_id = p.order_id
GROUP BY 
    month
ORDER BY 
    monthly_revenue DESC
LIMIT 3;

