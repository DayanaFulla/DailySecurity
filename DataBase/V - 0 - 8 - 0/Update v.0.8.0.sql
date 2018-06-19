use DailySecurityDB;

alter table tbl_llaves ADD ActHora int null;
alter table tbl_llaves ADD ActDias int null;

USE [DailySecurityDB]
GO
/****** Object:  StoredProcedure [dbo].[LLAVE_InsertLlaveTemporal]    Script Date: 18/06/2018 17:02:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Lizeth Quispe
-- Create date: 08/06/2018
-- Description:	Insert solo para llaves Temporales, para evitar errores
-- =============================================
ALTER PROCEDURE [dbo].[LLAVE_InsertLlaveTemporal]
	-- Add the parameters for the stored procedure here
	@Codigo varchar(50),
	@Estado int,
	@Tipo nchar(1),-- aqui se define el tipo si es temporal o permanente
	@Nick nvarchar(30),
	@HoraInicio time,
	@HoraFin time,
	@FechaInicio date,
	@FechaFin date,
	@AlarmaId int,
	@Dias nvarchar(21),
	@ActHora int,
	@ActDias int,
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
			   ,[Dias]
			   ,[ActHora]
			   ,[ActDias])
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
			   ,@Dias
			   ,@ActHora
			   ,@ActDias)
	
END
GO
-- /////////////////////////////////////////////

USE [DailySecurityDB]
GO
/****** Object:  StoredProcedure [dbo].[LLAVE_InsertLlavePermanente]    Script Date: 18/06/2018 17:07:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Lizeth Quispe
-- Create date: 08/06/2018
-- Description:	Insert solo para llaves permanentes
-- =============================================
ALTER PROCEDURE [dbo].[LLAVE_InsertLlavePermanente]
	-- Add the parameters for the stored procedure here
	@Codigo varchar(50),
	@Estado int,
	@Tipo nchar(1),
	@Nick nvarchar(30),
	@AlarmaId int,
	@HoraInicio time,
	@HoraFin time,
	@Dias nvarchar(21),
	@ActHora int,
	@ActDias int,
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
			   ,[Nick]
			   ,[ActDias]
			   ,[ActHora]
			   ,[Dias]
			   ,[HoraInicio]
			   ,[HoraFin])
		 VALUES
			   (@Codigo
			   ,@Estado
			   ,@AlarmaId
			   ,@Tipo
			   ,@Nick
			   ,@ActDias
			   ,@ActHora
			   ,@Dias
			   ,@HoraInicio
			   ,@HoraFin)
	
END
GO
-- //////////////////////////////////////////////

USE [DailySecurityDB]
GO
/****** Object:  StoredProcedure [dbo].[LLAVE_GetLlaveByCodigo]    Script Date: 18/06/2018 17:15:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Lizeth Quispe
-- Create date: 08/06/2018
-- Description:	Obtener Alarma por codigo asignado
-- =============================================
ALTER PROCEDURE [dbo].[LLAVE_GetLlaveByCodigo]
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
			,[ActHora]
			,[ActDias]
		FROM [dbo].[tbl_LLaves]
		WHERE Codigo = @Codigo
END
GO

-- //////////////////////////////////////////

USE [DailySecurityDB]
GO
/****** Object:  StoredProcedure [dbo].[LLAVE_GetLlaveByLlaveID]    Script Date: 18/06/2018 17:17:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Lizeth Quispe
-- Create date: 08/06/2018
-- Description:	Obtener Llave por llaeID
-- =============================================
ALTER PROCEDURE [dbo].[LLAVE_GetLlaveByLlaveID]
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
			,[ActHora]
			,[ActDias]
	  FROM [dbo].[tbl_LLaves]
	  WHERE [LlaveId] = @LlaveId

END
GO
-- ////////////////////////////////////////////////////

USE [DailySecurityDB]
GO
/****** Object:  StoredProcedure [dbo].[LLAVE_GetLlavesByAlarmaId]    Script Date: 18/06/2018 17:18:47 ******/
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
	  WHERE AlarmaId = @AlarmaId and UsuarioId <> @UsuarioId

END
GO
-- //////////////////////////////////////////////////////////

USE [DailySecurityDB]
GO
/****** Object:  StoredProcedure [dbo].[LLAVE_GetLlavesByUsuarioId]    Script Date: 18/06/2018 17:19:42 ******/
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
	  FROM tbl_LLaves L join tbl_Alarma A on L.UsuarioId = A.UsuarioId
	  WHERE A.UsuarioId <> L.UsuarioId

END
GO
-- ////////////////////////////////////////////////////////////

USE [DailySecurityDB]
GO
/****** Object:  StoredProcedure [dbo].[LLAVE_GetLlavesPropietario]    Script Date: 18/06/2018 17:22:38 ******/
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
			,L.[ActHora]
			,L.[ActDias]
		  ,A.Nombre Nombre
	  FROM tbl_LLaves L  join tbl_Alarma A on L.AlarmaId = A.AlarmaId
	  WHERE A.UsuarioId = @UsuarioID and L.UsuarioId = @UsuarioID

END
GO

-- ////////////////////////////////////////////////////////////////////

USE [DailySecurityDB]
GO
/****** Object:  StoredProcedure [dbo].[LLAVE_UpdateLlave]    Script Date: 18/06/2018 17:24:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Lizeth Quispe
-- Create date: 08/06/2018
-- Description:	Editar Configuracion de llave prestada
-- =============================================
ALTER PROCEDURE [dbo].[LLAVE_UpdateLlave]
	-- Add the parameters for the stored procedure here
	@Nick nvarchar(30),
	@Estado int,
	@Tipo nchar(1),
	@HoraInicio time,
	@HoraFin time,
	@FechaInicio date,
	@FechaFin date,
	@Dias nvarchar(21),
	@Nombre nvarchar(30),
	@ActHora int,
	@ActDias int,
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
		  ,[ActHora] = @ActHora
		  ,[ActDias] = @ActDias
	 WHERE [LlaveId] = @LlaveId
END
GO
-- //////////////////////////////////////////////////////////////

USE [DailySecurityDB]
GO
/****** Object:  StoredProcedure [dbo].[LLAVE_UpdateLlave]    Script Date: 18/06/2018 17:24:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Lizeth Quispe
-- Create date: 08/06/2018
-- Description:	Editar Configuracion de llave prestada
-- =============================================
ALTER PROCEDURE [dbo].[LLAVE_UpdateLlave]
	-- Add the parameters for the stored procedure here
	@Nick nvarchar(30),
	@Estado int,
	@Tipo nchar(1),
	@HoraInicio time,
	@HoraFin time,
	@FechaInicio date,
	@FechaFin date,
	@Dias nvarchar(21),
	@Nombre nvarchar(30),
	@ActHora int,
	@ActDias int,
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
		  ,[ActHora] = @ActHora
		  ,[ActDias] = @ActDias
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

PRINT 'Actualizando a la version 0.8.0'

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


IF @intVersionMayor IS NULL OR @intVersionMenor IS NULL OR NOT (@intVersionMayor = 0 AND @intVersionMenor = 7 AND @intPatch = 1)
BEGIN
	
	RAISERROR('La base de datos no esta en la version 0.7.1 Este script solamente se apllica a la version 0.7.1',16,127)
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
           ,0)
GO
