/* [dbo].[view_Severe_Water_Deprivation_AllCountries] - children who only had access to surface water
(e.g. rivers) for drinking or who lived in households where 
the nearest source of water was more than 15 minutes away 
(indicators of severe deprivation of water quality or quantity).
*/
--water(HH-all ages)
select distinct  
country_flg
,country
,childid
,yc
,cohort_type
,chsex
,chsex_desc
from [dbo].[view_AllCountries]
where country_flg=1
and drwaterq=0---drwaterq=1=>-Access to safe drinking water
--2133

------------lack of access to safe drinking water-----------------------
select country_flg
,country
,childid
,cohort_type
,chsex_desc
 from  [dbo].[view_Severe_Water_Deprivation_AllCountries]
---------Percentage of Severe_Water_Deprivation in each country-----------

Exec [dbo].[sp_Severe_Water_Deprivation]