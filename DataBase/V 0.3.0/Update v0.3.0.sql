USE [DailySecurityDB]
GO


EXEC sp_rename 'tbl_Recuperacion_de_password.fecha', 'HorarioInicio', 'COLUMN';
EXEC sp_rename 'tbl_Recuperacion_de_password.limitehora', 'HorarioFin', 'COLUMN';

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

ALTER TABLE tbl_Recuperacion_de_password 
ALTER COLUMN codigo varchar(8);

/****** Object:  StoredProcedure [dbo].[RECUPERACION_DeleteRecuperacion]    Script Date: 22/04/2018 14:45:41 ******/
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
		 WHERE UsuarioID = @RecuperacionId
END

GO



/****** Object:  StoredProcedure [dbo].[RECUPERACION_GetRecuperacionByCodigoAndUsuarioID]    Script Date: 22/04/2018 14:45:41 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Lizeth Quispe
-- Create date: 22/04/2018
-- Description:	Obtener Recuperacion con ID de usuario  y codigo
-- =============================================
CREATE PROCEDURE [dbo].[RECUPERACION_GetRecuperacionByCodigoAndUsuarioID]
	@pCodigo varchar(8),
	@pUsuarioId int
AS
BEGIN

	SET NOCOUNT ON;
	select * 
	from tbl_Recuperacion_de_password
	WHERE RecuperacionId = @pUsuarioId and Codigo = @pCodigo;
END

GO

/****** Object:  StoredProcedure [dbo].[RECUPERACION_InsertarRecuperacion]    Script Date: 22/04/2018 14:45:41 ******/
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

/****** Object:  StoredProcedure [dbo].[USER_UpdateUsuarioPassword]    Script Date: 22/04/2018 14:45:41 ******/
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
	@pContrasenaNueva nchar(20)
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
