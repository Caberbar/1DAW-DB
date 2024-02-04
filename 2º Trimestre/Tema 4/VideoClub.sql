CREATE DATABASE videoclub;

\c videoclub;

CREATE TABLE cliente
(NumeroSocio numeric(5) primary key, 
nombre char(30) not null,
apellido char (40),
direccion char (20),
codigo postal numeric(5),
poblacion char (15),
telefono numeric (9),
 )

INSERT INTO cliente VALUES(12345, 'Federico', 'Garcia Lorca', 'c/ Gran vía, 27', 18159, 'Granada', 658458963)
INSERT INTO cliente VALUES(12234, 'Jesus', 'Montoro Lopez', 'c/ San Agustin, 12', 18159, 'Jaen', 624781035)
INSERT INTO cliente VALUES(12223, 'Kanye', 'West', 'c/ Pajaros, 05', 18159, 'Lisboa', 632015987)
INSERT INTO cliente VALUES(12222, 'Beyonce', 'Giselle Knowles', 'c/ Elvira, 10', 18159, 'Murcia', 684201599)

CREATE TABLE pelicula
(codigo numeric(5) primary key, 
titulo char(30) not null,
año numeric(4),
genero char (15),
director char (15),
 )

INSERT INTO pelicula VALUES(12548, 'Kung Fu Panda', 2008, 'Ciencia Ficcion, comedia', 'Mark Osborne')
INSERT INTO pelicula VALUES(12547, 'Kung Fu Panda 2', 2011, 'Ciencia Ficcion, comedia', 'Jennifer Yuh Nelson')
INSERT INTO pelicula VALUES(12549, 'Kung Fu Panda 3', 2016, 'Ciencia Ficcion, comedia', 'Jennifer Yuh Nelson')

CREATE TABLE alquila
(fechaInicio date(20) primary key,
fechaFin date(20),
n 
)