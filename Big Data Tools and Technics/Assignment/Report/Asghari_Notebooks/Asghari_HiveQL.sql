-- Databricks notebook source
-- MAGIC %md
-- MAGIC ##Hive tables create in Asghari_DataLoading.ipynb.
-- MAGIC ##Please make sure Asghari_DataLoading.ipynb has been executed before running this notebook.

-- COMMAND ----------

--The year of clinicaltrial file
set Year=2021

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ####1.The number of studies in the dataset. You must ensure that you explicitly check distinct studies.

-- COMMAND ----------

--The number of unique studies in the clinicaltrial table
select count(distinct id) Frequency from  clinicaltrial


-- COMMAND ----------

-- MAGIC %md
-- MAGIC ####Discussion of result (Question 1)

-- COMMAND ----------

--The count of records based on different columns
select 'id' column_name, count(id) cnt from clinicaltrial
union all
select 'Sponsor',count(Sponsor) from clinicaltrial
union all
select 'Status' , count(Status) from clinicaltrial
union all
select 'Start' , count(Start) from clinicaltrial
union all
select 'Type' , count(Type) from clinicaltrial
union all
select 'Submission' , count(Submission) from clinicaltrial
union all
select 'Completion' , count(Completion) from clinicaltrial
union all
select 'Conditions', count(Conditions) from clinicaltrial
union all
select 'Interventions', count(Interventions) from clinicaltrial

-- COMMAND ----------

-- MAGIC %md 
-- MAGIC #### 2.You should list all the types (as contained in the Type column) of studies in the dataset along with the frequencies of each type. These should be ordered from most frequent to least frequent.

-- COMMAND ----------

--The frequency of each study type
select type, count(*) cnt from clinicaltrial
group by type 
order by cnt desc;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ####Discussion of result (Question 2)

-- COMMAND ----------

--Discussion of result Question 2:
--Completed Interventional Studies without any Interventions.
select right(Completion,4) Year, Count(*) cnt from clinicaltrial
where type like "Interventional"-- Interventional Studies
and Status ="Completed"--Completed Studies
and Interventions is null-- without any Interventions
group by Year
order by cnt desc
limit (5)


-- COMMAND ----------

--The frequency of completed studied bu study type
select type, count(*) cnt from clinicaltrial
where status="Completed"
group by type 
order by cnt desc;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ####3.The top 5 conditions (from Conditions) with their frequencies.

-- COMMAND ----------

--Creating a view in which each record has a condition 
--Split function splits create a list of conditions 
--Explode function spreads list of conditions into differrent rows(like flatMap in RDD)

CREATE OR REPLACE TEMP VIEW VW_exploded_conditions AS 
SELECT Id,Sponsor,
Status,
Start,
Completion,
Type,
Submission, 
explode(split(conditions , ',')) as conditions ,
Interventions 
FROM clinicaltrial


-- COMMAND ----------

--Frequency of top 5 conditions
select  conditions ,count(*) frequency from VW_exploded_conditions
group by conditions
order by frequency desc
limit(5)

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ####Discussion of result (Question 3)

-- COMMAND ----------

--Discussion of result
--The number of distinct studies is 322130 while the number of studies in dataset is 387261.
select count(distinct(id)) from VW_exploded_conditions

-- COMMAND ----------

select count(*) from clinicaltrial
where conditions is null

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ####4.Each condition can be mapped to one or more hierarchy codes. The client wishes to know the 5 most frequent roots (i.e. the sequence of letters and numbers before the first full stop) after this is done.

-- COMMAND ----------

--Creating a view to extract root from tree column
CREATE OR REPLACE TEMP VIEW VW_mesh_root AS 
select term,
left(tree,3) root --extract root of each tree
from mesh

-- COMMAND ----------

select * from VW_mesh_root

-- COMMAND ----------

--Frequency of 10 most frequent roots
--In the past result pdf file, instead of 5 most frequent roots, 10 most frequent roots had been written.
select root, count(*) frequency from VW_exploded_conditions c
inner join VW_mesh_root m
on c.conditions = m.term
group by root
order by frequency desc
limit(10);

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ####Discussion of result (Question 4)

-- COMMAND ----------

--Discission of result(Question 4)
--The root of the 5 most frequent conditions
select  distinct conditions,root from (select Conditions from VW_exploded_conditions
where Conditions in ("Carcinoma","Diabetes Mellitus","Neoplasms","Breast Neoplasms","Syndrome")--the 5 most frequent conditions
)c
left join VW_mesh_root m--root of conditions
on c.Conditions=m.term
order by conditions

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ####5.Find the 10 most common sponsors that are not pharmaceutical companies, along with the number of clinical trials they have sponsored. Hint: For a basic implementation, you can assume that the Parent Company column contains all possible pharmaceutical companies.

