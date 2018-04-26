USE [DailySecurityDB]
GO

/****** Object:  Table [dbo].[tbl_LLaves]    Script Date: 24/4/2018 21:02:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER TABLE TBL_USUARIO ALTER COLUMN EstadoEspera BIT;
ALTER TABLE TBL_USUARIO ALTER COLUMN EstadoCuenta BIT;
GO

ALTER TABLE TBL_VERIFICACIOIN_DE_CUENTA ALTER COLUMN codigoVerificacion VARCHAR(50);
GO

EXEC sp_rename 'tbl_Verificacion_de_Cuenta.limiteHora', 'HorarioInicio','COLUMN';
EXEC sp_rename 'tbl_Verificacion_de_Cuenta.FechaRegistro', 'HorarioFin','COLUMN';

ALTER TABLE TBL_VERIFICACION_DE_CUENTA ADD ESTADO BIT NOT NULL;
GO

/****** Object:  StoredProcedure [dbo].[RECUPERACION_DeleteRecuperacion]    Script Date: 24/4/2018 21:02:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Lizeth Quispe
-- Create date: 21/04/2018
-- Description:	Cambiar estado de Recuperacion a Eliminado
-- =============================================
ALTER PROCEDURE [dbo].[RECUPERACION_DeleteRecuperacion]
	@RecuperacionId int 
AS
BEGIN
	SET NOCOUNT ON;
		UPDATE [dbo].[tbl_Recuperacion_de_password]
		   SET [Estado] = 'E'
		 WHERE RecuperacionId = @RecuperacionId
END

GO
/****** Object:  StoredProcedure [dbo].[RECUPERACION_GetRecuperacionByCodigoAndUsuarioID]    Script Date: 24/4/2018 21:02:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[RECUPERACION_GetRecuperacionByCodigoAndUsuarioID]
	@pCodigo nvarchar(8),
	@pUsuarioId int
AS
BEGIN

	SET NOCOUNT ON;
	select * 
	from tbl_Recuperacion_de_password
	WHERE @pUsuarioId = @pUsuarioId and Codigo = @pCodigo;
END

GO

/****** Object:  StoredProcedure [dbo].[USER_InsertarUsuario]    Script Date: 24/4/2018 21:02:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Dayana Fullá
-- Create date: 21/04/18
-- Description:	Insertar Usuario
-- =============================================
ALTER PROCEDURE [dbo].[USER_InsertarUsuario]
	  
	 @Nombre varchar(30),
     @Apellido varchar(30),
     @Telefono nchar(11),
     @Correo nvarchar(50),
     @Contraseña nchar(50),
	 @intUsuarioId INT OUTPUT  
AS
BEGIN
	
	SET NOCOUNT ON;


INSERT INTO [dbo].[tbl_Usuario]
           ([Nombre]
           ,[Apellido]
           ,[Telefono]
           ,[Correo]
           ,[Contraseña]
           ,[Tipo]
           ,[UsuarioDueño]
           ,[EstadoEspera]
           ,[EstadoCuenta])
     VALUES
           (@Nombre,
           @Apellido, 
           @Telefono, 
           @Correo, 
           @Contraseña, 
           1, 
           null, 
           0,
           0)
	SET @intUsuarioId=SCOPE_IDENTITY() 
	
END

GO

/****** Object:  StoredProcedure [dbo].[USER_UpdateEstadoEsperaUsuario]    Script Date: 24/4/2018 21:02:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Dayana Fullá
-- Create date: 21/04/18
-- Description:	Actualizar estado Espera del usuario
-- =============================================
CREATE PROCEDURE [dbo].[USER_UpdateEstadoEsperaUsuario]
	@UsuarioId INT 
AS
BEGIN
	
	SET NOCOUNT ON;

	UPDATE [dbo].[tbl_Usuario]
	   SET [EstadoEspera] = 0  
	 WHERE UsuarioId=@UsuarioId 

END
GO

/****** Object:  StoredProcedure [dbo].[VERIFICACION_DeleteVerficacion]    Script Date: 24/4/2018 21:02:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Dayana Fullá
-- Create date: 21/04/18
-- Description:	Eliminar Verificacion
-- =============================================
CREATE PROCEDURE [dbo].[VERIFICACION_DeleteVerficacion]
	@UsuarioId INT, 
	@VerificacionId INT 
AS
BEGIN
	
	SET NOCOUNT ON;

DELETE FROM [dbo].[tbl_Verificacion_de_Cuenta]
      WHERE UsuarioId=@UsuarioId and VerificacionId=@VerificacionId 

END
GO

/****** Object:  StoredProcedure [dbo].[VERIFICACION_GetVerificacionByCodigo]    Script Date: 24/4/2018 21:02:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Dayana Fullá
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[VERIFICACION_GetVerificacionByCodigo]
	@CodigoVerificacion VARCHAR(50) 
AS
BEGIN
	
	SET NOCOUNT ON;

SELECT [VerificacionId]
      ,[codigoVerificacion]
      ,[HorarioInicio]
      ,[HorarioFin]
      ,[UsuarioId]
      ,[Estado]
  FROM [dbo].[tbl_Verificacion_de_Cuenta]
  WHERE codigoVerificacion=@CodigoVerificacion



END
GO

/****** Object:  StoredProcedure [dbo].[VERIFICACION_GetVerificacionById]    Script Date: 24/4/2018 21:02:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Dayana Fullá
-- Create date: 24/04/18
-- Description:	Obtener Verficacion por Id
-- =============================================
CREATE PROCEDURE [dbo].[VERIFICACION_GetVerificacionById]
	@VerificacionId INT
AS
BEGIN
	
	SET NOCOUNT ON;
	
SELECT [VerificacionId]
      ,[codigoVerificacion]
      ,[HorarioInicio]
      ,[HorarioFin]
      ,[UsuarioId]
      ,[Estado]
  FROM [dbo].[tbl_Verificacion_de_Cuenta]
  WHERE VerificacionId=@VerificacionId


END
GO

/****** Object:  StoredProcedure [dbo].[VERIFICACION_GetVerificacionByUsuarioId]    Script Date: 24/4/2018 21:02:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Dayana Fullá
-- Create date: 24/04/18
-- Description:	Obtener Verficacion por UsuarioId
-- =============================================
CREATE PROCEDURE [dbo].[VERIFICACION_GetVerificacionByUsuarioId]
	@UsuarioId INT 
AS
BEGIN
	
	SET NOCOUNT ON;
	
SELECT [VerificacionId]
      ,[codigoVerificacion]
      ,[HorarioInicio]
      ,[HorarioFin]
      ,[UsuarioId]
      ,[Estado]
  FROM [dbo].[tbl_Verificacion_de_Cuenta]
  WHERE UsuarioId=@UsuarioId


END
GO

/****** Object:  StoredProcedure [dbo].[VERIFICACION_GetVerificacionByUsuarioIdAndCodigo]    Script Date: 24/4/2018 21:02:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Dayana Fullá
-- Create date: 24/04/2018
-- Description:	Obtener Verificacion por Código y UsuarioId
-- =============================================
CREATE PROCEDURE [dbo].[VERIFICACION_GetVerificacionByUsuarioIdAndCodigo]
	@verificacionId INT,
	@codigoVerificacion VARCHAR   
AS
BEGIN
	
	SET NOCOUNT ON;

SELECT [VerificacionId]
      ,[codigoVerificacion]
      ,[HorarioInicio]
      ,[HorarioFin]
      ,[UsuarioId]
      ,[Estado]
  FROM [dbo].[tbl_Verificacion_de_Cuenta]
  WHERE VerificacionId=@verificacionId and codigoVerificacion=@codigoVerificacion

END
GO

/****** Object:  StoredProcedure [dbo].[VERIFICACION_GetVerificaciones]    Script Date: 24/4/2018 21:02:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Dayana Fullá
-- Create date: 24/04/18
-- Description:	Obtener Verificaciones
-- =============================================
CREATE PROCEDURE [dbo].[VERIFICACION_GetVerificaciones]
	
AS
BEGIN
	
	SET NOCOUNT ON;

	SELECT [VerificacionId]
		  ,[codigoVerificacion]
		  ,[HorarioInicio]
		  ,[HorarioFin]
		  ,[UsuarioId]
		  ,[Estado]
	  FROM [dbo].[tbl_Verificacion_de_Cuenta]

END
GO

/****** Object:  StoredProcedure [dbo].[VERIFICACION_InsertarVerificacion]    Script Date: 24/4/2018 21:02:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Dayana Fulla
-- Create date: 24/04/18
-- Description:	Insertar Código de Verificacion
-- =============================================
CREATE PROCEDURE [dbo].[VERIFICACION_InsertarVerificacion]
	@codigoVerificacion NTEXT,
    @HorarioInicio DATETIME,
    @HorarioFin DATETIME,
    @UsuarioId INT,
    @Estado BIT, 
	@VerificacionId INT OUTPUT 
AS
BEGIN
	
	SET NOCOUNT ON;

INSERT INTO [dbo].[tbl_Verificacion_de_Cuenta]
           ([codigoVerificacion]
           ,[HorarioInicio]
           ,[HorarioFin]
           ,[UsuarioId]
           ,[Estado])
     VALUES (@codigoVerificacion, 
			@HorarioInicio, 
			@HorarioFin, 
			@UsuarioId, 
			@Estado)

	SET @VerificacionId=SCOPE_IDENTITY() 

END
GO


/****** Object:  StoredProcedure [dbo].[VERIFICACION_UpdateVerificacion]    Script Date: 24/4/2018 21:02:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Dayana Fullá
-- Create date: 24/04/18
-- Description:	Actualizar Verificacion
-- =============================================
CREATE PROCEDURE [dbo].[VERIFICACION_UpdateVerificacion]
	@UsuarioId INT, 
	@VerificacionId INT,
	@estado BIT 
AS
BEGIN
	
	SET NOCOUNT ON;

UPDATE [dbo].[tbl_Verificacion_de_Cuenta]
   SET [Estado] = @estado 
 WHERE UsuarioId=@UsuarioId and VerificacionId=@VerificacionId

END
GO
