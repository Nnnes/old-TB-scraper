SELECT username, t.* FROM (
SELECT id, COUNT(*) AS "Captain Deaths" FROM runs WHERE killedby = 93
GROUP BY id
ORDER BY "Captain Deaths" DESC, id ASC
) AS t JOIN players USING (id)
