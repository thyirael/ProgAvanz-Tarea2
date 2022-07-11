--###########################################################################################################
--###
--##################################################### [3101] - PROGRAMACION AVANZADA EN WEB
--##################################################### TAREA # 2
--##################################################### ALLAN ALBERTO NARANJO CHACON
--##################################################### SCRIPTS DE BASE DE DATOS
--###
--###########################################################################################################

--###########################################################################################################
-------------------------------------------------------------------------------------------------------------
-- CREAR BASE DE DATOS
-------------------------------------------------------------------------------------------------------------

USE [master];
GO

CREATE DATABASE [PROGRA_AVANZADA_TAREA_2];
GO

--###########################################################################################################
-------------------------------------------------------------------------------------------------------------
-- CREAR TABLAS
-------------------------------------------------------------------------------------------------------------

USE [PROGRA_AVANZADA_TAREA_2];
GO

CREATE TABLE [dbo].[Canton]
(
    [Id] [INT] NULL,
    [IdProvincia] [INT] NULL,
    [Nombre] [NVARCHAR](255) NULL
) ON [PRIMARY];
GO

CREATE TABLE [dbo].[Distrito]
(
    [Id] [INT] NULL,
    [IdCanton] [INT] NULL,
    [Nombre] [NVARCHAR](255) NULL
) ON [PRIMARY];
GO

CREATE TABLE [dbo].[Edificio]
(
    [Id] [INT] IDENTITY(1, 1) NOT NULL PRIMARY KEY,
    [NombreEdificio] [VARCHAR](200) NOT NULL,
    [Capacidad] [INT] NOT NULL,
    [FechaCompra] [DATETIME] NOT NULL,
    [IdProvincia] [INT] NOT NULL,
    [IdCanton] [INT] NOT NULL,
    [IdDistrito] [INT] NOT NULL,
    [IdTipoPropiedad] [INT] NOT NULL,
    [FechaFinalContrato] [DATETIME] NULL,
    [Estado] [BIT] NULL
);
GO

CREATE TABLE [dbo].[Provincia]
(
    [Id] [INT] NULL,
    [Nombre] [NVARCHAR](255) NULL
) ON [PRIMARY];
GO

CREATE TABLE [dbo].[Servicio]
(
    [Id] [INT] IDENTITY(1, 1) NOT NULL PRIMARY KEY,
    [NombreServicio] [VARCHAR](200) NOT NULL,
    [IdTipoServicio] [INT] NOT NULL,
    [IdUnidadMedida] [INT] NOT NULL,
    [Empresa] [VARCHAR](200) NOT NULL,
    [Estado] [BIT] NULL
);
GO

CREATE TABLE [dbo].[ServiciosXEdificio]
(
    [Id] [INT] IDENTITY(1, 1) NOT NULL PRIMARY KEY,
    [IdEdificio] [INT] NOT NULL,
    [IdServicio] [INT] NOT NULL,
    [FechaCorte] [DATETIME] NOT NULL,
    [Consumo] [FLOAT] NULL
);
GO

CREATE TABLE [dbo].[TipoServicio]
(
    [Id] [INT] IDENTITY(1, 1) NOT NULL PRIMARY KEY,
    [Nombre] [VARCHAR](100) NOT NULL,
    [Estado] [BIT] NOT NULL
);
GO

CREATE TABLE [dbo].[UnidadMedida]
(
    [Id] [INT] IDENTITY(1, 1) NOT NULL PRIMARY KEY,
    [NombreUnidad] [VARCHAR](100) NOT NULL,
    [Estado] [BIT] NOT NULL
);
GO

--###########################################################################################################
-------------------------------------------------------------------------------------------------------------
-- CREAR PROCEDIMIENTOS ALMACENADOS
-------------------------------------------------------------------------------------------------------------

CREATE PROCEDURE [dbo].[usp_canton_listar]
(@salida DECIMAL OUTPUT)
AS
BEGIN
    BEGIN TRY
        SELECT *
        FROM PROGRA_AVANZADA_TAREA_2.dbo.Canton WITH (NOLOCK);
    END TRY
    BEGIN CATCH
        SELECT ERROR_NUMBER() AS ErrorNumber,
               ERROR_SEVERITY() AS ErrorSeverity,
               ERROR_STATE() AS ErrorState,
               ERROR_PROCEDURE() AS ErrorProcedure,
               ERROR_LINE() AS ErrorLine,
               ERROR_MESSAGE() AS ErrorMessage;
    END CATCH;
END;
GO

-------------------------------------------------------------------------------------------------------------

CREATE PROCEDURE [dbo].[usp_canton_obtener]
(
    @id INT,
    @salida DECIMAL OUTPUT
)
AS
BEGIN
    BEGIN TRY
        SELECT *
        FROM PROGRA_AVANZADA_TAREA_2.dbo.Canton WITH (NOLOCK)
        WHERE IdProvincia = @id;
    END TRY
    BEGIN CATCH
        SELECT ERROR_NUMBER() AS ErrorNumber,
               ERROR_SEVERITY() AS ErrorSeverity,
               ERROR_STATE() AS ErrorState,
               ERROR_PROCEDURE() AS ErrorProcedure,
               ERROR_LINE() AS ErrorLine,
               ERROR_MESSAGE() AS ErrorMessage;
    END CATCH;
END;
GO

-------------------------------------------------------------------------------------------------------------

CREATE PROCEDURE [dbo].[usp_distrito_listar]
(@salida DECIMAL OUTPUT)
AS
BEGIN
    BEGIN TRY
        SELECT *
        FROM PROGRA_AVANZADA_TAREA_2.dbo.Distrito WITH (NOLOCK);
    END TRY
    BEGIN CATCH
        SELECT ERROR_NUMBER() AS ErrorNumber,
               ERROR_SEVERITY() AS ErrorSeverity,
               ERROR_STATE() AS ErrorState,
               ERROR_PROCEDURE() AS ErrorProcedure,
               ERROR_LINE() AS ErrorLine,
               ERROR_MESSAGE() AS ErrorMessage;
    END CATCH;
END;
GO

-------------------------------------------------------------------------------------------------------------

CREATE PROCEDURE [dbo].[usp_distrito_obtener]
(
    @id INT,
    @salida DECIMAL OUTPUT
)
AS
BEGIN
    BEGIN TRY
        SELECT *
        FROM PROGRA_AVANZADA_TAREA_2.dbo.Distrito WITH (NOLOCK)
        WHERE IdCanton = @id;
    END TRY
    BEGIN CATCH
        SELECT ERROR_NUMBER() AS ErrorNumber,
               ERROR_SEVERITY() AS ErrorSeverity,
               ERROR_STATE() AS ErrorState,
               ERROR_PROCEDURE() AS ErrorProcedure,
               ERROR_LINE() AS ErrorLine,
               ERROR_MESSAGE() AS ErrorMessage;
    END CATCH;
