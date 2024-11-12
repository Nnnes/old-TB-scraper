SELECT SUM(score), username FROM
(SELECT score, id FROM runs WHERE id >= 268400 AND id <= 324338) AS t
LEFT JOIN players ON t.id == players.id GROUP BY t.id ORDER BY SUM(score) DESC