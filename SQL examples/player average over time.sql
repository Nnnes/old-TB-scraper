SELECT date(jdate) AS "Date", score AS "Score",
AVG(score) OVER (ORDER BY jdate) AS "Avg. score"
FROM runs
WHERE id == 136555