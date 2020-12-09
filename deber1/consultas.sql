CREATE TABLE clientes
(
    id_cliente INTEGER PRIMARY KEY,
    nombre varchar(255),
    telefono varchar(255),
    correo varchar(255),
    direccion varchar(255),
    trabajo varchar(255)
);

INSERT INTO clientes
    (id_cliente, nombre, telefono, correo, direccion, trabajo)
VALUES
    (2, 'eduardo', '0983803020', 'eduardo89@gmail.com', 'barrio ursa', 'perchero en el local tia')


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






-- CONSULTAR LAS TABLAS DE LA BASE DE DATOS
SELECT *
FROM sucursales


--CONTAR LA CANTIDAD DE PAQUETES QUE EXISTEN  ACTUALMENTE
SELECT ( SELECT COUNT(*)
    FROM paquetes) AS cantidad_total_de_paquetes


--relacionar paquetes con clientes
-- Consultar un determinado cliente cuantos paquetes envia
SELECT destinatario, fecha, urgencia, id_paquete
FROM paquetes
    INNER JOIN clientes
    ON paquetes.id_cliente = clientes.id_cliente
WHERE paquetes.id_cliente = 1;



-- buscar en que ciudad existen mayor cantidad de clientes que ocupan el servicio
SELECT id_ciudad, COUNT( id_ciudad ) AS total
FROM paquetes
GROUP BY id_ciudad
ORDER BY total DESC;


--¿Cuántos paquetes son enviados a una determinada ciudad? 
SELECT id_paquete, destinatario, fecha , nombre AS ciudad_envio, valor
FROM paquetes
    INNER JOIN ciudades
    ON paquetes.id_ciudad = ciudades.id_ciudad
WHERE ciudades.nombre LIKE 'quito'; 



