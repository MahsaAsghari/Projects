/*
Severe Health Deprivation – children who had not been immunised against any diseases or young children who had a recent illness 
involving diarrhoea and had not received any medical advice or treatment.
*/


select 
country
,childid
,cohort_type
,chsex_desc from  [dbo].[view_Severe_Health_Deprivation_AllCountries]


Exec [dbo].[sp_Severe_Health_Deprivation]