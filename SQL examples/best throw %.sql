SELECT t.id, username, "runs", "L0 throws", "ratio" * 100 || '%' AS "throw %" FROM (
	SELECT id, COUNT(*) AS "runs",
	SUM(loop == 0 AND killedby IS NOT NULL) AS "L0 throws",
	ROUND(CAST(SUM(loop == 0 AND killedby IS NOT NULL) AS REAL) / COUNT(*), 5) AS "ratio"
	FROM runs
	GROUP BY id HAVING "runs" >= 25 AND "ratio" < 0.5
	ORDER BY "ratio"
) AS t LEFT JOIN players ON t.id == players.id