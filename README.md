# DOCUMENTACION DE BASE DE DATOS
---

# TABLAS 

## **Canton**

| Campo | Tipo | Descripcion |
| ------ | -------- | --------- |
| Id  | int  | Identificador del registro |
| IdProvincia    | int   | Identificador de la provincia |
| Nombre    | nvarchar (255)   | Nombre del canton |
||||


Codigo en sql
```sql
CREATE TABLE [dbo].[Canton](
	[Id] [int] NULL,
	[IdProvincia] [int] NULL,
	[Nombre] [nvarchar](255) NULL
) ON [PRIMARY]
GO
```

## **Distrito**

| Campo | Tipo | Descripcion |
| ------ | -------- | --------- |
| Id  | int  | Identificador del registro |
| IdCanton    | int   | Identificador del canton |
| Nombre    | nvarchar (255)   | Nombre del distrito |
||||


Codigo en sql
```sql
CREATE TABLE [dbo].[Distrito](
	[Id] [int] NULL,
	[IdCanton] [int] NULL,
	[Nombre] [nvarchar](255) NULL
) ON [PRIMARY]
GO
```

## **Edificio**

| Campo | Tipo | Descripcion |
| ------ | -------- | --------- |
| Id  | int  | Identificador del registro |
| NombreEdificio    | varchar (200)   | Nombre del edificio |
| Capacidad    | int  | Capacidad del edificio |
| FechaCompra    |datetime  | Fecha de compra |
| IdProvincia    | int   | Nombre de la provincia |
| IdCanton    | int   | Nombre del canton |
| IdDistrito    | int   | Nombre del distrito |
| IdTipoPropiedad    | int   |Tipo de propiedad |
| FechaFinalContrato    | datetime   |Fecha Final del Contrato |
| Estado    | bit   | Estado del registro [0=inactivo, 1=activo]|
||||

Codigo en sql
```sql
CREATE TABLE [dbo].[Edificio](
	[Id] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY, 
	[NombreEdificio] [varchar](200) NOT NULL,
	[Capacidad] [int] NOT NULL,
	[FechaCompra] [datetime] NOT NULL,
	[IdProvincia] [int] NOT NULL,
	[IdCanton] [int] NOT NULL,
	[IdDistrito] [int] NOT NULL,
	[IdTipoPropiedad] [int] NOT NULL,
	[FechaFinalContrato] [datetime] NULL,
	[Estado] [bit] NULL)
GO
```

## **Provincia**

| Campo | Tipo | Descripcion |
| ------ | -------- | --------- |
| Id  | int  | Identificador del registro |
| Nombre    | nvarchar (255)   | Nombre de la provincia |
||||


Codigo en sql
```sql
CREATE TABLE [dbo].[Provincia](
	[Id] [int] NULL,
	[Nombre] [nvarchar](255) NULL
) ON [PRIMARY]
GO
```

## **Servicio**

| Campo | Tipo | Descripcion |
| ------ | -------- | --------- |
| Id  | int  | Identificador del registro |
| NombreServicio    | varchar (200)  | Nombre del servicio |
| IdTipoServicio    | int  | Tipo del servicio |
| IdUnidadMedida    |int  | Unidad de medida |
| Empresa    | varchar (200)   |Nombre de la empresa que provee el servicio |
| Estado    | bit   | Estado del registro [0=inactivo, 1=activo]|
||||

Codigo en sql
```sql
CREATE TABLE [dbo].[Servicio](
	[Id] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[NombreServicio] [varchar](200) NOT NULL,
	[IdTipoServicio] [int] NOT NULL,
	[IdUnidadMedida] [int] NOT NULL,
	[Empresa] [varchar](200) NOT NULL,
	[Estado] [bit] NULL)
GO
```

## **ServiciosXEdificio**

