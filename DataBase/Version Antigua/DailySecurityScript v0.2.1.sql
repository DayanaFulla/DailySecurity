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
/****** Object:  Table [dbo].[tbl_Alarma]    Script Date: 21/4/2018 16:58:32 ******/
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
/****** Object:  Table [dbo].[tbl_LLaves]    Script Date: 21/4/2018 16:58:32 ******/
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
/****** Object:  Table [dbo].[tbl_Permisos]    Script Date: 21/4/2018 16:58:32 ******/
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
/****** Object:  Table [dbo].[tbl_Recuperacion_de_password]    Script Date: 21/4/2018 16:58:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Recuperacion_de_password](
	[RecuperacionId] [int] IDENTITY(1,1) NOT NULL,
	[codigo] [ntext] NOT NULL,
	[fecha] [datetime] NOT NULL,
	[limiteHora] [datetime] NOT NULL,
	[UsuarioId] [int] NULL,
	[Estado] [bigint] NULL,
 CONSTRAINT [PK_tbl_Recuperacion_de_password] PRIMARY KEY CLUSTERED 
(
	[RecuperacionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_Reporte]    Script Date: 21/4/2018 16:58:32 ******/
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
/****** Object:  Table [dbo].[tbl_Roles]    Script Date: 21/4/2018 16:58:32 ******/
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
/****** Object:  Table [dbo].[tbl_RolPermiso]    Script Date: 21/4/2018 16:58:32 ******/
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
/****** Object:  Table [dbo].[tbl_Usuario]    Script Date: 21/4/2018 16:58:32 ******/
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
	[Contraseña] [nchar](20) NULL,
	[Tipo] [int] NULL,
	[UsuarioDueño] [int] NOT NULL,
	[EstadoEspera] [bigint] NOT NULL,
	[EstadoCuenta] [bigint] NOT NULL,
 CONSTRAINT [PK_tbl_Usuario] PRIMARY KEY CLUSTERED 
(
	[UsuarioId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tbl_UsuarioRol]    Script Date: 21/4/2018 16:58:32 ******/
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
/****** Object:  Table [dbo].[tbl_Verificacion_de_Cuenta]    Script Date: 21/4/2018 16:58:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Verificacion_de_Cuenta](
	[VerificacionId] [int] NOT NULL,
	[codigoVerificacion] [ntext] NOT NULL,
	[limiteHora] [datetime] NOT NULL,
	[FechaRegistro] [datetime] NOT NULL,
	[UsuarioId] [int] NULL,
 CONSTRAINT [PK_tbl_Verificacion_de_Cuenta] PRIMARY KEY CLUSTERED 
(
	[VerificacionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblUsuarioPermiso]    Script Date: 21/4/2018 16:58:32 ******/
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
