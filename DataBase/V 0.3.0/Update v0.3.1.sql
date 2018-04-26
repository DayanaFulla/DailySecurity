USE [DailySecurityDB]
GO

ALTER TABLE TBL_RECUPERACION_DE_PASSWORD 
ALTER COLUMN ESTADO NCHAR;
GO

ALTER TABLE TBL_USUARIO ALTER COLUMN CORREO NVARCHAR(50);

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

/****** Object:  StoredProcedure [dbo].[RECUPERACION_GetRecuperacionByCodigoAndUsuarioID]    Script Date: 22/04/2018 15:29:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Lizeth Quispe
-- Create date: 22/04/2018
-- Description:	Obtener Recuperacion con ID de usuario  y codigo
-- =============================================
ALTER PROCEDURE [dbo].[RECUPERACION_GetRecuperacionByCodigoAndUsuarioID]
	@pCodigo nvarchar(8),
	@pUsuarioId int
AS
BEGIN

	SET NOCOUNT ON;
	select * 
	from tbl_Recuperacion_de_password
	WHERE RecuperacionId = @pUsuarioId and Codigo = @pCodigo;
END

GO
