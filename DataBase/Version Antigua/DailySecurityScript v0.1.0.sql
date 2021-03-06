/*    ==Scripting Parameters==

    Source Server Version : SQL Server 2016 (13.0.4001)
    Source Database Engine Edition : Microsoft SQL Server Express Edition
    Source Database Engine Type : Standalone SQL Server

    Target Server Version : SQL Server 2017
    Target Database Engine Edition : Microsoft SQL Server Standard Edition
    Target Database Engine Type : Standalone SQL Server
*/
USE [master]
GO
/****** Object:  Database [DailySecurityDB]    Script Date: 28/3/2018 17:06:15 ******/
CREATE DATABASE [DailySecurityDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'DailySecurityDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.SQLEXPRESS\MSSQL\DATA\DailySecurityDB.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'DailySecurityDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.SQLEXPRESS\MSSQL\DATA\DailySecurityDB_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [DailySecurityDB] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [DailySecurityDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [DailySecurityDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [DailySecurityDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [DailySecurityDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [DailySecurityDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [DailySecurityDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [DailySecurityDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [DailySecurityDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [DailySecurityDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [DailySecurityDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [DailySecurityDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [DailySecurityDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [DailySecurityDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [DailySecurityDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [DailySecurityDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [DailySecurityDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [DailySecurityDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [DailySecurityDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [DailySecurityDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [DailySecurityDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [DailySecurityDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [DailySecurityDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [DailySecurityDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [DailySecurityDB] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [DailySecurityDB] SET  MULTI_USER 
GO
ALTER DATABASE [DailySecurityDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [DailySecurityDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [DailySecurityDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [DailySecurityDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [DailySecurityDB] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [DailySecurityDB] SET QUERY_STORE = OFF
GO
USE [DailySecurityDB]
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO
USE [DailySecurityDB]
GO
/****** Object:  Table [dbo].[tbl_Alarma]    Script Date: 28/3/2018 17:06:16 ******/
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
/****** Object:  Table [dbo].[tbl_LLaves]    Script Date: 28/3/2018 17:06:16 ******/
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
/****** Object:  Table [dbo].[tbl_Permisos]    Script Date: 28/3/2018 17:06:16 ******/
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
/****** Object:  Table [dbo].[tbl_Reporte]    Script Date: 28/3/2018 17:06:16 ******/
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
/****** Object:  Table [dbo].[tbl_Roles]    Script Date: 28/3/2018 17:06:16 ******/
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
/****** Object:  Table [dbo].[tbl_RolPermiso]    Script Date: 28/3/2018 17:06:16 ******/
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
/****** Object:  Table [dbo].[tbl_Usuario]    Script Date: 28/3/2018 17:06:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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
/****** Object:  Table [dbo].[tbl_UsuarioRol]    Script Date: 28/3/2018 17:06:16 ******/
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
/****** Object:  Table [dbo].[tblUsuarioPermiso]    Script Date: 28/3/2018 17:06:16 ******/
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
