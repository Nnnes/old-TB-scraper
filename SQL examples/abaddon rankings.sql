SELECT *, ROUND("C avg." / "o avg.", 2) AS "CRINGSTAL *" FROM (
SELECT id, username,
	"C score", "C plays", ROUND(CAST("C score" AS REAL) / "C plays", 2) AS "C avg.",
	"o score", "o plays", ROUND(CAST("o score" AS REAL) / "o plays", 2) AS "o avg.",
	ROUND("C plays" / (CAST("C plays" AS REAL) + "o plays") * 100, 2) AS "CRINGSTAL %"
	FROM
(SELECT 
	SUM(CASE WHEN character LIKE 'crystal%' THEN score ELSE 0 END) AS "C score",
	SUM(CASE WHEN character LIKE 'crystal%' THEN 1 ELSE 0 END) AS "C plays",
	SUM(CASE WHEN character LIKE 'crystal%' THEN 0 ELSE score END) AS "o score",
	SUM(CASE WHEN character LIKE 'crystal%' THEN 0 ELSE 1 END) AS "o plays",
	username, id FROM
(SELECT * FROM players WHERE username LIKE '%PMC Abaddon')
LEFT JOIN (SELECT * FROM runs WHERE date(jdate) BETWEEN date('now', '-3 months') AND date('now', 'localtime')) USING (id)
GROUP BY id)
ORDER BY "CRINGSTAL %"
)