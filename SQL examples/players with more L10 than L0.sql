SELECT t.id, username, "L10+ runs", "L0 throws", "diff" FROM (
	SELECT id, SUM(loop >= 10) AS "L10+ runs",
	SUM(loop == 0 AND killedby IS NOT NULL) AS "L0 throws",
	SUM(loop >= 10) - SUM(loop == 0 AND killedby IS NOT NULL) AS "diff"
	FROM runs
	GROUP BY id HAVING "diff" > 0
	ORDER BY "diff" DESC
) AS t LEFT JOIN players ON t.id == players.id