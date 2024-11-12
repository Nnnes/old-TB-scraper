SELECT --'L' || loop || ' ' ||
stage AS "Level",
	ROUND(AVG(score), 2) AS "Avg. Score",
	COUNT(*) AS "Runs" FROM runs
WHERE loop >= 0
GROUP BY "Level"
ORDER BY "Runs" DESC