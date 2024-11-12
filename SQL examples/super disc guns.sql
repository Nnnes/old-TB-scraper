SELECT COUNT(*) AS "Runs", runs.id AS "ID", username AS "Username"
FROM runs LEFT JOIN players ON runs.id == players.id
WHERE weapons % 1000 == 104 OR weapons / 1000 == 104
GROUP BY runs.id
ORDER BY "Runs" DESC, LOWER(username)