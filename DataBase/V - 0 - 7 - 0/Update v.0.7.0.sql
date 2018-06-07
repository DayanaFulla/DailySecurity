USE [DailySecurityDB]
GO

/****** Object:  Table [dbo].[tbl_Llaves]    Script Date: 7/6/2018 13:18:15 ******/
ALTER TABLE tbl_Llaves ADD Tipo nchar(1) not null;
ALTER TABLE tbl_Llaves ADD Nick nvarchar(30) null;
ALTER TABLE tbl_Llaves ADD Dias nvarchar(21) null;
ALTER TABLE tbl_Llaves ADD Nombre nvarchar(30) null;
ALTER TABLE tbl_Llaves ALTER COLUMN HoraInicio time null;
ALTER TABLE tbl_Llaves ALTER COLUMN HoraFin time null;
ALTER TABLE tbl_Llaves ALTER COLUMN FechaInicio date null;
ALTER TABLE tbl_Llaves ALTER COLUMN FechaFin date null;
ALTER TABLE tbl_Llaves ALTER COLUMN Estado int null;


/****** Object:  StoredProcedure [dbo].[LLAVE_InsertLlaveTemporal]    Script Date: 07/06/2018 14:50:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Lizeth Quispe
-- Create date: 08/06/2018
-- Description:	Insert solo para llaves Temporales, para evitar errores
-- =============================================
CREATE PROCEDURE [dbo].[LLAVE_InsertLlaveTemporal]
	-- Add the parameters for the stored procedure here
	@Codigo varchar(50),
	@Estado int,
	@Tipo nchar(1),
	@Nick nvarchar(30),
	@HoraInicio time,
	@HoraFin time,
	@FechaInicio date,
	@FechaFin date,
	@AlarmaId int,
	@Dias nvarchar(21),
	@LlaveId INT OUTPUT

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	INSERT INTO [dbo].[tbl_LLaves]
			   ([Codigo]
			   ,[Estado]
			   ,[HoraInicio]
			   ,[HoraFin]
			   ,[FechaInicio]
			   ,[FechaFin]
			   ,[AlarmaId]
			   ,[Tipo]
			   ,[Nick]
			   ,[Dias])
		 VALUES
			   (@Codigo
			   ,@Estado
			   ,@HoraInicio
			   ,@HoraFin
			   ,@FechaInicio
			   ,@FechaFin
			   ,@AlarmaId
			   ,@Tipo
			   ,@Nick
			   ,@Dias)
	
END

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Lizeth Quispe
-- Create date: 08/06/2018
-- Description:	Insert solo para llaves permanentes
-- =============================================
CREATE PROCEDURE LLAVE_InsertLlavePermanente
	-- Add the parameters for the stored procedure here
	@Codigo varchar(50),
	@Estado int,
	@Tipo nchar(1),
	@Nick nvarchar(30),
	@AlarmaId int,
	@LlaveId INT OUTPUT

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	INSERT INTO [dbo].[tbl_LLaves]
			   ([Codigo]
			   ,[Estado]
			   ,[AlarmaId]
			   ,[Tipo]
			   ,[Nick])
		 VALUES
			   (@Codigo
			   ,@Estado
			   ,@AlarmaId
			   ,@Tipo
			   ,@Nick)
	
END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Lizeth Quispe
-- Create date: 08/06/2018
-- Description:	Obtener llaves propietarias de un Usuario
-- =============================================
CREATE PROCEDURE LLAVE_GetLlavesPropietario
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
		  ,A.Nombre as Nombre
	  FROM tbl_LLaves L join tbl_Alarma A on L.UsuarioId = A.UsuarioId
	  WHERE A.UsuarioId = @UsuarioID

END
GO


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Lizeth Quispe
-- Create date: 08/06/2018
-- Description:	Obtener llaves prestadas por Alarma ID que no sean propietarias
-- =============================================
CREATE PROCEDURE LLAVE_GetLlavesByAlarmaId
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
	  FROM tbl_LLaves
	  WHERE AlarmaId = @AlarmaId and UsuarioId <> @UsuarioId

END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Lizeth Quispe
-- Create date: 08/06/2018
-- Description:	Confirma llave que a sido recibida por el Usuario
-- =============================================
CREATE PROCEDURE LLAVE_UpdateConfirmarRecibido
	-- Add the parameters for the stored procedure here
	@UsuarioId int,
	@Nombre nvarchar(30),
	@Codigo varchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	UPDATE [dbo].[tbl_LLaves]
	   SET [Estado] = 1
		  ,[UsuarioId] = @UsuarioId
		  ,[Nombre] = @Nombre
	 WHERE [Codigo] = @Codigo
END
GO

/****** Object:  StoredProcedure [dbo].[LLAVE_UpdateLlave]    Script Date: 07/06/2018 15:49:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Lizeth Quispe
-- Create date: 08/06/2018
-- Description:	Editar Configuracion de llave prestada
-- =============================================
CREATE PROCEDURE [dbo].[LLAVE_UpdateLlave]
	-- Add the parameters for the stored procedure here
	@Nick nvarchar(30),
	@Estado int,
	@Tipo nchar(1),
	@HoraInicio time,
	@HoraFin time,
	@FechaInicio date,
	@FechaFin date,
	@Dias nvarchar(21),
	@Nombres nvarchar(30),
	@LlaveId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	UPDATE [dbo].[tbl_LLaves]
	   SET [Estado] = @Estado
		  ,[Tipo] = @Tipo
		  ,[HoraInicio] = @HoraInicio
		  ,[HoraFin] = @HoraFin
		  ,[FechaInicio] = @FechaInicio
		  ,[FechaFin] = @FechaFin
		  ,[Nick] = @Nick
		  ,[Dias] = @Dias
		  ,[Nombre] = @Nombre
	 WHERE [LlaveId] = @LlaveId
END

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Lizeth Quispe
-- Create date: 08/06/2018
-- Description:	Eliminar Llave
-- =============================================
CREATE PROCEDURE LLAVE_DeleteLlave
	-- Add the parameters for the stored procedure here
	@LlaveId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DELETE FROM [dbo].[tbl_LLaves]
      WHERE LlaveId = @LlaveId

END
GO


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Lizeth Quispe
-- Create date: 08/06/2018
-- Description:	Obtener Alarma por codigo asignado
-- =============================================
CREATE PROCEDURE LLAVE_GetLlaveByCodigo
	-- Add the parameters for the stored procedure here
	@Codigo varchar(50)
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
	  FROM [dbo].[tbl_LLaves]
	  WHERE Codigo = @Codigo

END
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Lizeth Quispe
-- Create date: 08/06/2018
-- Description:	Obtener Llave por llaeID
-- =============================================
CREATE PROCEDURE LLAVE_GetLlaveByLlaveID
	-- Add the parameters for the stored procedure here
	@LlaveId int
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
	  FROM [dbo].[tbl_LLaves]
	  WHERE [LlaveId] = @LlaveId

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

PRINT 'Actualizando a la version 0.7.0'

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


IF @intVersionMayor IS NULL OR @intVersionMenor IS NULL OR NOT (@intVersionMayor = 0 AND @intVersionMenor = 6 AND @intPatch = 2)
BEGIN
	
	RAISERROR('La base de datos no esta en la version 0.6.2 Este script solamente se apllica a la version 0.6.2',16,127)
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
           ,0)
GO
