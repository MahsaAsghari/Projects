--Report08--Percent of children severely deprived of basic human needs

select 
a.country_flg
,a.country
,a.all_absolute_dep_perc 'Absolute Poverty(2+ severe deprevation)(%)'
,b.all_severe_dep_perc'Severe Deprived (1+ severe deprivations)(%)'
,c.[all_perc] 'Severe Sanitation Deprivation(%)'
,d.[all_perc]'Severe Water Deprivation (%)'
,e.[all_perc]'Severe Food Deprivation (%)'
,f.[all_perc]'Severe Health Deprivation (%)'
,g.[all_perc]'Severe Education Deprivation (%)'
from [dbo].[Absolute_Deprivation_Percentage] a 
left join  [dbo].[severe_Deprivation_Percentage] b
on a.country_flg=b.country_flg
left join [dbo].[Severe_Sanitation_Deprivation_Percentage]c
on a.country_flg=c.country_flg
left join [dbo].[Severe_Water_Deprivation_Percentage]d
on a.country_flg=d.country_flg
left join[dbo].[Severe_Food_Deprivation_Percentage]e
on a.country_flg=e.country_flg
left join[dbo].[Severe_Health_Deprivation_Percentage]f
on a.country_flg=f.country_flg
left join[dbo].[Severe_Education_Deprivation_Percentage]g
on a.country_flg=g.country_flg