SELECT username, t.* FROM (
SELECT COUNT(DISTINCT killedby) AS "Death Causes", id FROM runs
GROUP BY id
HAVING "Death Causes" >= 60
) AS t
LEFT JOIN players ON t.id == players.id
ORDER BY "Death Causes" DESC, LOWER(username)