END;
GO

-------------------------------------------------------------------------------------------------------------

CREATE PROCEDURE [dbo].[usp_edificio_eliminar]
(
    @id INT,
    @salida DECIMAL OUTPUT
)
AS
BEGIN
    BEGIN TRY
        DELETE FROM PROGRA_AVANZADA_TAREA_2.dbo.Edificio
        WHERE Id = @id;
    END TRY
    BEGIN CATCH
        SELECT ERROR_NUMBER() AS ErrorNumber,
               ERROR_SEVERITY() AS ErrorSeverity,
               ERROR_STATE() AS ErrorState,
               ERROR_PROCEDURE() AS ErrorProcedure,
               ERROR_LINE() AS ErrorLine,
               ERROR_MESSAGE() AS ErrorMessage;
    END CATCH;
END;
GO

-------------------------------------------------------------------------------------------------------------

CREATE PROCEDURE [dbo].[usp_edificio_guardar]
(
    @id INT,
    @nombreEdificio VARCHAR(200),
    @capacidad INT,
    @fechaCompra DATETIME,
    @idProvincia INT,
    @idCanton INT,
    @idDistrito INT,
    @idTipoPropiedad INT,
    @fechaFinalContrato DATETIME,
    @estado BIT,
    @salida DECIMAL OUTPUT
)
AS
BEGIN
    BEGIN TRY
        IF EXISTS
        (
            SELECT 1
            FROM PROGRA_AVANZADA_TAREA_2.dbo.Edificio WITH (NOLOCK)
            WHERE Id = @id
        )
        BEGIN
            UPDATE PROGRA_AVANZADA_TAREA_2.dbo.Edificio
            SET NombreEdificio = @nombreEdificio,
                Capacidad = @capacidad,
                FechaCompra = @fechaCompra,
                IdProvincia = @idProvincia,
                IdCanton = @idCanton,
                IdDistrito = @idDistrito,
                IdTipoPropiedad = @idTipoPropiedad,
                FechaFinalContrato = @fechaFinalContrato,
                Estado = @estado
            WHERE Id = @id;
        END;
        ELSE
        BEGIN
            INSERT INTO PROGRA_AVANZADA_TAREA_2.dbo.Edificio
            (
                NombreEdificio,
                Capacidad,
                FechaCompra,
                IdProvincia,
                IdCanton,
                IdDistrito,
                IdTipoPropiedad,
                FechaFinalContrato,
                Estado
            )
            VALUES
            (@nombreEdificio, @capacidad, @fechaCompra, @idProvincia, @idCanton, @idDistrito, @idTipoPropiedad,
             @fechaFinalContrato, @estado);
        END;
    END TRY
    BEGIN CATCH
        SELECT ERROR_NUMBER() AS ErrorNumber,
               ERROR_SEVERITY() AS ErrorSeverity,
               ERROR_STATE() AS ErrorState,
               ERROR_PROCEDURE() AS ErrorProcedure,
               ERROR_LINE() AS ErrorLine,
               ERROR_MESSAGE() AS ErrorMessage;
    END CATCH;
END;
GO

-------------------------------------------------------------------------------------------------------------

CREATE PROCEDURE [dbo].[usp_edificio_listar]
(@salida DECIMAL OUTPUT)
AS
BEGIN
    BEGIN TRY
        SELECT e.Id,
               e.NombreEdificio,
               e.Capacidad,
               e.FechaCompra,
               e.IdProvincia,
               p.Nombre AS NombreProvincia,
               e.IdCanton,
               c.Nombre NombreCanton,
               e.IdDistrito,
               d.Nombre NombreDistrito,
               e.IdTipoPropiedad,
               CASE
                   WHEN e.IdTipoPropiedad = 1 THEN
                       'Adquirido'
                   ELSE
                       'Alquilado'
               END AS NombreTipoPropiedad,
               e.FechaFinalContrato,
               e.Estado
        FROM PROGRA_AVANZADA_TAREA_2.dbo.Edificio e WITH (NOLOCK)
            INNER JOIN PROGRA_AVANZADA_TAREA_2.dbo.Provincia p WITH (NOLOCK)
                ON e.IdProvincia = p.Id
            INNER JOIN PROGRA_AVANZADA_TAREA_2.dbo.Canton c WITH (NOLOCK)
                ON e.IdCanton = c.Id
            INNER JOIN PROGRA_AVANZADA_TAREA_2.dbo.Distrito d WITH (NOLOCK)
                ON e.IdDistrito = d.Id
        ORDER BY e.Id;
    END TRY
    BEGIN CATCH
        SELECT ERROR_NUMBER() AS ErrorNumber,
               ERROR_SEVERITY() AS ErrorSeverity,
               ERROR_STATE() AS ErrorState,
               ERROR_PROCEDURE() AS ErrorProcedure,
               ERROR_LINE() AS ErrorLine,
               ERROR_MESSAGE() AS ErrorMessage;
    END CATCH;
END;
GO

-------------------------------------------------------------------------------------------------------------

CREATE PROCEDURE [dbo].[usp_edificio_obtener]
(
    @id INT,
    @salida DECIMAL OUTPUT
)
AS
BEGIN
    BEGIN TRY
        SELECT E.Id,
               E.NombreEdificio,
               E.Capacidad,
               E.FechaCompra,
               E.IdProvincia,
               p.Nombre AS NombreProvincia,
               E.IdCanton,
               c.Nombre NombreCanton,
               E.IdDistrito,
               d.Nombre NombreDistrito,
               E.IdTipoPropiedad,
               CASE
                   WHEN E.IdTipoPropiedad = 1 THEN
                       'Adquirido'
                   ELSE
                       'Alquilado'
               END AS NombreTipoPropiedad,
               E.FechaFinalContrato,
               E.Estado
        FROM PROGRA_AVANZADA_TAREA_2.dbo.Edificio E WITH (NOLOCK)
            INNER JOIN PROGRA_AVANZADA_TAREA_2.dbo.Provincia p WITH (NOLOCK)
                ON E.IdProvincia = p.Id
            INNER JOIN PROGRA_AVANZADA_TAREA_2.dbo.Canton c WITH (NOLOCK)
                ON E.IdCanton = c.Id
            INNER JOIN PROGRA_AVANZADA_TAREA_2.dbo.Distrito d WITH (NOLOCK)
                ON E.IdDistrito = d.Id
        WHERE E.Id = @id;
    END TRY
    BEGIN CATCH
        SELECT ERROR_NUMBER() AS ErrorNumber,
               ERROR_SEVERITY() AS ErrorSeverity,
               ERROR_STATE() AS ErrorState,
               ERROR_PROCEDURE() AS ErrorProcedure,
               ERROR_LINE() AS ErrorLine,
               ERROR_MESSAGE() AS ErrorMessage;
    END CATCH;
