SELECT username, t.* FROM (
SELECT date(jdate) AS "date", * FROM runs
WHERE ultra IS NOT NULL AND loop == 0 AND SUBSTR(stage, 1, 2) != 'HQ' AND SUBSTR(stage, 1, 1) != '7'
ORDER BY score DESC) AS t
LEFT JOIN players ON t.id == players.id