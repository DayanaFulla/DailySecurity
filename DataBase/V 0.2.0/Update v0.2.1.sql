USE [DailySecurityDB]
GO

--cambio aqui
ALTER TABLE [dbo].[tbl_Recuperacion_de_password] ADD
	[Estado] [bigint] NULL
GO



ALTER TABLE [dbo].[tbl_LLaves] CHECK CONSTRAINT [FK_tbl_LLaves_tbl_Alarma]
GO


ALTER TABLE [dbo].[tbl_LLaves] CHECK CONSTRAINT [FK_tbl_LLaves_tbl_Usuario1]
GO


ALTER TABLE [dbo].[tbl_Recuperacion_de_password] CHECK CONSTRAINT [FK_tbl_Recuperacion_de_password_tbl_Usuario]
GO

ALTER TABLE [dbo].[tbl_Reporte] CHECK CONSTRAINT [FK_tbl_Reporte_tbl_Alarma]
GO

ALTER TABLE [dbo].[tbl_RolPermiso] CHECK CONSTRAINT [FK_tbl_RolPermiso_tbl_Permisos]
GO

ALTER TABLE [dbo].[tbl_RolPermiso] CHECK CONSTRAINT [FK_tbl_RolPermiso_tbl_Roles]
GO

ALTER TABLE [dbo].[tbl_Usuario] CHECK CONSTRAINT [FK_tbl_Usuario_tbl_Usuario]
GO

ALTER TABLE [dbo].[tbl_UsuarioRol] CHECK CONSTRAINT [FK_tbl_UsuarioRol_tbl_Roles]
GO

ALTER TABLE [dbo].[tbl_UsuarioRol] CHECK CONSTRAINT [FK_tbl_UsuarioRol_tbl_Usuario]
GO

ALTER TABLE [dbo].[tbl_Verificacion_de_Cuenta] CHECK CONSTRAINT [FK_tbl_Verificacion_de_Cuenta_tbl_Usuario]
GO

ALTER TABLE [dbo].[tblUsuarioPermiso] CHECK CONSTRAINT [FK_tblUsuarioPermiso_tbl_Usuario]
GO

ALTER TABLE [dbo].[tblUsuarioPermiso] CHECK CONSTRAINT [FK_tblUsuarioPermiso_tbl_Usuario1]
GO