END;
GO

-------------------------------------------------------------------------------------------------------------

CREATE PROCEDURE [dbo].[usp_provincia_listar]
(@salida DECIMAL OUTPUT)
AS
BEGIN
    BEGIN TRY
        SELECT *
        FROM PROGRA_AVANZADA_TAREA_2.dbo.Provincia WITH (NOLOCK);
    END TRY
    BEGIN CATCH
        SELECT ERROR_NUMBER() AS ErrorNumber,
               ERROR_SEVERITY() AS ErrorSeverity,
               ERROR_STATE() AS ErrorState,
               ERROR_PROCEDURE() AS ErrorProcedure,
               ERROR_LINE() AS ErrorLine,
               ERROR_MESSAGE() AS ErrorMessage;
    END CATCH;
END;
GO

-------------------------------------------------------------------------------------------------------------

CREATE PROCEDURE [dbo].[usp_servicio_eliminar]
(
    @id INT,
    @salida DECIMAL OUTPUT
)
AS
BEGIN
    BEGIN TRY
        DELETE FROM PROGRA_AVANZADA_TAREA_2.dbo.Servicio
        WHERE Id = @id;
    END TRY
    BEGIN CATCH
        SELECT ERROR_NUMBER() AS ErrorNumber,
               ERROR_SEVERITY() AS ErrorSeverity,
               ERROR_STATE() AS ErrorState,
               ERROR_PROCEDURE() AS ErrorProcedure,
               ERROR_LINE() AS ErrorLine,
               ERROR_MESSAGE() AS ErrorMessage;
    END CATCH;
END;
GO

-------------------------------------------------------------------------------------------------------------

CREATE PROCEDURE [dbo].[usp_servicio_guardar]
(
    @id INT,
    @nombreServicio VARCHAR(200),
    @idTipoServicio INT,
    @idUnidadMedida INT,
    @empresa VARCHAR(200),
    @estado BIT,
    @salida DECIMAL OUTPUT
)
AS
BEGIN
    BEGIN TRY
        IF EXISTS
        (
            SELECT 1
            FROM PROGRA_AVANZADA_TAREA_2.dbo.Servicio WITH (NOLOCK)
            WHERE Id = @id
        )
        BEGIN
            UPDATE PROGRA_AVANZADA_TAREA_2.dbo.Servicio
            SET NombreServicio = @nombreServicio,
                IdTipoServicio = @idTipoServicio,
                IdUnidadMedida = @idUnidadMedida,
                Empresa = @empresa,
                Estado = @estado
            WHERE Id = @id;
        END;
        ELSE
        BEGIN
            INSERT INTO PROGRA_AVANZADA_TAREA_2.dbo.Servicio
            (
                NombreServicio,
                IdTipoServicio,
                IdUnidadMedida,
                Empresa,
                Estado
            )
            VALUES
            (@nombreServicio, @idTipoServicio, @idUnidadMedida, @empresa, @estado);
        END;
    END TRY
    BEGIN CATCH
        SELECT ERROR_NUMBER() AS ErrorNumber,
               ERROR_SEVERITY() AS ErrorSeverity,
               ERROR_STATE() AS ErrorState,
               ERROR_PROCEDURE() AS ErrorProcedure,
               ERROR_LINE() AS ErrorLine,
               ERROR_MESSAGE() AS ErrorMessage;
    END CATCH;
END;
GO

-------------------------------------------------------------------------------------------------------------

CREATE PROCEDURE [dbo].[usp_servicio_listar]
(@salida DECIMAL OUTPUT)
AS
BEGIN
    BEGIN TRY
        SELECT s.Id,
               s.NombreServicio,
               s.IdTipoServicio,
               ts.Nombre AS NombreTipoServicio,
               s.IdUnidadMedida,
               um.NombreUnidad AS NombreUnidadMedida,
               s.Empresa,
               s.Estado
        FROM PROGRA_AVANZADA_TAREA_2.dbo.Servicio s WITH (NOLOCK)
            INNER JOIN PROGRA_AVANZADA_TAREA_2.dbo.TipoServicio ts WITH (NOLOCK)
                ON s.IdTipoServicio = ts.Id
            INNER JOIN PROGRA_AVANZADA_TAREA_2.dbo.UnidadMedida um WITH (NOLOCK)
                ON s.IdUnidadMedida = um.Id
        ORDER BY s.Id;
    END TRY
    BEGIN CATCH
        SELECT ERROR_NUMBER() AS ErrorNumber,
               ERROR_SEVERITY() AS ErrorSeverity,
               ERROR_STATE() AS ErrorState,
               ERROR_PROCEDURE() AS ErrorProcedure,
               ERROR_LINE() AS ErrorLine,
               ERROR_MESSAGE() AS ErrorMessage;
    END CATCH;
END;
GO

-------------------------------------------------------------------------------------------------------------

CREATE PROCEDURE [dbo].[usp_servicio_obtener]
(
    @id INT,
    @salida DECIMAL OUTPUT
)
AS
BEGIN
    BEGIN TRY
        SELECT s.Id,
               s.NombreServicio,
               s.IdTipoServicio,
               ts.Nombre AS NombreTipoServicio,
               s.IdUnidadMedida,
               um.NombreUnidad AS NombreUnidadMedida,
               s.Empresa,
               s.Estado
        FROM PROGRA_AVANZADA_TAREA_2.dbo.Servicio s WITH (NOLOCK)
            INNER JOIN PROGRA_AVANZADA_TAREA_2.dbo.TipoServicio ts WITH (NOLOCK)
                ON ts.Id = s.Id
            INNER JOIN PROGRA_AVANZADA_TAREA_2.dbo.UnidadMedida um WITH (NOLOCK)
                ON um.Id = s.Id
        WHERE s.Id = @id;
    END TRY
    BEGIN CATCH
        SELECT ERROR_NUMBER() AS ErrorNumber,
               ERROR_SEVERITY() AS ErrorSeverity,
               ERROR_STATE() AS ErrorState,
               ERROR_PROCEDURE() AS ErrorProcedure,
               ERROR_LINE() AS ErrorLine,
               ERROR_MESSAGE() AS ErrorMessage;
    END CATCH;
END;
GO

-------------------------------------------------------------------------------------------------------------

