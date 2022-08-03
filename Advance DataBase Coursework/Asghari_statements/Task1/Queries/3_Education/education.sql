

 select childid  from [dbo].[view_Severe_Education_Deprivation_AllCountries]
 group by childid
 having count(*)>1
 --------------------------
select * from [dbo].[view_Severe_Education_Deprivation_AllCountries]

  ---------Percentage of Severe_Education_Deprivation in each country-----------
select country,	male_cnt,	female_cnt,	all_cnt,	male_perc,	female_perc,	all_perc
from dbo.Severe_Education_Deprivation_Percentage
order by all_perc desc