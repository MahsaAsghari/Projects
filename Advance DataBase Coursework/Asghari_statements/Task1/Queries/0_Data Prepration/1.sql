
--------2 record of india should be removed---------------
select distinct yc from [dbo].[india_constructed] 
select * from [dbo].[india_constructed]  where yc=' '--2

select *into  [dbo].[Backup_India_constructed] from  [dbo].[india_constructed]--backup of data befor remove these 2 records
--15097
delete from [dbo].[india_constructed]  where yc=' '--delete incorrect data from table

 ----------Rrename name of field to have similar columns in each countries---------------
 select * into [dbo].[Backup_Ethiopia_constructed] from [dbo].[ethiopia_constructed]--backup before change the column name
EXEC sp_rename 'dbo.ethiopia_constructed.panel', 'panel12345', 'COLUMN';--rename the name of the panel column to panel12345

EXEC sp_rename 'dbo.ethiopia_constructed.drwaterq_new', 'drwaterq', 'COLUMN';--rename the name of the panel column to panel12345

EXEC sp_rename 'dbo.ethiopia_constructed.toiletq_new', 'toiletq', 'COLUMN';--rename the name of the panel column to panel12345


EXEC sp_rename 'dbo.Vietnam_constructed.drwaterq_new', 'drwaterq', 'COLUMN';--rename the name of the panel column to panel12345

EXEC sp_rename 'dbo.Vietnam_constructed.toiletq_new', 'toiletq', 'COLUMN';--rename the name of the panel column to panel12345

----------------change the data type of [agemon]-----------------------------------------------------
alter table [dbo].[Ethiopia_constructed] alter column [agemon] float
alter table [dbo].[India_constructed] alter column [agemon] float
alter table [dbo].[Peru_constructed] alter column [agemon] float
alter table [dbo].[Vietnam_constructed] alter column [agemon] float

