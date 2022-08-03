
select * from [dbo].[view_Severe_Sanitation_Deprivation_AllCountries]



exec [dbo].[sp_Severe_Sanitation_Deprivation]



select 
country
,male_cnt	
,female_cnt	
,all_cnt	
,male_perc	
,female_perc	
,all_perc
from dbo.Severe_Sanitation_Deprivation_Percentage
order by all_perc desc