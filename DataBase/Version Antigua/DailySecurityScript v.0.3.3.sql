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
/****** Object:  Table [dbo].[tbl_Alarma]    Script Date: 24/4/2018 21:02:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Alarma](
	[AlarmaId] [int] IDENTITY(1,1) NOT NULL,
	[Codigo] [nchar](10) NULL,
	[Estado] [nchar](10) NULL,
	[Alerta] [nchar](10) NULL,
	[Latitud] [varchar](20) NULL,
	[Longitud] [varchar](20) NULL,
 CONSTRAINT [PK_tbl_Alarma] PRIMARY KEY CLUSTERED 
(
	[AlarmaId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_LLaves]    Script Date: 24/4/2018 21:02:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_LLaves](
	[LlaveId] [int] IDENTITY(1,1) NOT NULL,
	[Codigo] [varchar](50) NULL,
	[Estado] [bit] NULL,
	[HoraInicio] [datetime] NULL,
	[HoraFin] [datetime] NULL,
	[FechaInicio] [date] NULL,
	[FechaFin] [date] NOT NULL,
	[UsuarioId] [int] NULL,
	[AlarmaId] [int] NULL,
 CONSTRAINT [PK_tbl_LLaves] PRIMARY KEY CLUSTERED 
(
	[LlaveId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_Permisos]    Script Date: 24/4/2018 21:02:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Permisos](
	[PermisosId] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](20) NULL,
	[Estado] [bit] NULL,
 CONSTRAINT [PK_tbl_Permisos] PRIMARY KEY CLUSTERED 
(
	[PermisosId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_Recuperacion_de_password]    Script Date: 24/4/2018 21:02:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Recuperacion_de_password](
	[RecuperacionId] [int] IDENTITY(1,1) NOT NULL,
	[Codigo] [nvarchar](8) NOT NULL,
	[HorarioInicio] [datetime] NOT NULL,
	[HorarioFin] [datetime] NOT NULL,
	[UsuarioId] [int] NOT NULL,
	[Estado] [nchar](1) NOT NULL,
 CONSTRAINT [PK_tbl_Recuperacion_de_password] PRIMARY KEY CLUSTERED 
(
	[RecuperacionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_Reporte]    Script Date: 24/4/2018 21:02:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Reporte](
	[ReporteId] [int] IDENTITY(1,1) NOT NULL,
	[Tiempo] [datetime] NULL,
	[AlarmaId] [int] NULL,
 CONSTRAINT [PK_tbl_Reporte] PRIMARY KEY CLUSTERED 
(
	[ReporteId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_Roles]    Script Date: 24/4/2018 21:02:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Roles](
	[RolesId] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](20) NULL,
	[Estado] [bit] NULL,
 CONSTRAINT [PK_tbl_Roles] PRIMARY KEY CLUSTERED 
(
	[RolesId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_RolPermiso]    Script Date: 24/4/2018 21:02:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_RolPermiso](
	[RolPermisoId] [int] IDENTITY(1,1) NOT NULL,
	[RolId] [int] NULL,
	[PermisosId] [int] NULL,
 CONSTRAINT [PK_tbl_RolPermiso] PRIMARY KEY CLUSTERED 
(
	[RolPermisoId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_Usuario]    Script Date: 24/4/2018 21:02:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Usuario](
	[UsuarioId] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](30) NULL,
	[Apellido] [varchar](30) NOT NULL,
	[Telefono] [nchar](11) NOT NULL,
	[Correo] [nvarchar](50) NULL,
	[Contraseña] [nchar](50) NULL,
	[Tipo] [int] NULL,
	[UsuarioDueño] [int] NULL,
	[EstadoEspera] [bit] NULL,
	[EstadoCuenta] [bit] NULL,
 CONSTRAINT [PK_tbl_Usuario] PRIMARY KEY CLUSTERED 
(
	[UsuarioId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_UsuarioRol]    Script Date: 24/4/2018 21:02:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_UsuarioRol](
	[UsuarioRolId] [int] IDENTITY(1,1) NOT NULL,
	[UsuarioId] [int] NULL,
	[RolId] [int] NULL,
 CONSTRAINT [PK_tbl_UsuarioRol] PRIMARY KEY CLUSTERED 
(
	[UsuarioRolId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_Verificacion_de_Cuenta]    Script Date: 24/4/2018 21:02:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Verificacion_de_Cuenta](
	[VerificacionId] [int] IDENTITY(1,1) NOT NULL,
	[codigoVerificacion] [varchar](50) NOT NULL,
	[HorarioInicio] [datetime] NOT NULL,
	[HorarioFin] [datetime] NOT NULL,
	[UsuarioId] [int] NOT NULL,
	[Estado] [bit] NOT NULL,
 CONSTRAINT [PK_tbl_Verificacion_de_Cuenta] PRIMARY KEY CLUSTERED 
(
	[VerificacionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblUsuarioPermiso]    Script Date: 24/4/2018 21:02:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblUsuarioPermiso](
	[PermisoUserId] [int] IDENTITY(1,1) NOT NULL,
	[UsuarioId] [int] NULL,
	[PermisoId] [int] NULL,
 CONSTRAINT [PK_tblUsuarioPermiso] PRIMARY KEY CLUSTERED 
(
	[PermisoUserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tbl_LLaves]  WITH CHECK ADD  CONSTRAINT [FK_tbl_LLaves_tbl_Alarma] FOREIGN KEY([AlarmaId])
REFERENCES [dbo].[tbl_Alarma] ([AlarmaId])
GO
ALTER TABLE [dbo].[tbl_LLaves] CHECK CONSTRAINT [FK_tbl_LLaves_tbl_Alarma]
GO
ALTER TABLE [dbo].[tbl_LLaves]  WITH CHECK ADD  CONSTRAINT [FK_tbl_LLaves_tbl_Usuario1] FOREIGN KEY([UsuarioId])
REFERENCES [dbo].[tbl_Usuario] ([UsuarioId])
GO
ALTER TABLE [dbo].[tbl_LLaves] CHECK CONSTRAINT [FK_tbl_LLaves_tbl_Usuario1]
GO
ALTER TABLE [dbo].[tbl_Recuperacion_de_password]  WITH CHECK ADD  CONSTRAINT [FK_tbl_Recuperacion_de_password_tbl_Usuario] FOREIGN KEY([UsuarioId])
REFERENCES [dbo].[tbl_Usuario] ([UsuarioId])
GO
ALTER TABLE [dbo].[tbl_Recuperacion_de_password] CHECK CONSTRAINT [FK_tbl_Recuperacion_de_password_tbl_Usuario]
GO
ALTER TABLE [dbo].[tbl_Reporte]  WITH CHECK ADD  CONSTRAINT [FK_tbl_Reporte_tbl_Alarma] FOREIGN KEY([ReporteId])
REFERENCES [dbo].[tbl_Alarma] ([AlarmaId])
GO
ALTER TABLE [dbo].[tbl_Reporte] CHECK CONSTRAINT [FK_tbl_Reporte_tbl_Alarma]
GO
ALTER TABLE [dbo].[tbl_RolPermiso]  WITH CHECK ADD  CONSTRAINT [FK_tbl_RolPermiso_tbl_Permisos] FOREIGN KEY([PermisosId])
REFERENCES [dbo].[tbl_Permisos] ([PermisosId])
GO
ALTER TABLE [dbo].[tbl_RolPermiso] CHECK CONSTRAINT [FK_tbl_RolPermiso_tbl_Permisos]
GO
ALTER TABLE [dbo].[tbl_RolPermiso]  WITH CHECK ADD  CONSTRAINT [FK_tbl_RolPermiso_tbl_Roles] FOREIGN KEY([RolId])
REFERENCES [dbo].[tbl_Roles] ([RolesId])
GO
ALTER TABLE [dbo].[tbl_RolPermiso] CHECK CONSTRAINT [FK_tbl_RolPermiso_tbl_Roles]
GO
ALTER TABLE [dbo].[tbl_Usuario]  WITH CHECK ADD  CONSTRAINT [FK_tbl_Usuario_tbl_Usuario] FOREIGN KEY([UsuarioDueño])
REFERENCES [dbo].[tbl_Usuario] ([UsuarioId])
GO
ALTER TABLE [dbo].[tbl_Usuario] CHECK CONSTRAINT [FK_tbl_Usuario_tbl_Usuario]
GO
ALTER TABLE [dbo].[tbl_UsuarioRol]  WITH CHECK ADD  CONSTRAINT [FK_tbl_UsuarioRol_tbl_Roles] FOREIGN KEY([RolId])
REFERENCES [dbo].[tbl_Roles] ([RolesId])
GO
ALTER TABLE [dbo].[tbl_UsuarioRol] CHECK CONSTRAINT [FK_tbl_UsuarioRol_tbl_Roles]
GO
ALTER TABLE [dbo].[tbl_UsuarioRol]  WITH CHECK ADD  CONSTRAINT [FK_tbl_UsuarioRol_tbl_Usuario] FOREIGN KEY([UsuarioId])
REFERENCES [dbo].[tbl_Usuario] ([UsuarioId])
GO
ALTER TABLE [dbo].[tbl_UsuarioRol] CHECK CONSTRAINT [FK_tbl_UsuarioRol_tbl_Usuario]
GO
ALTER TABLE [dbo].[tbl_Verificacion_de_Cuenta]  WITH CHECK ADD  CONSTRAINT [FK_tbl_Verificacion_de_Cuenta_tbl_Usuario] FOREIGN KEY([UsuarioId])
REFERENCES [dbo].[tbl_Usuario] ([UsuarioId])
GO
ALTER TABLE [dbo].[tbl_Verificacion_de_Cuenta] CHECK CONSTRAINT [FK_tbl_Verificacion_de_Cuenta_tbl_Usuario]
GO
ALTER TABLE [dbo].[tblUsuarioPermiso]  WITH CHECK ADD  CONSTRAINT [FK_tblUsuarioPermiso_tbl_Usuario] FOREIGN KEY([PermisoId])
REFERENCES [dbo].[tbl_Permisos] ([PermisosId])
GO
ALTER TABLE [dbo].[tblUsuarioPermiso] CHECK CONSTRAINT [FK_tblUsuarioPermiso_tbl_Usuario]
GO
ALTER TABLE [dbo].[tblUsuarioPermiso]  WITH CHECK ADD  CONSTRAINT [FK_tblUsuarioPermiso_tbl_Usuario1] FOREIGN KEY([UsuarioId])
REFERENCES [dbo].[tbl_Usuario] ([UsuarioId])
GO
ALTER TABLE [dbo].[tblUsuarioPermiso] CHECK CONSTRAINT [FK_tblUsuarioPermiso_tbl_Usuario1]
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
CREATE PROCEDURE [dbo].[RECUPERACION_DeleteRecuperacion]
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
CREATE PROCEDURE [dbo].[RECUPERACION_GetRecuperacionByCodigoAndUsuarioID]
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
/****** Object:  StoredProcedure [dbo].[RECUPERACION_GetRecuperacionById]    Script Date: 24/4/2018 21:02:09 ******/
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
/****** Object:  StoredProcedure [dbo].[RECUPERACION_GetRecuperacionByUsuarioId]    Script Date: 24/4/2018 21:02:09 ******/
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
/****** Object:  StoredProcedure [dbo].[RECUPERACION_InsertarRecuperacion]    Script Date: 24/4/2018 21:02:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Lizeth Quispe
-- Create date: 21/04/2018
-- Description:	Registro nueva recuperacion
-- =============================================
CREATE PROCEDURE [dbo].[RECUPERACION_InsertarRecuperacion]
	@pCodigo nvarchar(8),
	@pHorarioInicio datetime,
	@pHorarioFin datetime,
	@pUsuarioId int,
	@pRecuperacionId INT OUTPUT
AS

BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON; 

	UPDATE [dbo].[tbl_Recuperacion_de_password]
	SET [Estado] = 'E'
	WHERE UsuarioId =@pUsuarioId;

	INSERT INTO [dbo].[tbl_Recuperacion_de_password]
			   (Codigo
			   ,[HorarioInicio]
			   ,[HorarioFin]
			   ,[UsuarioId]
			   ,[Estado])
     VALUES
           (@pCodigo
		   ,@pHorarioInicio
           ,@pHorarioFin
           ,@pUsuarioId
           ,'P')
		   SET @pRecuperacionId=SCOPE_IDENTITY() 
END

GO
/****** Object:  StoredProcedure [dbo].[USER_DeleteUsuario]    Script Date: 24/4/2018 21:02:09 ******/
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
/****** Object:  StoredProcedure [dbo].[USER_GetUsuarioByEmail]    Script Date: 24/4/2018 21:02:09 ******/
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
/****** Object:  StoredProcedure [dbo].[USER_GetUsuarioById]    Script Date: 24/4/2018 21:02:09 ******/
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
/****** Object:  StoredProcedure [dbo].[USER_GetUsuarios]    Script Date: 24/4/2018 21:02:09 ******/
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
CREATE PROCEDURE [dbo].[USER_InsertarUsuario]
	  
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
	   SET [EstadoEspera] = 1  
	 WHERE UsuarioId=@UsuarioId 

END
GO
/****** Object:  StoredProcedure [dbo].[USER_UpdateUsuario]    Script Date: 24/4/2018 21:02:09 ******/
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
/****** Object:  StoredProcedure [dbo].[USER_UpdateUsuarioPassword]    Script Date: 24/4/2018 21:02:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Lizeth Quispe
-- Create date: 21/04/2018
-- Description:	Cambiar contraseña de Usuario
-- =============================================
CREATE PROCEDURE [dbo].[USER_UpdateUsuarioPassword]
	@pUsuarioId int,
	@pContrasenaNueva nchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	UPDATE [dbo].[tbl_Usuario]
	   SET [Contraseña] = @pContrasenaNueva
	 WHERE UsuarioId = @pUsuarioId

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
