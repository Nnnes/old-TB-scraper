SELECT COUNT(*) AS "Wins", ROUND(AVG("Score"), 2) AS "Avg. score", "Char",
MAX("Date") AS "Most recent" FROM (
	SELECT date(jdate) AS "Date", MAX(score) AS "Score",
	'L' || loop || ' ' || stage AS "Area", RTRIM(character, 'B') AS "Char", id
	FROM runs GROUP BY jdate --HAVING "Char" = "robot"
) AS t GROUP BY "Char" ORDER BY "Wins" DESC