CREATE PROCEDURE [dbo].[usp_serviciosxedificio_eliminar]
(
    @id INT,
    @salida DECIMAL OUTPUT
)
AS
BEGIN
    BEGIN TRY
        DELETE FROM PROGRA_AVANZADA_TAREA_2.dbo.ServiciosXEdificio
        WHERE Id = @id;
    END TRY
    BEGIN CATCH
        SELECT ERROR_NUMBER() AS ErrorNumber,
               ERROR_SEVERITY() AS ErrorSeverity,
               ERROR_STATE() AS ErrorState,
               ERROR_PROCEDURE() AS ErrorProcedure,
               ERROR_LINE() AS ErrorLine,
               ERROR_MESSAGE() AS ErrorMessage;
    END CATCH;
END;
GO

-------------------------------------------------------------------------------------------------------------

CREATE PROCEDURE [dbo].[usp_serviciosxedificio_guardar]
(
    @id INT,
    @idEdificio INT,
    @idServicio VARCHAR(200),
    @fechaCorte DATETIME,
    @consumo FLOAT,
    @salida DECIMAL OUTPUT
)
AS
BEGIN
    BEGIN TRY
        SELECT @salida = 0;

        IF EXISTS
        (
            SELECT 1
            FROM PROGRA_AVANZADA_TAREA_2.dbo.ServiciosXEdificio WITH (NOLOCK)
            WHERE Id = @id
        )
        BEGIN
            --ACTUALIZA
            IF EXISTS
            (
                SELECT 1
                FROM PROGRA_AVANZADA_TAREA_2.dbo.ServiciosXEdificio WITH (NOLOCK)
                WHERE IdEdificio = @idEdificio
                      AND IdServicio = @idServicio
            )
            BEGIN
                IF EXISTS
                (
                    SELECT 1
                    FROM PROGRA_AVANZADA_TAREA_2.dbo.ServiciosXEdificio WITH (NOLOCK)
                    WHERE IdEdificio = @idEdificio
                          AND IdServicio = @idServicio
                          AND Id = @id
                )
                BEGIN
                    UPDATE PROGRA_AVANZADA_TAREA_2.dbo.ServiciosXEdificio
                    SET FechaCorte = @fechaCorte,
                        Consumo = @consumo
                    WHERE Id = @id;
                END;
                ELSE
                BEGIN
                    SELECT @salida = -1;
                END;
            END;
            ELSE
            BEGIN
                UPDATE PROGRA_AVANZADA_TAREA_2.dbo.ServiciosXEdificio
                SET IdEdificio = @idEdificio,
                    IdServicio = @idServicio,
                    FechaCorte = @fechaCorte,
                    Consumo = @consumo
                WHERE Id = @id;
            END;
        END;
        ELSE
        BEGIN
            --INSERT
            IF EXISTS
            (
                SELECT 1
                FROM PROGRA_AVANZADA_TAREA_2.dbo.ServiciosXEdificio WITH (NOLOCK)
                WHERE IdEdificio = @idEdificio
                      AND IdServicio = @idServicio
            )
            BEGIN
                SELECT @salida = -1;
            END;
            ELSE
            BEGIN
                INSERT INTO PROGRA_AVANZADA_TAREA_2.dbo.ServiciosXEdificio
                (
                    IdEdificio,
                    IdServicio,
                    FechaCorte,
                    Consumo
                )
                VALUES
                (@idEdificio, @idServicio, @fechaCorte, @consumo);
            END;
        END;
    END TRY
    BEGIN CATCH
        SELECT ERROR_NUMBER() AS ErrorNumber,
               ERROR_SEVERITY() AS ErrorSeverity,
               ERROR_STATE() AS ErrorState,
               ERROR_PROCEDURE() AS ErrorProcedure,
               ERROR_LINE() AS ErrorLine,
               ERROR_MESSAGE() AS ErrorMessage;
    END CATCH;
END
GO

-------------------------------------------------------------------------------------------------------------

CREATE PROCEDURE [dbo].[usp_serviciosxedificio_listar]
(@salida DECIMAL OUTPUT)
AS
BEGIN
    BEGIN TRY
        SELECT se.Id,
               se.IdEdificio,
               e.NombreEdificio,
               se.IdServicio,
               s.NombreServicio,
               se.FechaCorte,
               se.Consumo
        FROM PROGRA_AVANZADA_TAREA_2.dbo.ServiciosXEdificio se WITH (NOLOCK)
            INNER JOIN PROGRA_AVANZADA_TAREA_2.dbo.Edificio e WITH (NOLOCK)
                ON se.IdEdificio = e.Id
            INNER JOIN PROGRA_AVANZADA_TAREA_2.dbo.Servicio s WITH (NOLOCK)
                ON se.IdServicio = s.Id;
    END TRY
    BEGIN CATCH
        SELECT ERROR_NUMBER() AS ErrorNumber,
               ERROR_SEVERITY() AS ErrorSeverity,
               ERROR_STATE() AS ErrorState,
               ERROR_PROCEDURE() AS ErrorProcedure,
               ERROR_LINE() AS ErrorLine,
               ERROR_MESSAGE() AS ErrorMessage;
    END CATCH;
END;
GO

-------------------------------------------------------------------------------------------------------------

CREATE PROCEDURE [dbo].[usp_serviciosxedificio_obtener]
(
    @id INT,
    @salida DECIMAL OUTPUT
)
AS
BEGIN
    BEGIN TRY
        SELECT se.Id,
               se.IdEdificio,
               e.NombreEdificio,
               se.IdServicio,
               s.NombreServicio,
               se.FechaCorte,
               se.Consumo
        FROM PROGRA_AVANZADA_TAREA_2.dbo.ServiciosXEdificio se WITH (NOLOCK)
            INNER JOIN PROGRA_AVANZADA_TAREA_2.dbo.Edificio e WITH (NOLOCK)
                ON se.IdEdificio = e.Id
            INNER JOIN PROGRA_AVANZADA_TAREA_2.dbo.Servicio s WITH (NOLOCK)
                ON se.IdServicio = s.Id
        WHERE se.Id = @id;
    END TRY
    BEGIN CATCH
        SELECT ERROR_NUMBER() AS ErrorNumber,
               ERROR_SEVERITY() AS ErrorSeverity,
               ERROR_STATE() AS ErrorState,
               ERROR_PROCEDURE() AS ErrorProcedure,
               ERROR_LINE() AS ErrorLine,
               ERROR_MESSAGE() AS ErrorMessage;
    END CATCH;
END;
GO

-------------------------------------------------------------------------------------------------------------

