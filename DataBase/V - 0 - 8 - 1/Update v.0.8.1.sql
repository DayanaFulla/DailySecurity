USE [DailySecurityDB]
GO
/****** Object:  StoredProcedure [dbo].[LLAVE_GetLlavesByAlarmaId]    Script Date: 22/06/2018 14:38:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Lizeth Quispe
-- Create date: 08/06/2018
-- Description:	Obtener llaves prestadas por Alarma ID que no sean propietarias
-- =============================================
ALTER PROCEDURE [dbo].[LLAVE_GetLlavesByAlarmaId]
	-- Add the parameters for the stored procedure here
	@AlarmaId int,
	@UsuarioId int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT [LlaveId]
			,[Codigo]
			,[Estado]
			,[HoraInicio]
			,[HoraFin]
			,[FechaInicio]
			,[FechaFin]
			,[UsuarioId]
			,[AlarmaId]
			,[Tipo]
			,[Nick]
			,[Dias]
			,[Nombre]
			,[ActHora]
			,[ActDias]
	  FROM tbl_LLaves
	  WHERE AlarmaId = @AlarmaId and (UsuarioId <> @UsuarioId or UsuarioId IS NULL)

END
GO

USE [DailySecurityDB]
GO
/****** Object:  StoredProcedure [dbo].[ALARMA_UpdateAlarma]    Script Date: 3/7/2018 18:09:40 ******/
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
	@contrasena nchar (50),
	@nombre nvarchar(30),
	@usuarioId int  
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON; 
	 
	IF (@usuarioId<1) 
		SET @usuarioId = NULL;
	
	IF (@latitud='') 
		SET @latitud = NULL;

	IF (@longitud='') 
		SET @longitud = NULL;

	IF (@nombre='') 
		SET @nombre = NULL;

	IF (@contrasena='') 
		SET @contrasena = NULL;


	UPDATE [dbo].[tbl_Alarma]
		SET [Estado] = @estado 
			,[Alerta] = @alerta 
			,[Latitud] = @latitud 
			,[Longitud] = @longitud
			,[Contrasena] = @contrasena
			,[Nombre] = @nombre
			,[UsuarioId] = @usuarioId
	WHERE AlarmaId=@alarmaId


END


/****** Object:  StoredProcedure [dbo].[PRUEBA_GetLlaves]    Script Date: 3/7/2018 18:11:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Dayana Fulla
-- Create date: ??-??-????
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[PRUEBA_GetLlaves] 
	@AlarmaId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;


SELECT [LlaveId]
      ,[Codigo]
      ,[Estado]
      ,[HoraInicio]
      ,[HoraFin]
      ,[FechaInicio]
      ,[FechaFin]
      ,[UsuarioId]
      ,[AlarmaId]
      ,[Tipo]
      ,[Nick]
      ,[Dias]
      ,[Nombre]
      ,[ActHora]
      ,[ActDias]
  FROM [dbo].[tbl_LLaves]
  WHERE AlarmaId=@AlarmaId

END

ALTER tABLE tbl_Llaves ADD CONSTRAINT COD_LLAVE_UNIQUE UNIQUE (Codigo);

USE [DailySecurityDB]
GO
/****** Object:  StoredProcedure [dbo].[LLAVE_GetLlavesByUsuarioId]    Script Date: 06/07/2018 4:32:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Lizeth Quispe
-- Create date: 08/06/2018
-- Description:	Obtener llaves obtenidas que no sean suyas
-- =============================================
ALTER PROCEDURE [dbo].[LLAVE_GetLlavesByUsuarioId]
	-- Add the parameters for the stored procedure here
	@UsuarioID int

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT L.[LlaveId]
			,L.[Codigo]
			,L.[Estado]
			,L.[HoraInicio]
			,L.[HoraFin]
			,L.[FechaInicio]
			,L.[FechaFin]
			,L.[UsuarioId]
			,L.[AlarmaId]
			,L.[Tipo]
			,L.[Nick]
			,L.[Dias]
			,L.[Nombre]
			,L.[ActHora]
			,L.[ActDias]
	  FROM tbl_LLaves L left join tbl_Alarma A on L.UsuarioId = A.UsuarioId
	  WHERE L.UsuarioId = @UsuarioID and L.[Nick] <> 'Propietario'

END

-- actualización de version.
Use [Master]
GO 

IF  NOT EXISTS (SELECT name FROM sys.databases WHERE name = N'DailySecurityDB')
	RAISERROR('La base de datos ''DailySecurityDB'' no existe. Cree la base de datos primero',16,127)
GO

USE DailySecurityDB
GO

PRINT 'Actualizando a la version 0.8.1'

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


IF @intVersionMayor IS NULL OR @intVersionMenor IS NULL OR NOT (@intVersionMayor = 0 AND @intVersionMenor = 8 AND @intPatch = 0)
BEGIN
	
	RAISERROR('La base de datos no esta en la version 0.8.0 Este script solamente se apllica a la version 0.7.1',16,127)
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
           ,8
           ,1)
GO