CREATE EXTENSION IF NOT EXISTS pg_stat_statements;

-- View Query Statistics
SELECT query, calls, total_time, min_time, max_time, mean_time
FROM pg_stat_statements
ORDER BY total_time DESC
LIMIT 10;
