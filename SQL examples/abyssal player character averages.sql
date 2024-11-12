SELECT /*username, */mutant, "avg. score", "runs" FROM (
SELECT rtrim(character, 'B') AS mutant, id, ROUND(AVG(score), 2) AS "avg. score", COUNT(*) AS "runs" FROM (
SELECT runs.* FROM runs JOIN (SELECT * FROM runs WHERE (loop >= 12 AND loop < 40) GROUP BY id) AS t ON (t.id == runs.id AND runs.jdate >= t.jdate)
)
WHERE NOT (loop == 0 AND stage == '1-1' AND rtrim(character, 'B') == 'rogue')
-- GROUP BY mutant, id ORDER BY mutant, "runs" DESC
GROUP BY mutant ORDER BY "avg. score" DESC
) AS t JOIN players USING (id)