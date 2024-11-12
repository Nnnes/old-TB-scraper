SELECT rtrim(character, 'B') AS "Char", ROUND(AVG(score), 2) FROM runs
WHERE (muts >> 5) % 2 = 1 AND ultra IS NOT NULL
GROUP BY "Char"
ORDER BY AVG(score) DESC