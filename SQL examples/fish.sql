SELECT COUNT(*) AS "Runs", SUM(score) AS "Total score", ROUND(AVG(score), 2) AS "Avg. score", username AS "Username", 'https://thronebutt.com/player/' || runs.id AS "URL", DATE(MAX(jdate)) AS "Most recent run"
FROM runs LEFT JOIN players ON runs.id == players.id
WHERE character LIKE 'fish%'
GROUP BY runs.id HAVING "Runs" >= 50
ORDER BY COUNT(*) DESC, SUM(score) DESC