DROP DATABASE IF EXISTS biblioteca;
CREATE DATABASE biblioteca;
USE biblioteca;

CREATE TABLE autores(
	id_autor INT UNSIGNED AUTO_INCREMENT,
    nombre VARCHAR(40) NOT NULL,
    pais VARCHAR(10),
    CONSTRAINT pk_autores PRIMARY KEY(id_autor)
);

CREATE TABLE libros(
id_libro INT UNSIGNED AUTO_INCREMENT,
titulo VARCHAR(30),
anio_publicacion YEAR,
id_autor INT UNSIGNED, 
CONSTRAINT pk_libros PRIMARY KEY(id_libro),
CONSTRAINT fp_libros_autores FOREIGN KEY(id_autor)
REFERENCES autores(id_autor) 
ON DELETE RESTRICT ON UPDATE CASCADE
);

INSERT INTO `biblioteca`.`autores`
(`id_autor`,
`nombre`,
`pais`)
VALUES
(1,
'Chaikovski',
'Rusia');

INSERT INTO `biblioteca`.`autores`
(
`nombre`,
`pais`)
VALUES
(
'Juan',
'España');
INSERT INTO `biblioteca`.`autores`
(`nombre`,
`pais`)
VALUES
(
'Jean Paul Sartre',
'Francia');

INSERT INTO `biblioteca`.`libros`
(`id_libro`,
`titulo`,
`anio_publicacion`,
`id_autor`)
VALUES
('1',
'Cronicas de una muerte',
'2005',
'1');
INSERT INTO `biblioteca`.`libros`
(
`titulo`,
`anio_publicacion`,
`id_autor`)
VALUES
('El fin del mundo',
'1987',
'1');

INSERT INTO `biblioteca`.`libros`
(
`titulo`,
`anio_publicacion`,
`id_autor`)
VALUES
(
'Muerte en benissa',
'2016',
'3');
INSERT INTO `biblioteca`.`libros`
(
`titulo`,
`anio_publicacion`,
`id_autor`)
VALUES
('no se xd',
'2017',
'2');
INSERT INTO `biblioteca`.`libros`
(
`titulo`,
`anio_publicacion`,
`id_autor`)
VALUES
(
'no se x2 xd',
'2017',
'2');


select libros.titulo, autores.nombre from libros
join autores using(id_autor);