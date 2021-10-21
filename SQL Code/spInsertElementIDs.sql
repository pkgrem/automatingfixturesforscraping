USE [master]
GO
/****** Object:  StoredProcedure [dbo].[spInsertElementIDs]    Script Date: 21/10/2021 13:46:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[spInsertElementIDs] AS 
DROP TABLE [Element_ID]

SELECT concat('https://fantasy.premierleague.com/api/element-summary/', ID, '/') as ID
INTO Element_ID
 from elements