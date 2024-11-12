SELECT t."Runs" AS "Runs with SPC+UShovel", username FROM (
SELECT COUNT(*) AS "Runs", id FROM runs WHERE weapons == 92111 OR weapons == 111092
GROUP BY id
) AS t LEFT JOIN players ON t.id == players.id
ORDER BY "Runs" DESC