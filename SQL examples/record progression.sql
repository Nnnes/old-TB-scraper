SELECT date(jdate) AS "Date", score AS "Record", username AS "Player"
FROM (SELECT jdate, score, id, MAX(score) OVER (ORDER BY jdate) AS pre_max FROM runs) AS t
LEFT JOIN players ON t.id == players.id
WHERE score >= pre_max;