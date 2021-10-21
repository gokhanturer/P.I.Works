UPDATE A
SET A.daily_vaccinations =
Case when  B.total IS NULL THEN 0
when A.daily_vaccinations IS NULL THEN B.MEDIAN
ELSE A.daily_vaccinations
END FROM	country_vaccination_stats A INNER JOIN
													(
													SELECT country,
														  daily_vaccinations, sum(daily_vaccinations) as total,
														  PERCENTILE_CONT(0.5)
															 WITHIN GROUP (ORDER BY daily_vaccinations) OVER (
															  PARTITION BY country) AS MEDIAN
													FROM  country_vaccination_stats
													group by country,
														  daily_vaccinations
													) B
											ON	A.country = B.country;