-- COMMAND ----------

select c.id,c.Sponsor,p.parent_company   
  from clinicaltrial c
  left join
  (select distinct(parent_company) parent_company from pharma  ) p--distinct of parent_company
  on c.Sponsor=p.Parent_Company
where parent_company is null--sponsors that are not pharmaceutical companies

-- COMMAND ----------

--Frequency of 10 most common sponsors
select cp.Sponsor,count(*) number_of_clinical_trials
from
(
  select c.id,c.Sponsor,p.parent_company   
  from clinicaltrial c
  left join
  (select distinct(parent_company) parent_company from pharma  ) p--distinct of parent_company
  on c.Sponsor=p.Parent_Company
where parent_company is null--sponsors that are not pharmaceutical companies
) cp
group by cp.Sponsor
order by number_of_clinical_trials desc
limit(10);

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ####Discussion of result (Question 5)

-- COMMAND ----------

--Create a view for companies are not pharmaceutical
Create or replace temp view VW_Non_pharmaceutical_companies as
select * from clinicaltrial c
left join pharma p
on c.Sponsor=p.Parent_Company
where p.Parent_Company is null;


--Create a view for companies are pharmaceutical
Create or replace temp view VW_pharmaceutical_companies as
select * from clinicaltrial c
left join pharma p
on c.Sponsor=p.Parent_Company
where p.Parent_Company is not null;

-- COMMAND ----------

--The frequency of studies supported by pharmaceutical and non-pharmaceutical companies
select 'pharmaceutical_companies' Company_Type,count(distinct id) cnt from VW_pharmaceutical_companies
union all
select 'pharmaceutical_companies'Company_Type,count(distinct id) cnt from VW_Non_pharmaceutical_companies

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ####6.Plot number of completed studies each month in a given year { for the submission dataset, the year is 2021. You need to include your visualization as well as a table of all the values you have plotted for each month.

-- COMMAND ----------

--Creating a view to Sort the number of completed studies in each month of a given year
CREATE OR REPLACE TEMP VIEW VW_Month_Frequency AS
select Month_Id id, 
Month, 
count(*) frequency 
from
(select Sponsor,
Status,
Completion,
case 
when left(Completion,3) = 'Jan' then 1
when left(Completion,3) = 'Feb' then 2 
when left(Completion,3) = 'Mar' then 3
when left(Completion,3) = 'Apr' then 4
when left(Completion,3) = 'May' then 5
when left(Completion,3) = 'Jun' then 6
when left(Completion,3) = 'Jul' then 7
when left(Completion,3) = 'Aug' then 8
when left(Completion,3) = 'Sep' then 9
when left(Completion,3) = 'Oct' then 10
when left(Completion,3) = 'Nov' then 11
when left(Completion,3) = 'Dec' then 12
else 'Unkhown'
end Month_Id,--to sort data by the id of each Month

left(Completion,3) Month,--extract month from Completion date
right(Completion,4)Year--extract year from Completion date
from clinicaltrial c
where c.Status ='Completed'--Completed studies
and right(Completion,4)=${hiveconf:Year}-- the given year

)k
group by Month_Id,k.Month
order by cast(Month_Id as int)

-- COMMAND ----------

--The number of completed studies  in each month of a given year in a table format 
select Month, frequency  from VW_Month_Frequency

-- COMMAND ----------

--In the previous implementation, the November and december are not shown in the result
--because there are no completed study in those month.
--To see this month with zero completed study, the VW_Month has been created. 
CREATE OR REPLACE TEMP VIEW VW_Month
AS 
select 1 id,'Jan' Month
union all
select 2 id,'Feb'Month
union all
select 3 id,'Mar'Month
union all
select 4 id,'Apr'Month
union all
select 5 id,'May'Month
union all
select 6 id,'Jun'Month
union all
select 7 id,'Jul'Month
union all
select 8 id,'Aug'Month
union all
select 9 id,'Sep'Month
union all
select 10 id,'Oct'Month
union all
select 11 id,'Nov'Month
union all
select 12 id,'Dec'Month

-- COMMAND ----------

--Creating a view to show the frequency of the completed studies in each Monhs Sorted ny Month
CREATE OR REPLACE TEMP VIEW VW_Month_Frequency AS
select Month_Id, Month, count(id)frequency from (select m.id Month_Id,m.Month , k.id from VW_Month m
left join
(select id,
Sponsor,
Status,
Completion,
left(Completion,3) Month,--extract month from Completion date
right(Completion,4)Year--extract year from Completion date
from clinicaltrial c
where c.Status ='Completed'--Completed studies
and right(Completion,4)=${hiveconf:Year}-- the given year
)k
on k.Month= m.Month
)k
group by Month_Id, Month
order by Month_Id


-- COMMAND ----------

