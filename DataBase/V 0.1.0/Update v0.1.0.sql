USE [DailySecurityDB]
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
/****** Object:  Table [dbo].[tbl_Usuario]    Script Date: 28/3/2018 17:06:16 ******/

CREATE TABLE [dbo].[tbl_Usuario](
	[UsuarioId] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](30) NULL,
	[Apellido] [varchar](30) NULL,
	[Telefono] [nchar](11) NULL,
	[Correo] [nchar](25) NULL,
	[Contraseña] [nchar](20) NULL,
	[Tipo] [bit] NULL,
	[UsuarioDueño] [int] NULL,
 CONSTRAINT [PK_tbl_Usuario] PRIMARY KEY CLUSTERED 
(
	[UsuarioId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
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

USE [master]
GO
ALTER DATABASE [DailySecurityDB] SET  READ_WRITE 
GO
