SELECT "Loop", "Highest score", "Date", username FROM
(SELECT 'L' || loop AS "Loop", MAX(score) AS "Highest score", date(jdate) AS "Date", id
FROM runs GROUP BY loop) AS t LEFT JOIN players ON t.id == players.id