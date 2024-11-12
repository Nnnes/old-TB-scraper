SELECT pg, riot FROM (SELECT score AS pg, row_number() OVER (ORDER BY score DESC) AS r FROM runs WHERE ultra == 101
ORDER BY score DESC LIMIT 100) AS pg LEFT JOIN
(SELECT score AS riot, row_number() OVER (ORDER BY score DESC) AS r FROM runs WHERE ultra == 102
ORDER BY score DESC LIMIT 100) AS riot ON pg.r == riot.r