use DailySecurityDB;

alter table tbl_alarma alter column Codigo nvarchar(25) not null;
alter table tbl_alarma add UsuarioId int null;
alter table tbl_alarma add Contrasena nchar(50) null;

ALTER TABLE tbl_alarma
ADD CONSTRAINT FK_AlarmaUsuario
FOREIGN KEY (UsuarioId) REFERENCES tbl_Usuario(UsuarioId);

/****** Object:  StoredProcedure [dbo].[ALARMA_DeleteAlarma]    Script Date: 25/5/2018 11:28:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		DAYANA FULLA
-- Create date: 25/05/18
-- Description:	ELIMINAR ALARMA
-- =============================================
CREATE PROCEDURE [dbo].[ALARMA_DeleteAlarma] 
	-- Add the parameters for the stored procedure here
	@alarmaId int 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DELETE FROM [dbo].[tbl_Alarma]
		  WHERE AlarmaId=@alarmaId 

END
GO

/****** Object:  StoredProcedure [dbo].[ALARMA_GetAlarmaByAlarmaIdyUsuarioId]    Script Date: 25/5/2018 11:28:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		DAYANA FULLA
-- Create date: 25/05/18
-- Description:	OBTENER ALARMA POR ID E ID DE USUARIO
-- =============================================
CREATE PROCEDURE [dbo].[ALARMA_GetAlarmaByAlarmaIdyUsuarioId] 
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
			  ,[Contrasena]
		  FROM [dbo].[tbl_Alarma] 
		  WHERE AlarmaId=@alarmaId and UsuarioId=@usuarioId

END
GO
/****** Object:  StoredProcedure [dbo].[ALARMA_GetAlarmaById]    Script Date: 25/5/2018 11:28:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		DAYANA STEFANY FULLA
-- Create date: 25/05/18
-- Description: OBTENER ALARMA POR CODIGO ID
-- =============================================
CREATE PROCEDURE [dbo].[ALARMA_GetAlarmaById] 
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
			  ,[UsuarioID]
			  ,[Contrasena]
		  FROM [dbo].[tbl_Alarma] 
		  WHERE AlarmaId=@alarmaId 


END
GO
/****** Object:  StoredProcedure [dbo].[ALARMA_GetAlarmaByUsuarioId]    Script Date: 25/5/2018 11:28:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		DAYANA FULLA
-- Create date: 25/05/18
-- Description:	ELIMINAR ALARMA
-- =============================================
CREATE PROCEDURE [dbo].[ALARMA_GetAlarmaByUsuarioId] 
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
			  ,[UsuarioID]
			  ,[Contrasena]
		  FROM [dbo].[tbl_Alarma] 
		  WHERE UsuarioId=@usuarioId

END
GO
/****** Object:  StoredProcedure [dbo].[ALARMA_UpdateAlarma]    Script Date: 25/5/2018 11:28:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		DAYANA STEFANY FULLA
-- Create date: 25/05/18
-- Description: OBTENER ALARMA POR CODIGO ID
-- =============================================
CREATE PROCEDURE [dbo].[ALARMA_UpdateAlarma]
	-- Add the parameters for the stored procedure here
	@alarmaId int, 
	@estado nchar(10), 
	@alerta nchar(10), 
	@latitud varchar(20), 
	@longitud varchar(20), 
	@contra nchar(50), 
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
			  ,[Contrasena] = @contra 
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

PRINT 'Actualizando a la version 0.5.0'

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


IF @intVersionMayor IS NULL OR @intVersionMenor IS NULL OR NOT (@intVersionMayor = 0 AND @intVersionMenor = 4)
BEGIN
	
	RAISERROR('La base de datos no esta en la version 0.3. Este script solamente se apllica a la version 0.4',16,127)
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
           ,5
           ,0)
GO


