CREATE TABLE cliente
(
    cedula_cliente integer PRIMARY KEY,
    nombre_cliente varchar(255),
    apellido_cliente varchar(255),
    telefono_cliente varchar(255),
    correo_cliente varchar(255),
    trabajo_cliente varchar(255),
    ciudad_cliente integer
);

INSERT into cliente
VALUEs
    (1312524275, 'Nayely', 'Alava', '0983104520', 'nayely@gmail.com', 'odontologa', 1)
INSERT into cliente
VALUEs
    (1717521345, 'Katty', 'Riera', '0953154555', 'katty@gmail.com', 'arquitecta', 4)
INSERT into cliente
VALUEs
    (1811554575, 'Angie', 'Alvarado', '0116104120', 'angie@gmail.com', 'doctora', 3)

CREATE TABLE ciudad
(
    --creacion de la tabla de ciudad
    id_ciudad integer primary key IDENTITY(1,1),
    nombre_ciudad varchar(255)
);
INSERT into ciudad
values('manta')
INSERT into ciudad
values('quito')
INSERT into ciudad
values('portoviejo')
INSERT into ciudad
values('santo domingo')
INSERT into ciudad
values('guayaquil')
INSERT into ciudad
values('loja')
INSERT into ciudad
values('machala')
INSERT into ciudad
values('chone')


create table sucursal
(
    -- creacion de la tabla sucursal
    cod_sucursal varchar(255) primary key,
    direccion_sucursal varchar(255),
    telefono_sucursal varchar(255),
    id_ciudad integer FOREIGN KEY(id_ciudad) REFERENCES ciudad(id_ciudad)
);

INSERT into sucursal
VALUES
    ('MTA1', 'barrio ursa', '0591849103', 1)
INSERT into sucursal
VALUES
    ('MTA2', 'ciudadela los electricos', '0151246109', 1)
INSERT into sucursal
VALUES
    ('STD1', 'Santa Bárbara', '0123859606', 4)
INSERT into sucursal
VALUES
    ('STD2', 'Gazcue', '0142242177', 4)
INSERT into sucursal
VALUES
    ('GY1', 'Barrio Las Peñas', '0332242188', 5)


DELETE FROM sucursal

SELECT *
FROM sucursal INNER JOIN ciudad on ciudad.id_ciudad = sucursal.id_ciudad INNER JOIN
    cliente on cliente.ciudad_cliente = ciudad.id_ciudad

create table promocion
(
    --creacion de la tabla promocion
    cod_promocion integer primary key IDENTITY(1,1),
    descrip_promocion varchar(255),
    descuento_promocion decimal(3,1),
    fechainicio_promocion DATE,
    fechalimite_promocion DATE,
    cod_sucursal varchar(255) foreign key (cod_sucursal) references sucursal(cod_sucursal)
);

INSERT INTO promocion
VALUES
    ('promoción navideña', 12, '2020-12-20', '2021-01-01', 'MTA1')
SELECT *
FROM promocion

create table dimension
(
    cod_dimension varchar(255) primary key,
    descrip_dimension VARCHAR (255),
    peso_paquete float,
    precio_peso float,
);

insert into dimension
values('px', 'Menos de 8 oz', 0.5, 2.0)
insert into dimension
values('md', 'De 8-16 oz', 1, 4.0)
insert into dimension
values('xl', 'De 16-32 oz', 2, 6.0)

select *
from dimension

create table urgencia
(
    cod_urgencia varchar(255) primary key,
    descrip_urgencia varchar(255),
    precio_urgencia float
);

insert into urgencia
VALUES
    ('URS', 'urgencia de bajo nivel', 1)
insert into urgencia
VALUES
    ('URM', 'urgencia de nivel intermedio', 2.5)
insert into urgencia
VALUES
    ('URX', 'urgencia de alto nivel', 5)


create table factura
(
    ruc_factura varchar(255) primary key,
    fecha_factura date,
    iva_factura DECIMAL(3,1),
    precio_total FLOAT,
    cod_sucursal varchar(255) FOREIGN KEY (cod_sucursal) REFERENCES sucursal(cod_sucursal),
    cedula_cliente integer FOREIGN KEY(cedula_cliente) REFERENCES cliente(cedula_cliente)
)

SELECT *
from factura;

