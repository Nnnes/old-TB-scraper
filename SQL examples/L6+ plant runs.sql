SELECT players.username, t.id, t."L6+ Plant runs" FROM
(SELECT COUNT(*) AS "L6+ Plant runs", id FROM runs
WHERE rtrim(character, 'B') == 'plant' AND loop >= 6
GROUP BY id
ORDER BY "L6+ Plant runs" DESC) AS t LEFT JOIN players ON t.id == players.id