use [Asghari_Task1DB]

--************Report01: Severe_Food_Deprivation*****-----
--************Report01: Severe_Food_Deprivation*****-----
--************Report01: Severe_Food_Deprivation*****-----
select 'Report01: Severe_Food_Deprivation'
-------the percentage of children with severe Food Deprivation in each country
Exec [Asghari_Task1DB].[dbo].[sp_Severe_Food_Deprivation]

----------list of children with severe Food deprivation in each country -----------------
/*SELECT distinct [country_flg]
      ,[country]
      ,[childid]
      ,[cohort_type]
      ,[chsex_desc]
  FROM [dbo].[view_Severe_Food_Deprivation_AllCountries]
  */
 ----------**********Report02: severe Education Deprivation************************-----------
 ----------**********Report02: severe Education Deprivation************************-----------
 ----------**********Report02: severe Education Deprivation************************----------- 
 select 'Report02: severe Education Deprivation' 
Exec [Asghari_Task1DB].[dbo].[sp_Severe_Education_Deprivation]

/*----------list of children with severe Education deprivation in each country -----------------
SELECT distinct [country_flg]
      ,[country]
      ,[childid]
      ,[cohort_type]
      ,[chsex_desc]
  FROM [dbo].[view_Severe_Education_Deprivation_AllCountries]--197
  */
------*************Report 03: Severe Water Deprivation******************------------
------*************Report 03: Severe Water Deprivation******************------------
------*************Report 03: Severe Water Deprivation******************------------
------*************Report 03: Severe Water Deprivation******************------------
select 'Report 03: Severe Water Deprivation'

---------Percentage of Severe_Water_Deprivation in each country-----------
Exec [dbo].[sp_Severe_Water_Deprivation]

/*------------lack of access to safe drinking water-----------------------
select country_flg
,country
,childid
,cohort_type
,chsex_desc
 from  [dbo].[view_Severe_Water_Deprivation_AllCountries]
*/
------*************Report 04: Severe Sanitation Deprivation******************------------
------*************Report 04: Severe Sanitation Deprivation******************------------
------*************Report 04: Severe Sanitation Deprivation******************------------
------*************Report 04: Severe Sanitation Deprivation******************------------
select 'Report 04: Severe Sanitation Deprivation'
---------Percentage of Severe_sanitation_Deprivation in each country-----------
Exec [dbo].[sp_Severe_Sanitation_Deprivation]
/*
------------lack of access to Sanitation fasilities-----------------------
select country_flg
,country
,childid
,cohort_type
,chsex_desc
 from  [dbo].[view_Severe_Sanitation_Deprivation_AllCountries]

*/
------*************Report 05: Severe Health Deprivation******************------------
------*************Report 05: Severe Health Deprivation******************------------
------*************Report 05: Severe Health Deprivation******************------------
------*************Report 05: Severe Health Deprivation******************------------
select 'Report 05: Severe Health Deprivation'

---------Percentage of Severe Health Deprivation in each country-----------
Exec [dbo].[sp_Severe_Health_Deprivation]

/*------------list of children with severe health deprivation-----------------------
select country_flg
,country
,childid
,cohort_type
,chsex_desc
 from  [dbo].[view_Severe_Health_Deprivation_AllCountries]*/
------*************Report 06: Severe Deprivation in each country******************------------
------*************Report 06: Severe Deprivation in each country******************------------
------*************Report 06: Severe Deprivation in each country******************------------
------*************Report 06: Severe Deprivation in each country******************------------
select 'Report 06: Severe Deprivation in each country'

-----The number and percentage of severe deprivation in each country can be seen by gender.------------------------

exec [dbo].[sp_Severe_Deprivation]
/*-------list of children with at least one severe deprivation----------
select * from  [dbo].[view_Severe_Deprivations_AllCountries]
*/
------*************Report 07: Absolute poverty(children who suffers from multiple deprivations) in each country******************------------
------*************Report 07: Absolute poverty(children who suffers from multiple deprivations) in each country******************------------
------*************Report 07: Absolute poverty(children who suffers from multiple deprivations) in each country******************------------
------*************Report 07: Absolute poverty(children who suffers from multiple deprivations) in each country******************------------
select 'Report 07: Absolute poverty(children who suffers from multiple deprivations) in each country'
Exec [dbo].[sp_Absolute_Deprivation]


------*************Report 08: Percentage of Absolute and Severe Poverty******************------------

select 'Report08:Percent of Absolute and severe deprivation of basic human needs'

select 
a.country
,a.all_absolute_dep_perc 'Absolute Poverty(2+ severe deprevation)(%)'
,b.all_severe_dep_perc'Severe Poverty (1+ severe deprivations)(%)'
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
order by all_absolute_dep_perc desc,all_severe_dep_perc desc

------*************Report 09: Percent of severely deprived Children******************------------
exec [dbo].[sp_Severe_Deprivation_Total]






  