CREATE TABLE paquete
(
    --creacion de la tabla paquete con referencias a la tabla ciudad, sucursal, cliente
    cod_paquete varchar(255) PRIMARY KEY,
    descrip_paquete varchar(255),
    usuario_destinatario varchar(255),
    valor_declarativo varchar(255),
    valor_transporte FLOAT,
    fecha_ingreso date,
    fecha_salida date,
    ciudad_destino integer FOREIGN KEY(ciudad_destino) REFERENCES ciudad(id_ciudad),
    cedula_cliente integer FOREIGN KEY(cedula_cliente) REFERENCES cliente(cedula_cliente),
    cod_sucursal varchar(255) FOREIGN KEY(cod_sucursal) REFERENCES sucursal(cod_sucursal),
    ruc_factura VARCHAR (255)FOREIGN KEY(ruc_factura) REFERENCES factura(ruc_factura),
    cod_urgencia VARCHAR (255)FOREIGN KEY(cod_urgencia) REFERENCES urgencia(cod_urgencia),
);

ALTER TABLE paquete
ADD  cod_dimension  varchar(255);

update paquete SET fecha_ingreso = '2020-07-20' WHERE cod_paquete = 'FME1'

select *
FROM paquete

insert into paquete
values
    ('FME3', 'caja de colchones', 'nahomy cevallos', 250, 10,
        '2020-10-15', '2020-10-20', 5, 1312524275, 'GY1', 'MTA134', 'URM');

SELECT*
FROM urgencia
SELECT *
FROM cliente
SELECT *
FROM sucursal
SELECT *
FROM factura
insert into factura
    (ruc_factura, fecha_factura, iva_factura, cod_sucursal , cedula_cliente)
VALUES('MTA134', '2020-10-15', 12, 'MTA2', 1312524275)

select *
from sucursal



SELECT *
FROM paquete;

insert into ciudad
values
    ('jipijapa', 5.25);
insert into sucursal
values
    ('AAOQK13', 'calle b10', '0999042140', 6);
INSERT INTO promocion
values
    ('DESCUENTO NAVIDEÑO', 2.10, 'OKOK');
insert into urgencia
values
    ('alto', 'estado de urgencia alta', 4.45);
insert into factura
values
    ('AQWD2112', '2015-11-11', 'ASC132A', '1911254271', 6, 'larga', 'alto', 1);
insert into paquete
values
    ('FME1', 'caja de camiseta', 'juan martiz', 40, 4,
        '2020-10-12', '2020-10-15', 1, 1717521345, 'MTA1', 'AAAD124', 'URS');
INSERT INTO factura
    (ruc_factura, fecha_factura, iva_factura, cod_sucursal, cedula_cliente)
VALUES
    ('AAAD124', '2020-11-12', 12 , 'STD1', '1717521345');


--pregunta 1 
SELECT ( SELECT COUNT(*)
    FROM paquete INNER JOIN sucursal
        on sucursal.cod_sucursal = paquete.cod_sucursal INNER JOIN
        ciudad on ciudad.id_ciudad = sucursal.id_ciudad
    where ciudad.nombre_ciudad = 'guayaquil') 
as total_de_paquetes


--pregunta 2

SELECT COUNT(cliente.cedula_cliente) as cant_p_enviados,
    nombre_cliente, apellido_cliente
FROM paquete INNER JOIN cliente on cliente.cedula_cliente =  paquete.cedula_cliente
GROUP BY cliente.cedula_cliente, nombre_cliente, apellido_cliente


--pregunta 3
select COUNT(sucursal.id_ciudad) as cantidad_paquete, nombre_ciudad
from factura INNER JOIN sucursal
    ON sucursal.cod_sucursal = factura.cod_sucursal
    INNER JOIN ciudad ON ciudad.id_ciudad = sucursal.id_ciudad
GROUP BY sucursal.id_ciudad, nombre_ciudad


--pregunta 4
SELECT paquete.usuario_destinatario, nombre_ciudad as ciudad_destino,
    paquete.cedula_cliente as cedula_emisor,
    CONCAT( (valor_transporte + precio_urgencia +  precio_peso), '$') costo_total
FROM paquete INNER JOIN
    ciudad on ciudad.id_ciudad = paquete.ciudad_destino
    INNER JOIN urgencia on urgencia.cod_urgencia   = paquete.cod_urgencia
    LEFT JOIN dimension on dimension.cod_dimension = paquete.cod_dimension;


--pregunta 5
SELECT *
FROM paquete
WHERE 
DATEPART(MONTH, fecha_ingreso) = 10



