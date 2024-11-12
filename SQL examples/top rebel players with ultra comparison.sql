SELECT t1.username AS "Rebel Player", t1."Total score" AS "Total",
	t1."Avg. score" AS "Avg", t1."Runs" AS "Runs",
	pg.a AS "PG Avg", pg.r AS "PG runs",
	riot.a AS "Riot Avg", riot.r AS "Riot runs" FROM
(SELECT username, t0.* FROM (
	SELECT id, SUM(score) AS "Total score", ROUND(AVG(score), 2) AS "Avg. score",
		COUNT(*) AS "Runs" FROM runs
	WHERE RTRIM(character, 'B') == 'rebel'
	GROUP BY id ORDER BY "Total score" DESC LIMIT 500)
AS t0 LEFT JOIN players ON t0.id == players.id) AS t1 LEFT JOIN
(SELECT ROUND(AVG(score), 2) AS "a", COUNT(*) AS "r", id FROM runs
	WHERE ultra == 101 GROUP BY id
) AS pg ON t1.id == pg.id LEFT JOIN
(SELECT ROUND(AVG(score), 2) AS "a", COUNT(*) AS "r", id FROM runs
	WHERE ultra == 102 GROUP BY id
) AS riot ON t1.id == riot.id