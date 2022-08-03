alter view [dbo].[view_Ethiopia]
as
/*
Nutrition (0–4)
Water (HH – all ages)
Sanitation (HH– all ages )
Shelter (HH– all ages)
Health (0–4)	
Education (6–17)
Information (HH– all ages)*/
--select count(*) from [Asghari_Task1DB].[dbo].[Ethiopia_constructed]--14995

select 1 country_flg ,
'Ethiopia' country,
[childid]
,[yc]
,case 
when [yc]=0 then'Older cohort'
when [yc]=1 then'Younger cohort'
else 'unknown'
end [cohort_type]
,[round]
,[inround]
,case 
when [inround]=0 then'no'
when [inround]=1 then'yes'
else 'unknown'
end [inround_desc]
,[panel12345]
,[deceased]
,case
when [deceased]=1 then 'yes'
else [deceased]
end [deceased_desc]
--,[dint]
--,[commid]
--,[clustid]
--,[region]
,[typesite]
,case when [typesite]=1 then 'urban'
when [typesite]=2 then 'rural'
else 'unknown'
end [typesite_desc]
--,[childloc]
/*Child’s general characteristics variables*/
,[chsex]
,case
when [chsex]=1 then 'male'
when [chsex]=2 then 'female'
else 'unknown'
end [chsex_desc]
,[agemon]--Child's age – in months
--,cast(cast([agemon] as decimal(38,2))/12 as decimal(38,2)) age
,[dbo].[Convert_agemon]([agemon])age--user defined function to convert age in month to age  in year

/*Child’s anthropometric information variables*/
--,[chweight]
--,[chheight]
---- ,case when cast([chheight]as float)<>0 then (cast([chweight] as float) /(cast([chheight]as float)/100*cast([chheight]as float)/100))end [bmi_]
--,[bmi]
--,[zwfa]--[weight-for-age z-score]
--,[zhfa]--height-for-age z-score
--,[zbfa]--BMI-for-age z-score
--,[zwfl]--weight-for-length/height z-score
--,[fwfa] --flag = 1 if (zwfa < -6 | zwfa >5)
--,[fhfa] --flag = 1 if (zhfa < -6 | zhfa >6)
--,[fbfa] --flag = 1 if (zbfa < -5 | zbfa >5)
--,[fwfl] --flag = 1 if (zwfl < -5 | zwfl >5)
,[underweight]--low weight for age
,[stunting]--short height for age
,[thinness]--low BMI for age
,case when [underweight] = 0 then 'not'
when [underweight] =1 then 'moderate'
when [underweight]=2 then 'severe'
else ''
end [underweight_desc]

,case when [stunting] = 0 then'not'
when [stunting] =1 then'moderate'
when [stunting]=2 then'severe'
else ''
end [stunting_desc]

,case when [thinness] = 0 then'not'
when [thinness] =1 then'moderate'
when [thinness]=2 then'severe'
else ''
end [thinness_desc]

	  ------Water Deprivation----------
	  ,drwaterq_new
	  --,case when drwaterq_new=0 then 'yes'
	  --when drwaterq_new=1 then 'no'
	  --end drwaterq_new_desc
	  ------Sanitation Facilities-----
	  ,e.toiletq_new
	  --,case when toiletq_new=0 then 'yes'
	  --when toiletq_new=1 then 'no'
	  --end toiletq_new_desc
	  ,childloc
	  --,case when childloc=0 then 'yes'
	  --when childloc=1 then 'no'
	  --end childloc_desc
	 -- ,ownhouse

/*-------------------Birth and immunisation variables*/
/*-------------------Birth and immunisation variables*/
/*-------------------Birth and immunisation variables*/
/*-------------------Birth and immunisation variables*/

,bcg	
,measles
,dpt
,polio
,hib
/*-------------------Child’s health and well-being------------------*/
/*-------------------Child’s health and well-being------------------*/
/*-------------------Child’s health and well-being------------------*/
/*-------------------Child’s health and well-being------------------*/

,chmightdie --Child has had serious injury/illness since last round when caregiver thought child might die
,chillness --Child has had serious illness since last round
,chinjury --Child has had serious injury since last round
,chhprob --Child has long-term health problem
,chdisability --Child has a permanent disability
,chdisscale --Permanent disability scale
/*chdisscale,
Value = 0.0	Label = Able to work same as others of this age
	Value = 1.0	Label = Capable of most types of full-time work but some difficulty with physical work
	Value = 2.0	Label = Able to work full-time but only work requiring no physical activity
	Value = 3.0	Label = Can only do light work on a part-time basis
	Value = 4.0	Label = Cannot work but able to care for themselves (e.g. dress themselves, etc.)
	Value = 5.0	Label = Cannot work and needs help with daily activities such as dressing, washing, etc.
	Value = 6.0	Label = Other

*/
 chhrel--Child's health compared to peers
 /*
 Value = 1.0	Label = Same
	Value = 2.0	Label = Better
	Value = 3.0	Label = Worse
*/
,chhealth--Child's health in general
/*
Value = 1.0	Label = very poor
	Value = 2.0	Label = poor
	Value = 3.0	Label = average
	Value = 4.0	Label = good
	Value = 5.0	Label = very good
*/
,cladder  -- Child's subjective well-being (nine-step ladder)
/*9 represents the ‘best
possible life’ and 1 ‘the worst possible life’*/

/*-----------------------Smoking and drinking habits and reproductive health knowledge variables*/
/*-----------------------Smoking and drinking habits and reproductive health knowledge variables*/
/*-----------------------Smoking and drinking habits and reproductive health knowledge variables*/
/*-----------------------Smoking and drinking habits and reproductive health knowledge variables*/

,chsmoke --Child's frequency of smoking
,chalcohol --Child consumes alcohol every day or at least once a week
,chrephealth1 --Child's knowledge of reproductive health
,chrephealth2 --Child knows condom can prevent disease through sex
,chrephealth3 --Child knows healthy-looking person can pass on a disease through sex
,chrephealth4 --Child's source of condom
/*-----------------------Education and skills------------*/
/*-----------------------Education and skills------------*/
/*-----------------------Education and skills------------*/
/*-----------------------Education and skills------------*/
,preprim --Child has attended pre-primary school
,agegr1 --Age at start of Grade 1
,enrol --Enrolled in formal school during survey year
,engrade --Grade enrolled during survey year
,entype --Type of school enrolled during survey year
,hghgrade --Highest grade completed at time of interview
,timesch --Travel time to school (in minutes)
,levlread --Child's reading level
/*
Value = 1.0	Label = can't read anything
	Value = 2.0	Label = reads letters
	Value = 3.0	Label = reads word
	Value = 4.0	Label = reads sentence
*/
,levlwrit --Child's writing level
/*
Value = 1.0	Label = no
Value = 2.0	Label = yes with difficulty or errors
Value = 3.0	Label = yes without difficulty or errors
*/
,literate --Child can read and write a sentence without difficulty
from [Asghari_Task1DB].[dbo].[Ethiopia_constructed] e
--where deceased <>1--child has not died
--and inround<>0--14156