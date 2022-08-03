USE [Asghari_Task1DB]
GO

/****** Object:  UserDefinedFunction [dbo].[Convert_agemon]    Script Date: 4/22/2022 2:32:34 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<roghayeh Asghari>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[Convert_agemon]
(
	-- Add the parameters for the function here
	@agemon as decimal(38,2)
)
--select dbo.[Convert_agemon] (150) 
RETURNS decimal(38,2)
AS
BEGIN

DECLARE @age as decimal(38,2) =(select cast(@agemon/12 as decimal(38,2)))

return @age

END
GO


