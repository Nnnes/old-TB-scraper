SELECT SUM("pages") FROM (
	SELECT (COUNT(*) - 1) / 30 + 1 AS "pages" FROM runs
	GROUP BY jdate
)