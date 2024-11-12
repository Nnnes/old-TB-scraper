SELECT t0."Char", t0."Average", t0."Runs", t1."TB Avg.", t1."TB Runs",
	ROUND(t1."TB Avg." - t0."Average", 2) AS "TB diff",
	ROUND(CAST(t1."TB Runs" AS REAL) / t0."Runs" * 100, 2) AS "TB %" FROM (
	SELECT RTRIM(character, 'B') AS "Char", ROUND(AVG(score), 2) AS "Average", COUNT(*) AS "Runs"
	FROM runs WHERE ultra IS NOT NULL
	GROUP BY "Char") AS t0
JOIN (
	SELECT RTRIM(character, 'B') AS "Char", ROUND(AVG(score), 2) AS "TB Avg.", COUNT(*) AS "TB Runs"
	FROM runs WHERE ultra IS NOT NULL AND (muts >> 5) % 2 == 1
	GROUP BY "Char"
) AS t1 USING ("Char")
ORDER BY "TB diff" DESC