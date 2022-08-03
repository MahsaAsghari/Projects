use [Asghari_Task3DB]
--------------Create Tables From crime and LSOA datasets---------------------
-----------Joining LSOA tables------------------
if object_id('[dbo].[Mid_2020_All_Ages]') is not null 
drop table [dbo].[Mid_2020_All_Ages]

SELECT p.[LSOA Code]
      ,p.[LSOA Name]
      ,p.[LA Code (2018 boundaries)]
      ,p.[LA name (2018 boundaries)]
      ,p.[LA Code (2021 boundaries)]
      ,p.[LA name (2021 boundaries)]
      ,p.[All Ages] Persons
      ,m.[All Ages] Males
	  ,f.[All Ages] females
	  ,med.[Median Age][MedianAge]
	  into [Asghari_Task3DB].[dbo].[Mid_2020_All_Ages]
  FROM [Asghari_Task3DB].[dbo].[Mid_2020_Persons] p--34753
  left join [dbo].[Mid_2020_Males] m
  on p.[LSOA Code]=m.[LSOA Code]
  left join [dbo].[Mid_2020_Females] f
  on p.[LSOA Code]=f.[LSOA Code]
  left join [dbo].[Median_Age] med
  on p.[LSOA Code]=med.[LSOA Code]
  --34753
GO

-----------Add [GeoLocation] to Greater_Manchester_Street----------------------------
--*******Reference: Workshop-Week8.pdf. page 18***------
--Add a Primary key column
ALTER TABLE [dbo].[Greater_Manchester_Street]
ADD ID INT IDENTITY;

--Add a Primary key column
ALTER TABLE [dbo].[Greater_Manchester_Street]
ADD CONSTRAINT PK_Id PRIMARY KEY NONCLUSTERED (ID);
GO
--Add a new column where we will store the geography points.
ALTER TABLE [dbo].[Greater_Manchester_Street]
ADD [GeoLocation] GEOGRAPHY
Go
--create a geography POINT using Latitude and Longitude columns
UPDATE [dbo].[Greater_Manchester_Street]
SET [GeoLocation] = geography::Point([Latitude], [Longitude], 4326)
WHERE [Longitude] IS NOT NULL
AND [Latitude] IS NOT NULL
AND cast([Latitude] as decimal(10, 6)) BETWEEN -90 AND 90
AND cast([Longitude] as decimal(10, 6)) BETWEEN -90 AND 90
Go

----------Join Crime dataset and LSOA dataset ------------------
if OBJECT_id ('[dbo].[Greater_Manchester_Street_LSOA]') is not null 
drop table [dbo].[Greater_Manchester_Street_LSOA]
select  
c.Id
,c.Month
,[Longitude]
,[Latitude]
,[GeoLocation]
,[Location]
,c.[LSOA code]
,c.[LSOA name]
,c.[Crime type]
,c.[Last outcome category]
,l.Persons
,l.Males
,l.females
,l.[MedianAge] 
into [dbo].[Greater_Manchester_Street_LSOA]
from[dbo].[Greater_Manchester_Street] c
left join [dbo].[Mid_2020_All_Ages] l
on c.[LSOA code]=l.[LSOA Code]

-------------------------------
select * from [dbo].[Greater_Manchester_Street_LSOA]
order by MedianAge desc
-------------------------------



