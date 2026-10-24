SELECT 'customers' AS table_n, COUNT(*) AS row_count FROM customers
UNION ALL
SELECT 'stores', COUNT(*) FROM stores
UNION ALL
SELECT 'products', COUNT(*) FROM products
UNION ALL
SELECT 'exchange_rates', COUNT(*) FROM exchange_rates
UNION ALL
SELECT 'sales', COUNT(*) FROM sales;

--

SELECT
    SUM(line_revenue_usd) - SUM(line_cost_usd) AS line_profit_usd,
    P.category AS category
FROM
    vw_sales
LEFT JOIN
    vw_products AS P
    ON vw_sales.product_key = P.product_key
GROUP BY
    P.category
ORDER BY
    line_profit_usd DESC
LIMIT
    5;
