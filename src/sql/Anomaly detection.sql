-- Transactions with Extreme High Amounts
SELECT Transaction_ID, User_ID, Amount_t, timestamp, transaction_status
FROM Transaction
WHERE Amount_t > (SELECT AVG(Amount_t) + 3 * STDDEV(Amount_t) FROM Transaction)
ORDER BY Amount_t DESC;

-- Users with multiple failed transactions
SELECT User_ID, COUNT(*) AS failed_attempts
FROM Transaction
WHERE transaction_status = 'Failed'
GROUP BY User_ID
HAVING COUNT(*) > 5
ORDER BY failed_attempts DESC;

-- High-risk transactions determined by fraud score
SELECT T.Transaction_ID, T.User_ID, T.Amount_t, C.Fraud_Risk_Score
FROM Transaction T
JOIN Compliance C ON T.User_ID = C.User_ID
WHERE C.Fraud_Risk_Score > 80
ORDER BY C.Fraud_Risk_Score DESC;
