SELECT RTRIM(character, 'B') AS "char", COUNT(*) AS "runs", ROUND(AVG(score), 2) AS "avg. score" FROM runs
WHERE loop == 0 AND stage == '1-1'
GROUP BY "char"
ORDER BY "runs" DESC