SELECT date(jdate) AS "Date", username AS "Player", score AS "Score",
'L' || loop || ' ' || stage AS "Level", muts,
'https://thronebutt.com/archive/' || STRFTIME('%d%m%Y', jdate) || '/' || CAST((rank - 1) / 30 + 1 AS INT) AS "url"
FROM runs LEFT JOIN players ON runs.id == players.id WHERE
muts == 146942090 OR muts == 180496522 OR -- p9
muts == 146941978 OR muts == 180496410 OR -- paw9
muts == 146811018 OR muts == 180365450 OR -- p8
muts == 146810906 OR muts == 180365338    -- paw8
ORDER BY jdate