select Month, frequency from VW_Month_Frequency

-- COMMAND ----------

select Month, frequency from VW_Month_Frequency


-- COMMAND ----------

-- MAGIC %md
-- MAGIC ##Further Analysis 1: The top 5 Interventions with their frequencies.  

-- COMMAND ----------

--Creating a view in which each record has an Interventions 
--Split function creats a list of Interventions 
--Explode function spreads list of Interventions into differrent rows(like flatMap in RDD)
CREATE OR REPLACE TEMP VIEW VW_exploded_Interventions_1 AS 
SELECT Id,Sponsor,
Status,
Start,
Completion,
Type,
Submission, 
Conditions,
explode(split(Interventions , ',')) as Interventions 
FROM clinicaltrial

-- COMMAND ----------

--The 5 most common Interventions
select Interventions,count(*) cnt from VW_exploded_Interventions_1
group by Interventions
order by cnt desc
limit(5)

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ##Further Analysis 2: The 5 most frequent Investigations for the 5 most common conditions 

-- COMMAND ----------

--This view is based on the VW_exploded_conditions which has a condition in each record. 
--Creating a view in which each record has an Interventions 
--Split function creats a list of Interventions 
--Explode function spreads list of Interventions into differrent rows(like flatMap in RDD)
CREATE OR REPLACE TEMP VIEW VW_exploded_Interventions AS 
SELECT Id,Sponsor,
Status,
Start,
Completion,
Type,
Submission, 
Conditions,
explode(split(Interventions , ',')) as Interventions 
FROM VW_exploded_conditions

-- COMMAND ----------

CREATE OR REPLACE TEMP VIEW VW_Carcinoma_Interventions  as
select "Carcinoma" conditions ,Interventions,count(*) cnt from VW_exploded_Interventions
where conditions ="Carcinoma"
group by Interventions
order by cnt desc
limit(1);
CREATE OR REPLACE TEMP VIEW VW_DiabetesMellitus_Interventions  as
select "Diabetes Mellitus" conditions ,Interventions,count(*) cnt from VW_exploded_Interventions
where conditions ="Diabetes Mellitus"
group by Interventions
order by cnt desc
limit(1);
CREATE OR REPLACE TEMP VIEW VW_BreastNeoplasms_Interventions  as
select "Breast Neoplasms" conditions ,Interventions,count(*) cnt from VW_exploded_Interventions
where conditions ="Breast Neoplasms"
group by Interventions
order by cnt desc
limit(1);
CREATE OR REPLACE TEMP VIEW VW_Syndrome_Interventions  as
select "Syndrome" conditions ,Interventions,count(*) cnt from VW_exploded_Interventions
where conditions ="Syndrome"
group by Interventions
order by cnt desc
limit(1);
CREATE OR REPLACE TEMP VIEW VW_Neoplasms_Interventions  as
select "Neoplasms" conditions ,Interventions,count(*) cnt from VW_exploded_Interventions
where conditions ="Neoplasms"
group by Interventions
order by cnt desc
limit(1);

-- COMMAND ----------

--The most common Interventions for the 5 most common conditions
select * from VW_Carcinoma_Interventions
union all
select * from VW_DiabetesMellitus_Interventions
union all
select * from VW_Neoplasms_Interventions
union all
select * from VW_BreastNeoplasms_Interventions
union all
select * from VW_Syndrome_Interventions
order by cnt desc


-- COMMAND ----------

-- MAGIC %md
-- MAGIC ##Further Analysis 3: The frequency of study type done by pharmaceutical companies and non-pharmaceutical companies.

-- COMMAND ----------

--Computing the frequency of study types between pharmaceutical companies and non_pharmaceutical companies
select k.Type, k.pharmaceutical_companies_cnt, k2.Non_pharmaceutical_companies_cnt from 
(select  Type,count(*) pharmaceutical_companies_cnt from VW_pharmaceutical_companies 
group by Type)k--pharmaceutical companies
left join 
(
select  Type,count(*) Non_pharmaceutical_companies_cnt from VW_Non_pharmaceutical_companies 
group by Type)k2--non_pharmaceutical
on k.type=k2.type
order by pharmaceutical_companies_cnt desc

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ##Further Analysis 4: The frequency of Completed Studies without Completion date by start date

-- COMMAND ----------


select right(Start,4) Year, Count(*) cnt from clinicaltrial
where Completion is null---Completion date is null
and Status ="Completed"--Completed Studies
group by Year--start date



-- COMMAND ----------

-- MAGIC %md
-- MAGIC ##Further Analysis 5: The frequency of status in the given year.

-- COMMAND ----------

--The frequency of each study status
select Status,count(*)cnt from clinicaltrial
where right(Completion,4)=${hiveconf:Year}--the given year
group by Status
order by cnt desc