CREATE PROCEDURE [dbo].[usp_tiposervicio_listar]
(@salida DECIMAL OUTPUT)
AS
BEGIN
    BEGIN TRY
        SELECT *
        FROM PROGRA_AVANZADA_TAREA_2.dbo.TipoServicio WITH (NOLOCK);
    END TRY
    BEGIN CATCH
        SELECT ERROR_NUMBER() AS ErrorNumber,
               ERROR_SEVERITY() AS ErrorSeverity,
               ERROR_STATE() AS ErrorState,
               ERROR_PROCEDURE() AS ErrorProcedure,
               ERROR_LINE() AS ErrorLine,
               ERROR_MESSAGE() AS ErrorMessage;
    END CATCH;
END;
GO

-------------------------------------------------------------------------------------------------------------

CREATE PROCEDURE [dbo].[usp_unidadmedida_listar]
(@salida DECIMAL OUTPUT)
AS
BEGIN
    BEGIN TRY
        SELECT *
        FROM PROGRA_AVANZADA_TAREA_2.dbo.UnidadMedida WITH (NOLOCK);
    END TRY
    BEGIN CATCH
        SELECT ERROR_NUMBER() AS ErrorNumber,
               ERROR_SEVERITY() AS ErrorSeverity,
               ERROR_STATE() AS ErrorState,
               ERROR_PROCEDURE() AS ErrorProcedure,
               ERROR_LINE() AS ErrorLine,
               ERROR_MESSAGE() AS ErrorMessage;
    END CATCH;
END;
GO


--###########################################################################################################
-------------------------------------------------------------------------------------------------------------
-- INSERTAR DATOS DE CATALOGOS
-------------------------------------------------------------------------------------------------------------

INSERT INTO dbo.Provincia
(
    [Id],
    [Nombre]
)
VALUES
(1, N'San José'),
(2, N'Alajuela'),
(3, N'Cartago'),
(4, N'Heredia'),
(5, N'Guanacaste'),
(6, N'Puntarenas'),
(7, N'Limon');

-------------------------------------------------------------------------------------------------------------

INSERT INTO dbo.Canton
(
    [Id],
    [IdProvincia],
    [Nombre]
)
VALUES
(1, 1, N'San José'),
(2, 1, N'Escazú'),
(3, 1, N'Desamparados'),
(4, 1, N'Puriscal'),
(5, 1, N'Tarrazú'),
(6, 1, N'Aserrí'),
(7, 1, N'Mora'),
(8, 1, N'Goicoechea'),
(9, 1, N'Santa Ana'),
(10, 1, N'Alajuelita'),
(11, 1, N'Vásquez de Coronado'),
(12, 1, N'Acosta'),
(13, 1, N'Tibás'),
(14, 1, N'Moravia'),
(15, 1, N'Montes de Oca'),
(16, 1, N'Turrubares'),
(17, 1, N'Dota'),
(18, 1, N'Currridabat'),
(19, 1, N'Pérez Zeledón'),
(20, 1, N'León Cortés'),
(21, 2, N'Alajuela'),
(22, 2, N'San Ramón'),
(23, 2, N'Grecia'),
(24, 2, N'San Mateo'),
(25, 2, N'Atenas'),
(26, 2, N'Naranjo'),
(27, 2, N'Palmares'),
(28, 2, N'Poás'),
(29, 2, N'Orotina'),
(30, 2, N'San Carlos'),
(31, 2, N'Alfaro Ruíz'),
(32, 2, N'Valverde Vega'),
(33, 2, N'Upala'),
(34, 2, N'Los Chiles'),
(35, 2, N'Guatuso'),
(36, 2, N'Zarcero'),
(37, 3, N'Cartago'),
(38, 3, N'Paraíso'),
(39, 3, N'La Unión'),
(40, 3, N'Jiménez'),
(41, 3, N'Turrialba'),
(42, 3, N'Alvarado'),
(43, 3, N'Oreamuno'),
(44, 3, N'El Guarco'),
(45, 4, N'Heredia'),
(46, 4, N'Barva'),
(47, 4, N'Santo Domingo'),
(48, 4, N'Santa Bárbara'),
(49, 4, N'San Rafael'),
(50, 4, N'San Isidro'),
(51, 4, N'Belén'),
(52, 4, N'Flores'),
(53, 4, N'San Pablo'),
(54, 4, N'Sarapiquí'),
(55, 5, N'Liberia'),
(56, 5, N'Nicoya'),
(57, 5, N'Santa Cruz'),
(58, 5, N'Bagaces'),
(59, 5, N'Carrillo'),
(60, 5, N'Cañas'),
(61, 5, N'Abangares'),
(62, 5, N'Tilarán'),
(63, 5, N'Nandayure'),
(64, 5, N'La Cruz'),
(65, 5, N'Hojancha'),
(66, 6, N'Puntarenas'),
(67, 6, N'Esparza'),
(68, 6, N'Buenos Aires'),
(69, 6, N'Montes de Oro'),
(70, 6, N'Osa'),
(71, 6, N'Aguirre'),
(72, 6, N'Golfito'),
(73, 6, N'Coto Brus'),
(74, 6, N'Parrita'),
(75, 6, N'Corredores'),
(76, 6, N'Garabito'),
(77, 7, N'Limón'),
(78, 7, N'Pococí'),
(79, 7, N'Siquirres'),
(80, 7, N'Talamanca'),
(81, 7, N'Matina'),
(82, 7, N'Guácimo');

-------------------------------------------------------------------------------------------------------------

