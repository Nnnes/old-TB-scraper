SELECT COUNT(*) AS "Runs", SUM(score) AS "Total score", ROUND(AVG(score), 2) AS "Avg. score", username AS "Username", 'https://thronebutt.com/player/' || runs.id AS "URL", DATE(MAX(jdate)) AS "Most recent run"
FROM runs LEFT JOIN players ON runs.id == players.id
WHERE (muts >> 8) % 2 == 1
GROUP BY runs.id
ORDER BY COUNT(*) DESC LIMIT 500