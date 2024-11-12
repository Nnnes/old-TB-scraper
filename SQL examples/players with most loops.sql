SELECT username, t.id, loops, plays, ROUND(CAST(loops AS REAL) / plays, 4) AS "avg." FROM (SELECT SUM(loop) AS loops, id, COUNT(*) AS plays FROM runs GROUP BY id HAVING loops > 0
ORDER BY SUM(loop) DESC LIMIT 100) AS t JOIN players USING (id)
-- ORDER BY "avg." DESC