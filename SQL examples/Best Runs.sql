SELECT username, t.* FROM (
SELECT date(jdate) AS "date", * FROM runs
-- WHERE weapons % 1000 == 13 OR weapons / 1000 == 13
ORDER BY score DESC LIMIT 1000
) AS t
LEFT JOIN players ON t.id == players.id