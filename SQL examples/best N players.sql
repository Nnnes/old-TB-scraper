SELECT username, t.id, "total" FROM (
SELECT SUM(score) AS "total", id FROM runs
GROUP BY id
) AS t JOIN players USING (id)
WHERE substr(username, 1, 1) LIKE 'N'
ORDER BY "total" DESC LIMIT 100