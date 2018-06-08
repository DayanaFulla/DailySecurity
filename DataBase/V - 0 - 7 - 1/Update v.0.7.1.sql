USE [DailySecurityDB]
GO
/****** Object:  StoredProcedure [dbo].[LLAVE_GetLlavesPropietario]    Script Date: 08/06/2018 18:48:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Lizeth Quispe
-- Create date: 08/06/2018
-- Description:	Obtener llaves propietarias de un Usuario
-- =============================================
ALTER PROCEDURE [dbo].[LLAVE_GetLlavesPropietario]
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
		  ,A.Nombre Nombre
	  FROM tbl_LLaves L  join tbl_Alarma A on L.AlarmaId = A.AlarmaId
	  WHERE A.UsuarioId = @UsuarioID and L.UsuarioId = @UsuarioID

END

--actualizacion de version 
Use [Master]
GO 

IF  NOT EXISTS (SELECT name FROM sys.databases WHERE name = N'DailySecurityDB')
	RAISERROR('La base de datos ''DailySecurityDB'' no existe. Cree la base de datos primero',16,127)
GO

USE DailySecurityDB
GO

PRINT 'Actualizando a la version 0.7.1'

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


IF @intVersionMayor IS NULL OR @intVersionMenor IS NULL OR NOT (@intVersionMayor = 0 AND @intVersionMenor = 7 AND @intPatch = 0)
BEGIN
	
	RAISERROR('La base de datos no esta en la version 0.7.0 Este script solamente se apllica a la version 0.7.0',16,127)
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
           ,7
           ,1)
GO