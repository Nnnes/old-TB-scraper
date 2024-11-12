SELECT username, t.* FROM (
	SELECT date(jdate), * FROM runs WHERE
-- 		rtrim(character, 'B') != "chicken" AND
		(muts >> 14) % 2 == 1 AND
		killedby IN (55, 56, 61, 62, 63, 64, 65, 66, 67, 68, 69, 72, 81, 87, 99, 102, 104)
-- 	ORDER BY score DESC
) AS t
LEFT JOIN players ON t.id == players.id
