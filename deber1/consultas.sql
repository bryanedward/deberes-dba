CREATE TABLE cliente(
	cedula_cliente integer PRIMARY KEY,
	nombre_cliente varchar(255),
	apellido_cliente varchar(255),
	telefono_cliente varchar(255),
	correo_cliente varchar(255),
	trabajo_cliente varchar(255),
	ciudad_cliente varchar(255),
	cod_sucursal varchar(255)
);

insert into cliente values(1311354373, 'paula', 'mercedes', '0950025125', 'paula@gmail.com', 'comerciante', 'manta', 'AAOQK13')
select * from cliente


CREATE TABLE paquete(	
	--creacion de la tabla paquete con referencias a la tabla ciudad, sucursal, cliente
	cod_paquete varchar(255) PRIMARY KEY,
	descrip_paquete varchar(255),
	usuario_destinatario varchar(255),
	valor_declarativo varchar(255),
	fecha_ingreso date,
	fecha_salida date,
	ciudad_final integer FOREIGN KEY(ciudad_final) REFERENCES ciudad(id_ciudad),
	cedula_cliente integer FOREIGN KEY(cedula_cliente) REFERENCES cliente(cedula_cliente),
	cod_sucursal varchar(255) FOREIGN KEY(cod_sucursal) REFERENCES sucursal(cod_sucursal)
);
insert into paquete values ('ASDH2F2', 'caja de camiseta','juan martiz', 40.45, 
'2008-11-11','2008-11-25', 9, 1311354373, 'OKOK')

CREATE TABLE ciudad(
	--creacion de la tabla de ciudad
	id_ciudad integer primary key IDENTITY(1,1),
	nombre_ciudad varchar(255),
	precio_envio float
);
insert into ciudad values ('jipijapa', 5.25)



create table sucursal(
	-- creacion de la tabla sucursal
	cod_sucursal varchar(255) primary key,
	direccion_sucursal varchar(255),
	telefono_sucursal varchar(255),
	id_ciudad integer FOREIGN KEY(id_ciudad) REFERENCES ciudad(id_ciudad)
);
insert into sucursal values ('AAOQK13', 'calle b10', '0999042140', 6)


create table promocion(
	--creacion de la tabla promocion
	id_promocion integer primary key IDENTITY(1,1),
	descrip_promocion varchar(255),
	descuento_promocion float,
	cod_sucursal varchar(255) foreign key (cod_sucursal) references sucursal(cod_sucursal)
);
INSERT INTO promocion values ('DESCUENTO NAVIDEÑO', 2.10, 'OKOK');

create table peso (
	dimension_paquete varchar(255) primary key,
	peso_paquete float,
	precio_peso float,
);
insert into peso values ('larga', 10, 7.15)

create table urgencia(
	nivel_urgencia varchar(255) primary key,
	descrip_urgencia varchar(255),
	precio_urgencia float
);
insert into urgencia values ('alto', 'estado de urgencia alta', 4.45);


create table factura(
	ruc_factura varchar(255) primary key,
	fecha_factura date,
	cod_paquete varchar (255) foreign key(cod_paquete) references paquete(cod_paquete),
	cedula_cliente integer FOREIGN KEY(cedula_cliente) REFERENCES cliente(cedula_cliente),
	id_ciudad integer FOREIGN KEY(id_ciudad) REFERENCES ciudad(id_ciudad),
	dimension_paquete varchar(255) foreign key(dimension_paquete) references peso(dimension_paquete),
	nivel_urgencia varchar(255) foreign key(nivel_urgencia) references urgencia(nivel_urgencia),
	id_promocion integer foreign key(id_promocion) references promocion(id_promocion)
)
insert into factura values ('AQWD2112', '2015-11-11', 'ASC132A','1911254271', 6, 'larga', 'alto', 1);


--primer pregunta
SELECT ( SELECT COUNT(*)​
FROM paquete) AS cantidad_total_de_paquetes

--segunda pregunta
select cliente.cedula_cliente, cliente.nombre_cliente,
promocion.descrip_promocion ,promocion.descuento_promocion,
CONCAT(SUM(urgencia.precio_urgencia + peso.precio_peso + ciudad.precio_envio),'$') valor_normal,
CONCAT(SUM(urgencia.precio_urgencia + peso.precio_peso + ciudad.precio_envio) - promocion.descuento_promocion,'$') valor_descuento
from cliente inner join factura
on factura.cedula_cliente = cliente.cedula_cliente inner join urgencia
on urgencia.nivel_urgencia = factura.nivel_urgencia inner join peso
on peso.dimension_paquete = factura.dimension_paquete inner join ciudad
on ciudad.id_ciudad = factura.id_ciudad inner join promocion
on promocion.id_promocion= factura.id_promocion
group by cliente.cedula_cliente, promocion.descuento_promocion, 
cliente.nombre_cliente,promocion.descrip_promocion 


--tercer pregunta
select * from paquete where CAST(fecha_ingreso as date) = CAST('2019-11-11' as date)



-- cuarta pregunta
select nombre_ciudad, CONCAT(precio_envio, '$') precio_envio, paquete.descrip_paquete 
from paquete inner join ciudad on ciudad.id_ciudad = 
paquete.ciudad_final
where nombre_ciudad = 'guayaquil' group by precio_envio, nombre_ciudad, paquete.descrip_paquete;


--quinta pregunta
select top 1 *
  from paquete
 order by fecha_ingreso desc