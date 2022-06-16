---SCRIPT PRUEBA TÉCNICA---
---AUTHOR: DIEGO ARMIRA 
---FECHA: JUNIO 2022


/**************************************USER**************************************/
--comando para limpiar la tabla 
DELETE [bam].[dbo].[user]

--comando para eliminar la tabla 
DROP TABLE IF EXISTS [bam].[dbo].[user]

--comando para crear la tabla bien 
CREATE TABLE [bam].[dbo].[user]
(
	id_user INTEGER IDENTITY(1,1) PRIMARY KEY, 
    dpi VARCHAR(200),
    estado INTEGER,
    fullname VARCHAR(200),
    edad VARCHAR(200),
    email VARCHAR(200),
    adress VARCHAR(200),
    celular VARCHAR(200)

);

/**************************************ROL_ASIGNADO**************************************/
--comando para limpiar la tabla 
DELETE [bam].[dbo].[rol_asignado]

--comando para eliminar la tabla 
DROP TABLE IF EXISTS [bam].[dbo].[rol_asignado]

--comando para crear la tabla bien 
CREATE TABLE [bam].[dbo].[rol_asignado]
(
	id_rol_asignado INTEGER IDENTITY(1,1) PRIMARY KEY, 
    tipo_rol INTEGER,
    fecha_ini DATE,
    fecha_fin DATE,
    fk_id_user INTEGER NOT NULL,

    FOREIGN KEY (fk_id_user) REFERENCES [bam].[dbo].[user](id_user)


);

/**************************************CLIENTE**************************************/
--comando para limpiar la tabla 
DELETE [bam].[dbo].[cliente]

--comando para eliminar la tabla 
DROP TABLE IF EXISTS [bam].[dbo].[cliente]

--comando para crear la tabla bien 
CREATE TABLE [bam].[dbo].[cliente]
(
	id_cliente INTEGER IDENTITY(1,1) PRIMARY KEY, 
    dpi VARCHAR(200),
    estado INTEGER,
    fullname VARCHAR(200),
    edad VARCHAR(200),
    email VARCHAR(200),
    adress VARCHAR(200),
    celular VARCHAR(200)

);

/*****************************CARRO*****************************/
--comando para limpiar la tabla 
DELETE [bam].[dbo].[carro]

--comando para eliminar la tabla 
DROP TABLE IF EXISTS [bam].[dbo].[carro]

--comando para crear la tabla bien 
CREATE TABLE [bam].[dbo].[carro]
(
	id_car INTEGER IDENTITY(1,1) PRIMARY KEY, 
    nombre VARCHAR(200),
    descripcion VARCHAR(200),
    estado INTEGER,
    depreciacion REAL, 
    capacidad REAL, 
    consumo REAL,
    ubicacion VARCHAR(200)

);


/*****************************DOCUMENTO*****************************/
--comando para limpiar la tabla 
DELETE [bam].[dbo].[documento]

--comando para eliminar la tabla 
DROP TABLE IF EXISTS [bam].[dbo].[documento]

--comando para crear la tabla bien 
CREATE TABLE [bam].[dbo].[documento]
(
	id_documento INTEGER IDENTITY(1,1) PRIMARY KEY, 
    descripcion VARCHAR(200)

);

/*****************************OTROS GASTOS*****************************/
--comando para limpiar la tabla 
DELETE [bam].[dbo].[bill]

--comando para eliminar la tabla 
DROP TABLE IF EXISTS [bam].[dbo].[bill]

--comando para crear la tabla bien 
CREATE TABLE [bam].[dbo].[bill]
(
	id_bill INTEGER IDENTITY(1,1) PRIMARY KEY, 
    descripcion VARCHAR(200),
    monto REAL

);


/*****************************FACTURA*****************************/
--comando para limpiar la tabla 
DELETE [bam].[dbo].[factura]

--comando para eliminar la tabla 
DROP TABLE IF EXISTS [bam].[dbo].[factura]

