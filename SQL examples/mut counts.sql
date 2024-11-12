SELECT mut, COUNT(*) AS "count", AVG("score") FROM
(WITH t("mut", "id") AS (
	VALUES ('Heavy Heart',0),('Rhino Skin',1),('Extra Feet',2),('Plutonium Hunger',3),('Rabbit Paw',4),('Throne Butt',5),('Lucky Shot',6),('Bloodlust',7),('Gamma Guts',8),('Second Stomach',9),('Back Muscle',10),('Scarier Face',11),('Euphoria',12),('Long Arms',13),('Boiling Veins',14),('Shotgun Shoulders',15),('Recycle Gland',16),('Laser Brain',17),('Last Wish',18),('Eagle Eyes',19),('Impact Wrists',20),('Bolt Marrow',21),('Stress',22),('Trigger Fingers',23),('Sharp Teeth',24),('Patience',25),('Hammerhead',26),('Strong Spirit',27),('Open Mind',28)
) SELECT * FROM t) AS lookup
JOIN (SELECT muts, score FROM runs) AS t2
ON (t2.muts >> lookup.id) % 2 = 1
GROUP BY mut
ORDER BY "count" DESC;