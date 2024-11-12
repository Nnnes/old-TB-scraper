SELECT players.username, t.* FROM (
	SELECT date(jdate) AS "date", * FROM runs
	WHERE loop == 0 AND score < 2000 AND stage != '0-0' ORDER BY score DESC LIMIT 100
) AS t LEFT JOIN players ON players.id == t.id