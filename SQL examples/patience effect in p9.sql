SELECT sets."set", t2."count", t2."score" FROM (WITH t("set", "muts") AS
(VALUES ('p9', 146942090), ('p9p', 180496522), ('paw9', 146941978), ('paw9p', 180496410), ('p8', 146811018), ('p8p', 180365450), ('paw8', 146810906), ('paw8p', 180365338))
SELECT * FROM t) AS sets
LEFT JOIN (
SELECT COUNT(*) AS "count", ROUND(AVG(score), 2) AS "score", muts FROM runs
GROUP BY muts
ORDER BY "score" DESC) AS t2 ON t2.muts == sets.muts