INSERT INTO dbo.Distrito
(
    [Id],
    [IdCanton],
    [Nombre]
)
VALUES
(1, 1, N'Carmen'),
(2, 1, N'Merced'),
(3, 1, N'Hospital'),
(4, 1, N'Catedral'),
(5, 1, N'Zapote'),
(6, 1, N'San Francisco de Dos Ríos'),
(7, 1, N'Uruca'),
(8, 1, N'Mata Redonda'),
(9, 1, N'Pavas'),
(10, 1, N'Hatillo'),
(11, 1, N'San Sebastián'),
(12, 2, N'Escazú'),
(13, 2, N'San Antonio'),
(14, 2, N'San Rafael'),
(15, 3, N'Desamparados'),
(16, 3, N'San Miguel'),
(17, 3, N'San Juan de Dios'),
(18, 3, N'San Rafael Arriba'),
(19, 3, N'San Antonio'),
(20, 3, N'Frailes'),
(21, 3, N'Patarrá'),
(22, 3, N'San Cristóbal'),
(23, 3, N'Rosario'),
(24, 3, N'Damas'),
(25, 3, N'San Rafael Abajo'),
(26, 3, N'Gravilias'),
(27, 3, N'Los Guido'),
(28, 4, N'Santiago'),
(29, 4, N'Mercedes Sur'),
(30, 4, N'Barbacoas'),
(31, 4, N'Grifo Alto'),
(32, 4, N'San Rafael'),
(33, 4, N'Candelaria'),
(34, 4, N'Desamparaditos'),
(35, 4, N'San Antonio'),
(36, 4, N'Chires'),
(37, 5, N'San Marcos'),
(38, 5, N'San Lorenzo'),
(39, 5, N'San Carlos'),
(40, 6, N'Aserrí'),
(41, 6, N'Tarbaca o Praga'),
(42, 6, N'Vuelta de Jorco'),
(43, 6, N'San Gabriel'),
(44, 6, N'La Legua'),
(45, 6, N'Monterrey'),
(46, 6, N'Salitrillos'),
(47, 7, N'Colón'),
(48, 7, N'Guayabo'),
(49, 7, N'Tabarcia'),
(50, 7, N'Piedras Negras'),
(51, 7, N'Picagres'),
(52, 8, N'Guadalupe'),
(53, 8, N'San Francisco'),
(54, 8, N'Calle Blancos'),
(55, 8, N'Mata de Plátano'),
(56, 8, N'Ipís'),
(57, 8, N'Rancho Redondo'),
(58, 8, N'Purral'),
(59, 9, N'Santa Ana'),
(60, 9, N'Salitral'),
(61, 9, N'Pozos '),
(62, 9, N'Uruca '),
(63, 9, N'Piedades'),
(64, 9, N'Brasil'),
(65, 10, N'Alajuelita'),
(66, 10, N'San Josecito'),
(67, 10, N'San Antonio'),
(68, 10, N'Concepción'),
(69, 10, N'San Felipe'),
(70, 11, N'San Isidro'),
(71, 11, N'San Rafael'),
(72, 11, N'Dulce Nombre o Jesús'),
(73, 11, N'Patalillo'),
(74, 11, N'Cascajal'),
(75, 12, N'San Ignacio'),
(76, 12, N'Guaitil'),
(77, 12, N'Palmichal'),
(78, 12, N'Cangrejal'),
(79, 12, N'Sabanillas'),
(80, 13, N'San Juan'),
(81, 13, N'Cinco Esquinas'),
(82, 13, N'Anselmo Llorente'),
(83, 13, N'León XIII'),
(84, 13, N'Colima'),
(85, 14, N'San Vicente'),
(86, 14, N'San Jerónimo'),
(87, 14, N'La Trinidad'),
(88, 15, N'San Pedro'),
(89, 15, N'Sabanilla'),
(90, 15, N'Mercedes o Betania'),
(91, 15, N'San Rafael'),
(92, 16, N'San Pablo'),
(93, 16, N'San Pedro'),
(94, 16, N'San Juan de Mata'),
(95, 16, N'San Luis'),
(96, 16, N'Carara'),
(97, 17, N'Santa María'),
(98, 17, N'Jardín'),
(99, 17, N'Copey'),
(100, 18, N'Curridabat'),
(101, 18, N'Granadilla'),
(102, 18, N'Sánchez'),
(103, 18, N'Tirrases'),
(104, 19, N'San Isidro'),
(105, 19, N'General'),
(106, 19, N'Daniel Flores'),
(107, 19, N'Rivas'),
(108, 19, N'San Pedro'),
(109, 19, N'Platanares'),
(110, 19, N'Pejibaye'),
(111, 19, N'Cajón o Carmen'),
(112, 19, N'Barú'),
(113, 19, N'Río Nuevo'),
(114, 19, N'Páramo'),
(115, 20, N'San Pablo'),
(116, 20, N'San Andrés'),
(117, 20, N'Llano Bonito'),
(118, 20, N'San Isidro'),
(119, 20, N'Santa Cruz'),
(120, 20, N'San Antonio'),
(121, 21, N'Alajuela'),
(122, 21, N'San José'),
(123, 21, N'Carrizal'),
(124, 21, N'San Antonio'),
(125, 21, N'Guácima'),
(126, 21, N'San Isidro'),
(127, 21, N'Sabanilla'),
(128, 21, N'San Rafael'),
(129, 21, N'Río Segundo'),
(130, 21, N'Desamparados'),
(131, 21, N'Turrucares'),
(132, 21, N'Tambor'),
(133, 21, N'La Garita'),
(134, 21, N'Sarapiquí'),
(135, 22, N'San Ramón'),
(136, 22, N'Santiago'),
(137, 22, N'San Juan'),
(138, 22, N'Piedades Norte'),
(139, 22, N'Piedades Sur'),
(140, 22, N'San Rafael'),
(141, 22, N'San Isidro'),
(142, 22, N'Angeles'),
(143, 22, N'Alfaro'),
(144, 22, N'Volio'),
(145, 22, N'Concepción'),
(146, 22, N'Zapotal'),
(147, 22, N'San Isidro de Peñas Blancas'),
(148, 23, N'Grecia'),
(149, 23, N'San Isidro'),
(150, 23, N'San José'),
(151, 23, N'San Roque'),
(152, 23, N'Tacares'),
(153, 23, N'Río Cuarto'),
(154, 23, N'Puente Piedra'),
(155, 23, N'Bolívar'),
(156, 24, N'San Mateo'),
(157, 24, N'Desmonte'),
(158, 24, N'Jesús María'),
(159, 25, N'Atenas'),
(160, 25, N'Jesús'),
(161, 25, N'Mercedes'),
(162, 25, N'San Isidro'),
(163, 25, N'Concepción'),
(164, 25, N'San José'),
(165, 25, N'Santa Eulalia'),
(166, 25, N'Escobal'),
(167, 26, N'Naranjo'),
(168, 26, N'San Miguel'),
(169, 26, N'San José'),
(170, 26, N'Cirrí Sur'),
(171, 26, N'San Jerónimo'),
(172, 26, N'San Juan'),
(173, 26, N'Rosario'),
(174, 27, N'Palmares'),
(175, 27, N'Zaragoza'),
(176, 27, N'Buenos Aires'),
(177, 27, N'Santiago'),
(178, 27, N'Candelaria'),
(179, 27, N'Esquipulas'),
(180, 27, N'La Granja'),
(181, 28, N'San Pedro'),
(182, 28, N'San Juan'),
(183, 28, N'San Rafael'),
(184, 28, N'Carrillos'),
(185, 28, N'Sabana Redonda'),
(186, 29, N'Orotina'),
(187, 29, N'Mastate'),
(188, 29, N'Hacienda Vieja'),
(189, 29, N'Coyolar'),
(190, 29, N'Ceiba'),
(191, 30, N'Quesada'),
(192, 30, N'Florencia'),
(193, 30, N'Buenavista'),
(194, 30, N'Aguas Zarcas'),
(195, 30, N'Venecia'),
(196, 30, N'Pital'),
(197, 30, N'Fortuna'),
(198, 30, N'Tigra'),
(199, 30, N'Palmera'),
(200, 30, N'Venado'),
(201, 30, N'Cutris'),
(202, 30, N'Monterrey'),
(203, 30, N'Pocosol'),
(204, 31, N'Zarcero'),
(205, 31, N'Laguna'),
(206, 31, N'Tapezco'),
(207, 31, N'Guadalupe'),
(208, 31, N'Palmira'),
(209, 31, N'Zapote'),
(210, 31, N'Brisas'),
(211, 32, N'Sarchí Norte'),
(212, 32, N'Sarchí Sur'),
(213, 32, N'Toro Amarillo'),
(214, 32, N'San Pedro'),
(215, 32, N'Rodríguez'),
(216, 33, N'Upala'),
(217, 33, N'Aguas Claras'),
(218, 33, N'San José o Pizote'),
(219, 33, N'Bijagua'),
(220, 33, N'Delicias'),
(221, 33, N'Dos Ríos'),
(222, 33, N'Yolillal'),
(223, 34, N'Los Chiles'),
(224, 34, N'Caño Negro'),
(225, 34, N'Amparo'),
(226, 34, N'San Jorge'),
(227, 35, N'San Rafael'),
(228, 35, N'Buenavista'),
(229, 35, N'Cote'),
(230, 36, N'Zarcero'),
(231, 36, N'Laguna'),
(232, 36, N'Tapezco'),
(233, 36, N'Palmira'),
(234, 36, N'Guadalupe'),
(235, 36, N'Zapote'),
(236, 36, N'Las Brisas'),
(237, 37, N'Oriental'),
(238, 37, N'Occidental'),
(239, 37, N'Carmen'),
(240, 37, N'San Nicolás'),
(241, 37, N'Aguacaliente (San Francisco)'),
(242, 37, N'Guadalupe (Arenilla)'),
(243, 37, N'Corralillo'),
(244, 37, N'Tierra Blanca'),
(245, 37, N'Dulce Nombre'),
(246, 37, N'Llano Grande'),
(247, 37, N'Quebradilla'),
(248, 38, N'Paraíso'),
(249, 38, N'Santiago'),
(250, 38, N'Orosi'),
(251, 38, N'Cachí'),
(252, 38, N'Llanos de Sta Lucia'),
(253, 39, N'Tres Ríos'),
(254, 39, N'San Diego'),
(255, 39, N'San Juan'),
(256, 39, N'San Rafael'),
(257, 39, N'Concepción'),
(258, 39, N'Dulce Nombre'),
(259, 39, N'San Ramón'),
(260, 39, N'Río Azul'),
(261, 40, N'Juan Viñas'),
(262, 40, N'Tucurrique'),
(263, 40, N'Pejibaye'),
(264, 41, N'Turrialba'),
(265, 41, N'La Suiza'),
(266, 41, N'Peralta'),
(267, 41, N'Santa Cruz'),
(268, 41, N'Santa Teresita'),
(269, 41, N'Pavones'),
(270, 41, N'Tuis'),
(271, 41, N'Tayutic'),
(272, 41, N'Santa Rosa'),
(273, 41, N'Tres Equis'),
(274, 41, N'La Isabel'),
(275, 41, N'Chirripo'),
(276, 42, N'Pacayas'),
(277, 42, N'Cervantes'),
(278, 42, N'Capellades'),
(279, 43, N'San Rafael'),
(280, 43, N'Cot'),
(281, 43, N'Potrero Cerrado'),
(282, 43, N'Cipreses'),
(283, 43, N'Santa Rosa'),
(284, 44, N'El Tejar'),
(285, 44, N'San Isidro'),
(286, 44, N'Tobosi'),
(287, 44, N'Patio de Agua'),
(288, 45, N'Heredia'),
(289, 45, N'Mercedes'),
(290, 45, N'San Francisco'),
(291, 45, N'Ulloa'),
(292, 45, N'Vara Blanca'),
(293, 46, N'Barva'),
(294, 46, N'San Pedro'),
(295, 46, N'San Pablo'),
(296, 46, N'San Roque'),
(297, 46, N'Santa Lucía'),
(298, 46, N'San José de la Montaña'),
(299, 47, N'Santo Domingo'),
(300, 47, N'San Vicente'),
(301, 47, N'San Miguel'),
(302, 47, N'Paracito'),
(303, 47, N'Santo Tomás'),
(304, 47, N'Santa Rosa'),
(305, 47, N'Tures'),
(306, 47, N'Pará'),
(307, 48, N'Santa Bárbara'),
(308, 48, N'San Pedro'),
(309, 48, N'San Juan'),
(310, 48, N'Jesús'),
(311, 48, N'Santo Domingo del Roble'),
(312, 48, N'Puraba'),
(313, 49, N'San Rafael'),
(314, 49, N'San Josecito'),
(315, 49, N'Santiago'),
(316, 49, N'Angeles'),
(317, 49, N'Concepción'),
(318, 50, N'San Isidro'),
(319, 50, N'San José'),
(320, 50, N'Concepción'),
(321, 50, N'San Francisco'),
(322, 51, N'San Antonio'),
(323, 51, N'La Rivera'),
(324, 51, N'Asunción'),
(325, 52, N'San Joaquín'),
(326, 52, N'Barrantes'),
(327, 52, N'Llorente'),
(328, 53, N'San Pablo'),
(329, 54, N'Puerto Viejo'),
(330, 54, N'La Virgen'),
(331, 54, N'Horquetas'),
(332, 54, N'Llanuras del Gaspar'),
(333, 54, N'Cureña'),
(334, 55, N'Liberia'),
(335, 55, N'Cañas Dulces'),
(336, 55, N'Mayorga'),
(337, 55, N'Nacascolo'),
(338, 55, N'Curubande'),
(339, 56, N'Nicoya'),
(340, 56, N'Mansión'),
(341, 56, N'San Antonio'),
(342, 56, N'Quebrada Honda'),
(343, 56, N'Sámara'),
(344, 56, N'Nosara'),
(345, 56, N'Belén de Nosarita'),
(346, 57, N'Santa Cruz'),
(347, 57, N'Bolsón'),
(348, 57, N'Veintisiete de Abril'),
(349, 57, N'Tempate'),
(350, 57, N'Cartagena'),
(351, 57, N'Cuajiniquil'),
(352, 57, N'Diriá'),
(353, 57, N'Cabo Velas'),
(354, 57, N'Tamarindo'),
(355, 58, N'Bagaces'),
(356, 58, N'Fortuna'),
(357, 58, N'Mogote'),
(358, 58, N'Río Naranjo'),
(359, 59, N'Filadelfia'),
(360, 59, N'Palmira'),
(361, 59, N'Sardinal'),
(362, 59, N'Belén'),
(363, 60, N'Cañas'),
(364, 60, N'Palmira'),
(365, 60, N'San Miguel'),
(366, 60, N'Bebedero'),
(367, 60, N'Porozal'),
(368, 61, N'Juntas'),
(369, 61, N'Sierra'),
(370, 61, N'San Juan'),
(371, 61, N'Colorado'),
(372, 62, N'Tilarán'),
(373, 62, N'Quebrada Grande'),
(374, 62, N'Tronadora'),
(375, 62, N'Santa Rosa'),
(376, 62, N'Líbano'),
(377, 62, N'Tierras Morenas'),
(378, 62, N'Arenal'),
(379, 63, N'Carmona'),
(380, 63, N'Santa Rita'),
(381, 63, N'Zapotal'),
(382, 63, N'San Pablo'),
(383, 63, N'Porvenir'),
(384, 63, N'Bejuco'),
(385, 64, N'La Cruz'),
(386, 64, N'Santa Cecilia'),
(387, 64, N'Garita'),
(388, 64, N'Santa Elena'),
(389, 65, N'Hojancha'),
(390, 65, N'Monte Romo'),
(391, 65, N'Puerto Carrillo'),
(392, 65, N'Huacas'),
(393, 66, N'Puntarenas'),
(394, 66, N'Pitahaya'),
(395, 66, N'Chomes'),
(396, 66, N'Lepanto'),
(397, 66, N'Paquera'),
(398, 66, N'Manzanillo'),
(399, 66, N'Guacimal'),
(400, 66, N'Barranca'),
(401, 66, N'Monte Verde'),
(402, 66, N'Isla del Coco'),
(403, 66, N'Cóbano'),
(404, 66, N'Chacarita'),
(405, 66, N'Chira (Isla)'),
(406, 66, N'Acapulco'),
(407, 66, N'El Roble'),
(408, 66, N'Arancibia'),
(409, 67, N'Espíritu Santo'),
(410, 67, N'San Juan Grande'),
(411, 67, N'Macacona'),
(412, 67, N'San Rafael'),
(413, 67, N'San Jerónimo'),
(414, 68, N'Buenos Aires'),
(415, 68, N'Volcán'),
(416, 68, N'Potrero Grande'),
(417, 68, N'Boruca'),
(418, 68, N'Pilas'),
(419, 68, N'Colinas o Bajo de Maíz'),
(420, 68, N'Chánguena'),
(421, 68, N'Bioley'),
(422, 68, N'Brunka'),
(423, 69, N'Miramar'),
(424, 69, N'Unión'),
(425, 69, N'San Isidro'),
(426, 70, N'Puerto Cortés'),
(427, 70, N'Palmar'),
(428, 70, N'Sierpe'),
(429, 70, N'Bahía Ballena'),
(430, 70, N'Piedras Blancas'),
(431, 71, N'Quepos'),
(432, 71, N'Savegre'),
(433, 71, N'Naranjito'),
(434, 72, N'Golfito'),
(435, 72, N'Puerto Jiménez'),
(436, 72, N'Guaycará'),
(437, 72, N'Pavones'),
(438, 73, N'San Vito'),
(439, 73, N'Sabalito'),
(440, 73, N'Agua Buena'),
(441, 73, N'Limoncito'),
(442, 73, N'Pittier'),
(443, 74, N'Parrita'),
(444, 75, N'Corredores'),
(445, 75, N'La Cuesta'),
(446, 75, N'Paso Canoas'),
(447, 75, N'Laurel'),
(448, 76, N'Jacó'),
(449, 76, N'Tárcoles'),
(450, 77, N'Limón'),
(451, 77, N'Valle La Estrella'),
(452, 77, N'Río Blanco'),
(453, 77, N'Matama'),
(454, 78, N'Guápiles'),
(455, 78, N'Jiménez'),
(456, 78, N'Rita'),
(457, 78, N'Roxana'),
(458, 78, N'Cariari'),
(459, 78, N'Colorado'),
(460, 79, N'Siquirres'),
(461, 79, N'Pacuarito'),
(462, 79, N'Florida'),
(463, 79, N'Germania'),
(464, 79, N'Cairo'),
(465, 79, N'Alegría'),
(466, 80, N'Bratsi'),
(467, 80, N'Sixaola'),
(468, 80, N'Cahuita'),
(469, 80, N'Telire'),
(470, 81, N'Matina'),
(471, 81, N'Batán'),
(472, 81, N'Carrandí'),
(473, 82, N'Guácimo'),
(474, 82, N'Mercedes'),
(475, 82, N'Pocora'),
(476, 82, N'Río Jiménez'),
(477, 82, N'Duacarí');

