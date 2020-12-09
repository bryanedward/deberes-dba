CREATE TABLE clientes
(
    id_cliente INTEGER PRIMARY KEY,
    nombre varchar(255),
    telefono varchar(255),
    correo varchar(255),
    direccion varchar(255),
    trabajo varchar(255)
);

CREATE TABLE sucursales
(
    id_sucursal INTEGER PRIMARY KEY,
    ciudad varchar(255),
    direccion varchar(255),
    telefono varchar(255),
);


CREATE TABLE ciudades
(
    id_ciudad INTEGER PRIMARY KEY,
    nombre varchar(255),
    valor FLOAT
);


CREATE TABLE peso
(
    id_peso INTEGER PRIMARY KEY,
    valor FLOAT
);

CREATE TABLE paquetes
(
    id_paquete INTEGER PRIMARY KEY,
    destinatario varchar(255),
    urgencia BIT,
    fecha DATE,
    id_ciudad INTEGER,
    id_peso INTEGER,
    id_sucursal INTEGER,
)
