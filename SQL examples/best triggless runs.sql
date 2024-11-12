SELECT username, t.* FROM (
SELECT date(jdate) AS "date", * FROM runs
WHERE ultra IS NOT NULL AND (muts >> 23) % 2 == 0 AND RTRIM(character, 'B') != 'chicken'
ORDER BY score DESC LIMIT 100) AS t
LEFT JOIN players ON t.id == players.id