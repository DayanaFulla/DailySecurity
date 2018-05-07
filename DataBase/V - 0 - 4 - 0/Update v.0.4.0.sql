USE [DailySecurityDB]
GO

/****** Object:  StoredProcedure [dbo].[VERIFICACION_UpdateVerificacion]    Script Date: 5/5/2018 13:18:16 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Dayana Fullá
-- Create date: 24/04/18
-- Description:	Actualizar Verificacion
-- =============================================
ALTER PROCEDURE [dbo].[VERIFICACION_UpdateVerificacion]
	@UsuarioId INT, 
	@VerificacionId INT,
	@estado BIT 
AS
BEGIN
	
	SET NOCOUNT ON;

UPDATE [dbo].[tbl_Verificacion_de_Cuenta]
   SET [Estado] = @estado 
 WHERE UsuarioId=@UsuarioId and VerificacionId=@VerificacionId;

 Update [dbo].[tbl_usuario]
	SET [EstadoEspera] = 1
WHERE	UsuarioId = @UsuarioId;

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

PRINT 'Actualizando a la version 0.4.0'

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[usp_VERSION_GetVersion]') AND type in (N'P', N'PC'))
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


IF @intVersionMayor IS NULL OR @intVersionMenor IS NULL OR NOT (@intVersionMayor = 0 AND @intVersionMenor = 3)
BEGIN
	
	RAISERROR('La base de datos no esta en la version 0.3. Este script solamente se apllica a la version 0.3',16,127)
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
           ,4
           ,0)
GO

