-- SELECT name AS "crown", * FROM (
	SELECT username, t.* FROM (
		SELECT date(jdate) AS "date", *, MAX(score) FROM runs
		GROUP BY crown
		ORDER BY MAX(score) DESC
	) AS t
	JOIN players USING (id)
-- ) AS t2
-- JOIN (
-- 	WITH c(crown, name) AS (
-- 		VALUES (NULL,'None'),(2,'Death'),(3,'Life'),(4,'Haste'),(5,'Guns'),(6,'Hatred'),(7,'Blood'),(8,'Destiny'),(9,'Love'),(10,'Luck'),(11,'Curses'),(12,'Risk'),(13,'Protection')
-- 	) SELECT * FROM c
-- ) AS c USING (crown)