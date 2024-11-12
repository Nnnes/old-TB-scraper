SELECT jdate - prev AS "Days since previous", date(jdate) AS "Date", jdate FROM (
SELECT LAG(jdate) OVER (ORDER BY jdate) AS prev, jdate FROM runs WHERE id = 74567
) WHERE "Days since previous" > 1