SELECT date(jdate) AS "Date", MAX(score) AS "Score",
'L' || loop || ' ' || stage AS "Area", RTRIM(character, 'B') AS "Char", id
FROM runs GROUP BY jdate HAVING "Char" = 'robot'