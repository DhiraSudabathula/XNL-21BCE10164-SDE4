SELECT Vendor_ID, Name, total_revenue, success_rate
FROM Vendor
ORDER BY total_revenue DESC, success_rate DESC
LIMIT 10;