| Campo | Tipo | Descripcion |
| ------ | -------- | --------- |
| Id  | int  | Identificador del registro |
| IdEdificio  | int  | Identificador del edificio |
| IdServicio    | int   | Identificador del servicio |
| FechaCorte    | datetime   | Fecha del corte |
| Consumo    | float   | Consumo de acuerdo con la unidad de medida  |
||||


Codigo en sql
```sql
CREATE TABLE [dbo].[ServiciosXEdificio](
	[Id] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[IdEdificio] [int] NOT NULL,
	[IdServicio] [int] NOT NULL,
	[FechaCorte] [datetime] NOT NULL,
	[Consumo] [float] NULL) 
GO
```

## **TipoServicio**

| Campo | Tipo | Descripcion |
| ------ | -------- | --------- |
| Id  | int  | Identificador del registro |
| Nombre    | nvarchar (100)   | Nombre del tipo de servicio |
| Estado    | bit   | Estado del registro [0=inactivo, 1=activo]|
||||


Codigo en sql
```sql
CREATE TABLE [dbo].[TipoServicio](
	[Id] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[Nombre] [varchar](100) NOT NULL,
	[Estado] [bit] NOT NULL)
GO
```

## **UnidadMedida**

| Campo | Tipo | Descripcion |
| ------ | -------- | --------- |
| Id  | int  | Identificador del registro |
| NombreUnidad    | varchar (100)    | Nombre de la Unidad de Medida |
| Estado    | bit   | Estado del registro [0=inactivo, 1=activo]|
||||


Codigo en sql
```sql
CREATE TABLE [dbo].[UnidadMedida](
	[Id] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[NombreUnidad] [varchar](100) NOT NULL,
	[Estado] [bit] NOT NULL)
GO
```
---
# PROCEDIMIENTOS ALMACENADOS

| Tabla | Procedimiento | Descripcion |
| ------ | -------- | --------- |
| Canton  | usp_canton_listar  | Listar los cantones |
| Canton   | usp_canton_obtener   | Obtener un canton por Id|
| Distrito   | usp_distrito_listar   | Listar los distritos|
| Distrito   | usp_distrito_obtener  | Obtener un distrito por Id|
| Edificio  | usp_edificio_eliminar  | Eliminar un edificio |
| Edificio  |usp_edificio_guardar  | Guardar un edificio|
| Edificio  | usp_edificio_listar  | Listar los edificios |
| Edificio   | usp_edificio_obtener  | Obtener un edificio por Id|
| Provincia  | usp_provincia_listar  | Listar las provincias |
| Servicio  | usp_servicio_eliminar  | Eliminar un Servicio |
| Servicio  |usp_servicio_guardar  | Guardar un Servicio|
| Servicio  |usp_servicio_listar | Listar los Servicios |
| Servicio   | usp_servicio_obtener  | Obtener un Servicio por Id|
| Serviciosxedificio  | usp_serviciosxedificio_eliminar  | Eliminar un servicio relacionado a un edificio |
| Serviciosxedificio  |usp_serviciosxedificio_guardar | Relacionar un servicio a un edificio|
| Serviciosxedificio  | usp_serviciosxedificio_listar | Listar los servicios relacionados a un edificio |
| Tiposervicio  |usp_tiposervicio_listar | Listar los tipos de servicio |
| Unidadmedida  |usp_unidadmedida_listar | Listar las unidades de medida |
||||
---

# CATALOGOS POR DEFECTO

## **Tipos de servicio**

| Id | Nombre 
| ------ | -------- | 
| 1  |  Agua | 
| 2    |  Luz  | 
| 3  | Telefonía  | 
| 4  |  Cable  | 
||||

## **Unidad de medida**


| Id | Nombre 
| ------ | -------- | 
| 1  |  Megas | 
| 2    |   Watts | 
| 3  |  Litros | 
| 4  |  Minutos  | 
||||

## **Provincias**
Catalogo correspondiente con las provincias

## **Cantones**
Catalogo correspondiente con los cantones

## **Distritos**
Catalogo correspondiente con los distritos

---


