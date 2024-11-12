SELECT date(jdate) AS "Date", rank AS "Rank", username AS "Username", character AS "Char",
'L' || loop || ' ' || stage AS "Level", score AS "Score"
FROM runs LEFT JOIN players ON runs.id == players.id
WHERE runs.id == (SELECT id FROM players WHERE username LIKE 'Nnnes');