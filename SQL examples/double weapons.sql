-- SELECT username, * FROM (
-- SELECT date(jdate), * FROM runs WHERE weapons > 0 AND weapons / 1000 == weapons % 1000
-- ORDER BY score DESC) AS t
-- LEFT JOIN players ON t.id == players.id

SELECT weapons, COUNT(*) FROM runs
WHERE weapons > 0 AND weapons / 1000 == weapons % 1000 AND ultra IS NOT NULL
GROUP BY weapons
ORDER BY COUNT(*) DESC