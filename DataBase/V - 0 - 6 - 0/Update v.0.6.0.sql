/*    ==Scripting Parameters==

    Source Server Version : SQL Server 2016 (13.0.4001)
    Source Database Engine Edition : Microsoft SQL Server Express Edition
    Source Database Engine Type : Standalone SQL Server

    Target Server Version : SQL Server 2017
    Target Database Engine Edition : Microsoft SQL Server Standard Edition
    Target Database Engine Type : Standalone SQL Server
*/
USE [DailySecurityDB]
GO
/****** Object:  Table [dbo].[tbl_Alarma]    Script Date: 2/6/2018 17:47:15 ******/

alter table tbl_alarma alter column Codigo nchar(10) not null;
alter table tbl_alarma alter column Estado int null;
alter table tbl_alarma alter column Alerta int null;

/****** Object:  StoredProcedure [dbo].[ALARMA_GetAlarmaByAlarmaIdyUsuarioId]    Script Date: 2/6/2018 17:47:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		DAYANA FULLA
-- Create date: 25/05/18
-- Description:	GET ALARMA BY ALARMAID Y USUARIOID
-- =============================================
ALTER PROCEDURE [dbo].[ALARMA_GetAlarmaByAlarmaIdyUsuarioId] 
	-- Add the parameters for the stored procedure here
	@usuarioId int, 
	@alarmaId int  
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

		SELECT [AlarmaId]
			  ,[Codigo]
			  ,[Estado]
			  ,[Alerta]
			  ,[Latitud]
			  ,[Longitud]
			  ,[UsuarioId] 
		  FROM [dbo].[tbl_Alarma] 
		  WHERE AlarmaId=@alarmaId and UsuarioId=@usuarioId

END
GO
/****** Object:  StoredProcedure [dbo].[ALARMA_GetAlarmaByCodigo]    Script Date: 2/6/2018 17:47:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		DAYANA FULLA
-- Create date: 25/05/18
-- Description:	COMPROBAR QUE LA ALARMA ES EXISTENTE
-- =============================================
CREATE PROCEDURE [dbo].[ALARMA_GetAlarmaByCodigo]
	@codigo nchar(20) 
AS
BEGIN
	
	SET NOCOUNT ON;


	SELECT [AlarmaId]
		  ,[Codigo]
	  FROM [dbo].[tbl_Alarma]
	  WHERE Codigo=@codigo



END
GO
/****** Object:  StoredProcedure [dbo].[ALARMA_GetAlarmaById]    Script Date: 2/6/2018 17:47:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		DAYANA STEFANY FULLA
-- Create date: 25/05/18
-- Description: OBTENER ALARMA POR ALARMA ID
-- =============================================
ALTER PROCEDURE [dbo].[ALARMA_GetAlarmaById] 
	-- Add the parameters for the stored procedure here
	@alarmaId int 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;


		SELECT [AlarmaId]
			  ,[Codigo]
			  ,[Estado]
			  ,[Alerta]
			  ,[Latitud]
			  ,[Longitud]
			  ,[UsuarioId]
		  FROM [dbo].[tbl_Alarma]
		  WHERE AlarmaId=@alarmaId 


END
GO
/****** Object:  StoredProcedure [dbo].[ALARMA_GetAlarmaByUsuarioId]    Script Date: 2/6/2018 17:47:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		DAYANA FULLA
-- Create date: 25/05/18
-- Description:	OBTENER ALARMA POR USUARIO ID
-- =============================================
ALTER PROCEDURE [dbo].[ALARMA_GetAlarmaByUsuarioId] 
	-- Add the parameters for the stored procedure here
	@usuarioId int 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

		SELECT [AlarmaId]
			  ,[Codigo]
			  ,[Estado]
			  ,[Alerta]
			  ,[Latitud]
			  ,[Longitud]
		  FROM [dbo].[tbl_Alarma] 
		  WHERE UsuarioId=@usuarioId

END
GO
/****** Object:  StoredProcedure [dbo].[ALARMA_InsertarAlarma]    Script Date: 2/6/2018 17:47:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		DAYANA FULLA
-- Create date: 25/05/18
-- Description:	INSERTAR ALARMA
-- =============================================
CREATE PROCEDURE [dbo].[ALARMA_InsertarAlarma] 
	 @codigo nchar(20), 
	 @estado int,
	 @alerta int, 
	 @latitud nchar(20), 
	 @longitud nchar(20),
	 @usuarioId int, 
	 @alarmaId INT OUTPUT  
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;


	INSERT INTO [dbo].[tbl_Alarma]
			   ([Codigo]
			   ,[Estado]
			   ,[Alerta]
			   ,[Latitud]
			   ,[Longitud]
			   ,[UsuarioId])
		 VALUES
			   (@codigo 
			   ,@estado
			   ,@alerta 
			   ,@latitud 
			   ,@longitud 
			   ,@usuarioId)



END
GO
/****** Object:  StoredProcedure [dbo].[ALARMA_UpdateAlarma]    Script Date: 2/6/2018 17:47:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		DAYANA STEFANY FULLA
-- Create date: 25/05/18
-- Description: ACTUALIZAR ALARMA
-- =============================================
ALTER PROCEDURE [dbo].[ALARMA_UpdateAlarma]
	-- Add the parameters for the stored procedure here
	@alarmaId int, 
	@estado int, 
	@alerta int, 
	@latitud varchar(20), 
	@longitud varchar(20), 
	@usuarioId int  
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

		UPDATE [dbo].[tbl_Alarma]
		   SET [Estado] = @estado 
			  ,[Alerta] = @alerta 
			  ,[Latitud] = @latitud 
			  ,[Longitud] = @longitud 
			  ,[UsuarioId] = @usuarioId 
		 WHERE AlarmaId=@alarmaId

END
GO

--actualizacion de version 
Use [Master]
GO 

IF  NOT EXISTS (SELECT name FROM sys.databases WHERE name = N'DailySecurityDB')
	RAISERROR('La base de datos ''DailySecurityDB'' no existe. Cree la base de datos primero',16,127)
GO

USE DailySecurityDB
GO

PRINT 'Actualizando a la version 0.6.0'

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_VERSION_GetVersion]') 
	AND type in (N'P', N'PC'))
BEGIN

	RAISERROR('La base de datos no esta inicializada',16,127)
	RETURN;

END


DECLARE @intVersionMayor int
DECLARE @intVersionMenor int
DECLARE @intPatch int

EXECUTE [dbo].[usp_VERSION_GetVersion] 
   @intVersionMayor OUTPUT
  ,@intVersionMenor OUTPUT
  ,@intPatch OUTPUT

IF @intVersionMayor IS NULL OR @intVersionMenor IS NULL
BEGIN
	
	RAISERROR('La base de datos no esta inicializada',16,127)
	RETURN;

END


IF @intVersionMayor IS NULL OR @intVersionMenor IS NULL OR NOT (@intVersionMayor = 0 AND @intVersionMenor = 5)
BEGIN
	
	RAISERROR('La base de datos no esta en la version 0.5. Este script solamente se apllica a la version 0.5',16,127)
	RETURN;

END
ELSE
BEGIN
	
	PRINT 'Version OK'

END


DELETE FROM [dbo].[tbl_Version]
GO

INSERT INTO [dbo].[tbl_Version]
           ([versionMayor]
           ,[versionMenor]
           ,[patch])
     VALUES
           (0
           ,6
           ,0)
GO




