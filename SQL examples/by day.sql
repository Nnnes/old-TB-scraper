SELECT DATE(jdate) AS "Date", COUNT(*) AS "Entries", ROUND(AVG(score), 2) AS "Average score"
FROM runs
GROUP BY jdate;

-- SELECT STRFTIME("%Y-%W", jdate) AS "Date",
-- 	COUNT(*) / 7 AS "Avg. entries / day",
-- 	ROUND(AVG(score), 2) AS "Average score"
-- FROM runs
-- GROUP BY STRFTIME("%Y-%W", jdate);