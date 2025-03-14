-- Sales Trends by Daily Sales Volume
SELECT DATE(timestamp) AS transaction_date, COUNT(*) AS total_transactions, SUM(Amount_t) AS total_sales
FROM Transaction
WHERE transaction_status = 'Completed'
GROUP BY transaction_date
ORDER BY transaction_date DESC
LIMIT 30;

-- Sales trends by payment methods
SELECT payment_type, DATE(timestamp) AS transaction_date, SUM(Amount_t) AS total_sales
FROM Transaction
WHERE transaction_status = 'Completed'
GROUP BY payment_type, transaction_date
ORDER BY transaction_date DESC;
