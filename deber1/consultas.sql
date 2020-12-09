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


-- ¿Cuáles son los costos de cada cliente que ha ocupado el servicio?
SELECT ciudades.nombre as ciudad_envio, clientes.nombre as remitente,
    CONCAT(SUM(ciudades.valor), '$') ganancia_total
FROM clientes INNER JOIN paquetes on paquetes.id_ciudad = clientes.id_cliente
    INNER JOIN ciudades on ciudades.id_ciudad = paquetes.id_ciudad
GROUP BY ciudades.nombre, clientes.nombre


--consultar los paquetes enviados en una fecha especifica
-- mostrando el costo de envio
SELECT destinatario , CAST(fecha AS datetime ) , clientes.nombre as remitente,
    sucursales.ciudad AS ciudad_de_la_sucursal, ciudades.nombre as ciudad_envio,
    CONCAT(ciudades.valor, '$') AS costo_envio_ciudad
FROM paquetes
    INNER JOIN clientes ON clientes.id_cliente = paquetes.id_cliente
    INNER JOIN sucursales ON sucursales.id_sucursal = paquetes.id_sucursal
    INNER JOIN ciudades ON ciudades.id_ciudad = paquetes.id_ciudad
WHERE CAST(fecha AS date)  = CAST('2020-12-12' AS date)


--¿Cuántos paquetes son enviados a una determinada ciudad y cuanto es la ganancia que se obtuvo con los viajes?​
-- consultar todos los paquetes que son enviados a quito
SELECT id_paquete, destinatario, fecha , nombre AS ciudad_envio, valor
FROM paquetes
    INNER JOIN ciudades
    ON paquetes.id_ciudad = ciudades.id_ciudad
WHERE ciudades.nombre LIKE 'quito';

--obtener la ganancia total de los que se obtuvo de los paquetes enviados a una determinada
-- ciudad
SELECT ciudades.nombre , valor,
    CONCAT(SUM(ciudades.valor), '$') ganancia_total
FROM paquetes
    INNER JOIN ciudades
    ON paquetes.id_ciudad = ciudades.id_ciudad INNER JOIN clientes ON paquetes.id_cliente = clientes.id_cliente
WHERE ciudades.nombre LIKE 'manta'
GROUP BY ciudades.nombre, ciudades.valor

​