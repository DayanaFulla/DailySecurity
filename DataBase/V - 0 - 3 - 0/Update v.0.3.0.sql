USE [DailySecurityDB]
GO


/****** Object:  StoredProcedure [dbo].[USER_UpdateEstadoEsperaUsuario]    Script Date: 3/5/2018 14:37:25 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		Dayana Fullá
-- Create date: 21/04/18
-- Description:	Actualizar estado Espera del usuario
-- =============================================
ALTER PROCEDURE [dbo].[USER_UpdateEstadoEsperaUsuario]
	@UsuarioId INT 
AS
BEGIN
	
	SET NOCOUNT ON;

	UPDATE [dbo].[tbl_Usuario]
	   SET [EstadoEspera] = 1  
	 WHERE UsuarioId=@UsuarioId 

END
GO




USE [DailySecurityDB]
GO

/****** Object:  StoredProcedure [dbo].[USER_GetEstadoEsperaUsuarioByID]    Script Date: 3/5/2018 14:36:39 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		Flavia Veizaga
-- Create date: 2018-05-03
-- Description:	Obtiene el Estado de cuenta del Usuario
-- =============================================
ALTER PROCEDURE [dbo].[USER_GetEstadoEsperaUsuarioByID]
	@UsuarioIDp int
	 
AS
BEGIN
	
	SET NOCOUNT ON;

	SELECT EstadoEspera 
	FROM tbl_Usuario
	WHERE UsuarioID=@UsuarioIDp;

	
END

GO



Use [Master]
GO 

IF  NOT EXISTS (SELECT name FROM sys.databases WHERE name = N'DailySecurityDB')
	RAISERROR('La base de datos ''DailySecurityDB'' no existe. Cree la base de datos primero',16,127)
GO

USE DailySecurityDB
GO

PRINT 'Actualizando a la version 0.3.0'

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


IF @intVersionMayor IS NULL OR @intVersionMenor IS NULL OR NOT (@intVersionMayor = 0 AND @intVersionMenor = 2)
BEGIN
	
	RAISERROR('La base de datos no esta en la version 0.2. Este script solamente se apllica a la version 0.2',16,127)
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
           ,3
           ,0)
GO





