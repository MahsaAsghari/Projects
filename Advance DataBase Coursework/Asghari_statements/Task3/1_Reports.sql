use [Asghari_Task3DB]

select * from [dbo].[Greater_Manchester_Street_LSOA]
---------Summarized Reports------------------
----------Rep01 Crime_level  of crime-----------
select * from dbo.view_LSOAcode_Frequency
order by Crime_level desc, PerCapita desc,city
---------Age group----------
select Crime_level,min(Age_Group) min_MedianAge,max(Age_Group)max_MedianAge from dbo.view_LSOAcode_Frequency
group by Crime_level
order by Crime_level desc
---------------------
select city
,a.[LSOA code]
,a.[LSOA name]
,Persons
,MedianAge
,crime_cnt
, PerCapita
,Crime_level
,Age_Group
from dbo.view_LSOAcode_Frequency a
where city='Salford'
order by Crime_level desc