-------------------------------------------------------------------------------------------------------------

INSERT INTO dbo.TipoServicio
(
    [Nombre],
    [Estado]
)
VALUES
('Agua', 1),
('Luz', 1),
('Telefonía', 1),
('Cable', 1);

-------------------------------------------------------------------------------------------------------------

INSERT INTO dbo.UnidadMedida
(
    [NombreUnidad],
    [Estado]
)
VALUES
('Megas', 1),
('Watts', 1),
('Litros', 1),
('Minutos', 1);

--###########################################################################################################

--###########################################################################################################
-------------------------------------------------------------------------------------------------------------
-- INSERTAR DATOS DE EJEMPLO
-------------------------------------------------------------------------------------------------------------

INSERT INTO dbo.Edificio ([NombreEdificio], [Capacidad], [FechaCompra], [IdProvincia], [IdCanton], [IdDistrito], [IdTipoPropiedad], [FechaFinalContrato], [Estado])
VALUES
( 'prueba', 2, N'2022-07-20T00:00:00', 1, 1, 1, 1, N'1900-01-01T00:00:00', 1 ), 
( 'Edificio2', 1, N'2022-07-27T00:00:00', 1, 18, 100, 2, N'2022-07-27T00:00:00', 1 )


-------------------------------------------------------------------------------------------------------------

INSERT INTO dbo.Servicio ([NombreServicio], [IdTipoServicio], [IdUnidadMedida], [Empresa], [Estado])
VALUES
( 'Agua', 1, 3, 'Acueductos', 1 )


-------------------------------------------------------------------------------------------------------------

INSERT INTO dbo.ServiciosXEdificio ([IdEdificio], [IdServicio], [FechaCorte], [Consumo])
VALUES
( 2, 1, N'2022-07-12T00:00:00', 2200 ), 
( 1, 1, N'2022-07-21T00:00:00', 100 )

--###########################################################################################################