--comando para crear la tabla bien 
CREATE TABLE [bam].[dbo].[factura]
(
	id_factura INTEGER IDENTITY(1,1) PRIMARY KEY, 
    fecha DATE,
    direccion VARCHAR (200), 
    estado INTEGER, 
    cliente_id INTEGER NOT NULL,
    vendedor_id INTEGER NOT NULL,

    FOREIGN KEY (cliente_id) REFERENCES [bam].[dbo].[user](id_user),
    FOREIGN KEY (vendedor_id) REFERENCES [bam].[dbo].[user](id_user)
);


/****************************************************************************************/
/*********************************ASIGNAR CARRO A PILOTO*********************************/
--comando para limpiar la tabla 
DELETE [bam].[dbo].[asignar_car]

--comando para eliminar la tabla 
DROP TABLE IF EXISTS [bam].[dbo].[asignar_car]

--comando para crear la tabla bien 
CREATE TABLE [bam].[dbo].[asignar_car]
(
    id_asignar INTEGER IDENTITY(1,1) PRIMARY KEY, 
    user_id INTEGER NOT NULL,
    car_id INTEGER NOT NULL,
    estado INTEGER NOT NULL,

    FOREIGN KEY (user_id) REFERENCES [bam].[dbo].[user](id_user), 
    FOREIGN KEY (car_id) REFERENCES [bam].[dbo].[car](id_car) 
);



/*********************************VIAJE*********************************/
--comando para limpiar la tabla 
DELETE [bam].[dbo].[viaje]

--comando para eliminar la tabla 
DROP TABLE IF EXISTS [bam].[dbo].[viaje]

--comando para crear la tabla bien 
CREATE TABLE [bam].[dbo].[viaje]
(
    id_viaje INTEGER IDENTITY(1,1) PRIMARY KEY,
    fecha_ini DATE,
    fecha_fin DATE,
    direccion_ini VARCHAR(200),
    direccion_fin VARCHAR(200),
    cargo_cliente REAL,
    estado INTEGER, 

    bill_add_id INTEGER NOT NULL, 
    cliente_id INTEGER NOT NULL, 
    vendedor_id INTEGER NOT NULL,
    vehiculo_piloto_id INTEGER NOT NULL,
    documentacion_id INTEGER NOT NULL,

    FOREIGN KEY (bill_add_id) REFERENCES [bam].[dbo].[bill](id_bill), 
    FOREIGN KEY (cliente_id) REFERENCES [bam].[dbo].[user](id_user),
    FOREIGN KEY (vendedor_id) REFERENCES [bam].[dbo].[user](id_user),
    FOREIGN KEY (vehiculo_piloto_id) REFERENCES [bam].[dbo].[asignar_car](id_asignar),
    FOREIGN KEY (documentacion_id) REFERENCES [bam].[dbo].[documento](id_documento)
);


/*********************************ASIGNAR PASAJERO*********************************/
--comando para limpiar la tabla 
DELETE [bam].[dbo].[asignar_pasajero]

--comando para eliminar la tabla 
DROP TABLE IF EXISTS [bam].[dbo].[asignar_pasajero]

--comando para crear la tabla bien 
CREATE TABLE [bam].[dbo].[asignar_pasajero]
(

    user_id INTEGER NOT NULL,
    viaje_id INTEGER NOT NULL,
    estado INTEGER NOT NULL,

    FOREIGN KEY (user_id) REFERENCES [bam].[dbo].[user](id_user), 
    FOREIGN KEY (viaje_id) REFERENCES [bam].[dbo].[viaje](id_viaje) 
);

/*********************************DETALLE FACTURA*********************************/
--comando para limpiar la tabla 
DELETE [bam].[dbo].[detalle_factura]

--comando para eliminar la tabla 
DROP TABLE IF EXISTS [bam].[dbo].[detalle_factura]

--comando para crear la tabla bien 
CREATE TABLE [bam].[dbo].[detalle_factura]

CREATE TABLE [bam].[dbo].[detalle_factura]
(
    descripcion VARCHAR(200),
    monto REAL, 
    factura_id INTEGER NOT NULL,
    viaje_id INTEGER NOT NULL,

    FOREIGN KEY (factura_id) REFERENCES [bam].[dbo].[factura](id_factura), 
    FOREIGN KEY (viaje_id) REFERENCES [bam].[dbo].[viaje](id_viaje)
    
);