/****** Object:  StoredProcedure [dbo].[RECUPERACION_DeletedCodigo]    Script Date: 21/4/2018 16:58:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Dayana Fullá
-- Create date: 21/04/18
-- Description:	Actualizar Codigo de recuperacion de contraseña
-- =============================================
CREATE PROCEDURE [dbo].[RECUPERACION_DeletedCodigo]
	@RecuperacionId int 
AS
BEGIN
	
	SET NOCOUNT ON;


DELETE FROM [dbo].[tbl_Recuperacion_de_password]
      WHERE RecuperacionId=@RecuperacionId








END
GO

/****** Object:  StoredProcedure [dbo].[RECUPERACION_GetRecuperacionById]    Script Date: 21/4/2018 16:58:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Dayana Fullá
-- Create date: 21/04/18
-- Description:	Obtener Codigo de Recuperacion con Id
-- =============================================
CREATE PROCEDURE [dbo].[RECUPERACION_GetRecuperacionById]
	@RecuperacionId int 
AS
BEGIN
	
	SET NOCOUNT ON;

SELECT *
FROM [dbo].[tbl_Recuperacion_de_password]
WHERE RecuperacionId=@RecuperacionId


END
GO

/****** Object:  StoredProcedure [dbo].[RECUPERACION_GetRecuperacionByUsuarioId]    Script Date: 21/4/2018 16:58:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Dayana Fullá
-- Create date: 21/04/18
-- Description:	Obtener Codigos de Recuperacion con UsuarioId
-- =============================================
CREATE PROCEDURE [dbo].[RECUPERACION_GetRecuperacionByUsuarioId]
	@UsuarioId int 
AS
BEGIN
	
	SET NOCOUNT ON;

SELECT *
FROM [dbo].[tbl_Recuperacion_de_password]
WHERE UsuarioId=@UsuarioId


END
GO

/****** Object:  StoredProcedure [dbo].[RECUPERACION_GetRecuperacionByUsuarioIdAndRecuperacionid]    Script Date: 21/4/2018 16:58:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Dayana Fullá
-- Create date: 21/04/18
-- Description:	Obtener Codigos de Recuperacion con UsuarioId y Recuperacion id
-- =============================================
CREATE PROCEDURE [dbo].[RECUPERACION_GetRecuperacionByUsuarioIdAndRecuperacionid]
	@UsuarioId int, 
	@RecuperacionId int  
AS
BEGIN
	
	SET NOCOUNT ON;

SELECT *
FROM [dbo].[tbl_Recuperacion_de_password]
WHERE UsuarioId=@UsuarioId and RecuperacionId=@RecuperacionId


END
GO

/****** Object:  StoredProcedure [dbo].[RECUPERACION_InsertarCodigo]    Script Date: 21/4/2018 16:58:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Dayana Fullá
-- Create date: 21/04/18
-- Description:	Insertar Código de Recuperación de contraseña
-- =============================================
CREATE PROCEDURE [dbo].[RECUPERACION_InsertarCodigo]
	@codigo ntext,
    @fecha datetime, 
    @limiteHora datetime,
    @UsuarioId int, 
	@Estado bigint, 
	@RecuperacionId int OUTPUT
AS
BEGIN
	
	SET NOCOUNT ON;


INSERT INTO [dbo].[tbl_Recuperacion_de_password]
           ([codigo]
           ,[fecha]
           ,[limiteHora]
           ,[UsuarioId]
           ,[Estado])
     VALUES
           (@codigo, 
		   @fecha, 
		   @limiteHora, 
		   @UsuarioId, 
		   @Estado)
SET @RecuperacionId=SCOPE_IDENTITY() 




END
GO

/****** Object:  StoredProcedure [dbo].[RECUPERACION_UpdateCodigo]    Script Date: 21/4/2018 16:58:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Dayana Fullá
-- Create date: 21/04/18
-- Description:	Actualizar Codigo de recuperacion de contraseña
-- =============================================
CREATE PROCEDURE [dbo].[RECUPERACION_UpdateCodigo]
	@codigo ntext,
    @fecha datetime, 
    @limiteHora datetime,
    @UsuarioId int, 
	@estado bigint, 
	@RecuperacionId int 
AS
BEGIN
	
	SET NOCOUNT ON;

UPDATE [dbo].[tbl_Recuperacion_de_password]
   SET [codigo] = @codigo
      ,[fecha] = @fecha
      ,[limiteHora] = @limiteHora
      ,[UsuarioId] = @UsuarioId
      ,[Estado] = @estado
 WHERE RecuperacionId=@RecuperacionId





END
GO

/****** Object:  StoredProcedure [dbo].[USER_DeleteUsuario]    Script Date: 21/4/2018 16:58:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Dayana Fullá
-- Create date: 21/04/18
-- Description:	Eliminar Usuario
-- =============================================
CREATE PROCEDURE [dbo].[USER_DeleteUsuario]
	@UsuarioId INT  
AS
BEGIN
	
	SET NOCOUNT ON;


DELETE FROM [dbo].[tbl_Usuario]
      WHERE UsuarioId=@UsuarioId

END
GO


/****** Object:  StoredProcedure [dbo].[USER_GetUsuarioByEmail]    Script Date: 21/4/2018 16:58:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Dayana Fullá
-- Create date: 21/04/18
-- Description:	Obtener usuario por e-mail
-- =============================================
CREATE PROCEDURE [dbo].[USER_GetUsuarioByEmail]
	@Email NVARCHAR(50) 
AS
BEGIN
	
	SET NOCOUNT ON;

	SELECT * 
	FROM tbl_Usuario
	WHERE Correo=@Email;

	
END
GO

/****** Object:  StoredProcedure [dbo].[USER_GetUsuarioById]    Script Date: 21/4/2018 16:58:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Dayana Fullá
-- Create date: 21/04/18
-- Description:	Obtener el id del usuario
-- =============================================
CREATE PROCEDURE [dbo].[USER_GetUsuarioById]
	@UsuarioId int 
AS
BEGIN
	
	SET NOCOUNT ON;

	SELECT * 
	FROM tbl_Usuario
	WHERE [UsuarioId]=@UsuarioId; 

	
END
GO


/****** Object:  StoredProcedure [dbo].[USER_GetUsuarios]    Script Date: 21/4/2018 16:58:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Dayana Fulla
-- Create date: 21/04/18
-- Description:	Obtener Usuarios
-- =============================================
CREATE PROCEDURE [dbo].[USER_GetUsuarios] 
	
AS
BEGIN
	
	SET NOCOUNT ON;


SELECT [UsuarioId]
      ,[Nombre]
      ,[Apellido]
      ,[Telefono]
      ,[Correo]
      ,[Contraseña]
      ,[Tipo]
      ,[UsuarioDueño]
      ,[EstadoEspera]
      ,[EstadoCuenta]
  FROM [dbo].[tbl_Usuario]



END
GO

/****** Object:  StoredProcedure [dbo].[USER_InsertarUsuario]    Script Date: 21/4/2018 16:58:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Dayana Fullá
-- Create date: 21/04/18
-- Description:	Insertar Usuario
-- =============================================
CREATE PROCEDURE [dbo].[USER_InsertarUsuario]
	  
	 @Nombre varchar(30),
     @Apellido varchar(30),
     @Telefono nchar(11),
     @Correo nvarchar(50),
     @Contraseña nchar(20),
     @Tipo int,
     @UsuarioDueño int,
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
           @Tipo, 
           @UsuarioDueño, 
           0,
           0)
	SET @intUsuarioId=SCOPE_IDENTITY() 



	
END
GO


/****** Object:  StoredProcedure [dbo].[USER_UpdateUsuario]    Script Date: 21/4/2018 16:58:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Dayana Fullá
-- Create date: 21/04/18
-- Description:	Actualizar Usuario
-- =============================================
CREATE PROCEDURE [dbo].[USER_UpdateUsuario]
	@Nombre VARCHAR(30), 
	@Apellido VARCHAR(30),  
	@Telefono NCHAR(11),
	@tipo INT, 
	@UsuarioDueño INT,
	@UsuarioId INT  
AS
BEGIN
	
	SET NOCOUNT ON;

UPDATE [dbo].[tbl_Usuario]
   SET [Nombre] = @Nombre
      ,[Apellido] = @Apellido
      ,[Telefono] = @Telefono
	  ,[Tipo] = @tipo 
      ,[UsuarioDueño] = @UsuarioDueño
 WHERE UsuarioId=@UsuarioId



END
GO