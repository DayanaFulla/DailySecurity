USE [DailySecurityDB]
GO

CREATE TABLE [dbo].[tbl_Recuperacion_de_password](
	[RecuperacionId] [int] IDENTITY(1,1) NOT NULL,
	[codigo] [ntext] NOT NULL,
	[fecha] [datetime] NOT NULL,
	[limiteHora] [datetime] NOT NULL,
	[UsuarioId] [int] NULL,
 CONSTRAINT [PK_tbl_Recuperacion_de_password] PRIMARY KEY CLUSTERED 
(
	[RecuperacionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO


ALTER TABLE [dbo].[tbl_Usuario] ADD  [EstadoEspera] [bigint] NOT NULL;

ALTER TABLE [dbo].[tbl_Usuario] ADD [EstadoCuenta] [bigint] NOT NULL;

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

ALTER TABLE [dbo].[tbl_LLaves] CHECK CONSTRAINT [FK_tbl_LLaves_tbl_Alarma]
GO

ALTER TABLE [dbo].[tbl_LLaves] CHECK CONSTRAINT [FK_tbl_LLaves_tbl_Usuario1]
GO

ALTER TABLE [dbo].[tbl_Recuperacion_de_password]  WITH CHECK ADD  CONSTRAINT [FK_tbl_Recuperacion_de_password_tbl_Usuario] FOREIGN KEY([UsuarioId])
REFERENCES [dbo].[tbl_Usuario] ([UsuarioId])
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

ALTER TABLE [dbo].[tbl_Verificacion_de_Cuenta]  WITH CHECK ADD  CONSTRAINT [FK_tbl_Verificacion_de_Cuenta_tbl_Usuario] FOREIGN KEY([UsuarioId])
REFERENCES [dbo].[tbl_Usuario] ([UsuarioId])
GO

ALTER TABLE [dbo].[tbl_Verificacion_de_Cuenta] CHECK CONSTRAINT [FK_tbl_Verificacion_de_Cuenta_tbl_Usuario]
GO

ALTER TABLE [dbo].[tblUsuarioPermiso] CHECK CONSTRAINT [FK_tblUsuarioPermiso_tbl_Usuario]
GO

ALTER TABLE [dbo].[tblUsuarioPermiso] CHECK CONSTRAINT [FK_tblUsuarioPermiso_tbl_Usuario1]
GO
