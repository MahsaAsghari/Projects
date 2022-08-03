select 
sc.Group_Type
,sc.SubGroup
,sc.Schools_Infrastructures
,t.Experienced_Qualified_Teacher
,tec.Tech_Full Technology_Access
,st.No_repeated_Grades
,st.Transferable_skills
,st.ENG_Progress
,st.Math_Progress
from  [dbo].[Schools_Infrastructures] Sc 
left join [dbo].[Experienced_Qualified_Teacher] T
on sc.Group_Type=t.Group_Type
and sc.SubGroup=t.SubGroup
left join [dbo].[Student_Achievement]st
on sc.Group_Type=st.Group_Type
and sc.SubGroup=st.SubGroup
left join [dbo].[Technology_Access]tec
on  sc.Group_Type=tec.Group_Type
and sc.SubGroup=tec.SubGroup
order by sc.Group_Type
,sc.SubGroup

