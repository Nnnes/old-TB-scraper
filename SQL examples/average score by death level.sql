SELECT 'L' || loop || ' ' || stage AS "Level", ROUND(AVG(score), 2) AS "Avg. Score" FROM runs
WHERE crown == 7
GROUP BY "Level"
ORDER BY "Avg. Score"