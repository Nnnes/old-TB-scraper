SELECT date(jdate) AS "date", * FROM runs
WHERE substr(stage, 1, 1) == '3' AND killedby == 12
-- AND RTRIM(character, 'B') == 'frog'
-- AND (weapons / 1000 == 72 OR weapons % 1000 == 72)