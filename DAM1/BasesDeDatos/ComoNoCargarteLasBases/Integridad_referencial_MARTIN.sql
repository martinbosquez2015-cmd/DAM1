DROP DATABASE IF EXISTS integridad_referencial;
CREATE DATABASE integridad_referencial;
USE integridad_referencial;
-- 1. Tabla Padre (Nivel 1)
CREATE TABLE departamentos (
id_dept INT PRIMARY KEY,
nombre VARCHAR(50)
);
-- 2. Tabla Intermedia (Nivel 2)
CREATE TABLE profesores (
id_prof INT PRIMARY KEY,
nombre VARCHAR(50),
id_dept INT,
CONSTRAINT fk_prof_dept FOREIGN KEY (id_dept)
REFERENCES departamentos(id_dept)
ON DELETE SET NULL
);
-- 3. Tabla Intermedia (Nivel 3)
CREATE TABLE modulos (
id_mod INT PRIMARY KEY,
siglas VARCHAR(10),
id_prof INT,
CONSTRAINT fk_mod_prof FOREIGN KEY (id_prof)
REFERENCES profesores(id_prof)
ON DELETE RESTRICT
ON UPDATE CASCADE
);
-- 4. Tabla Hija Final (Nivel 4)
CREATE TABLE matriculas (
id_matricula INT PRIMARY KEY,
alumno VARCHAR(50),
id_mod INT,
CONSTRAINT fk_mat_mod FOREIGN KEY (id_mod)
REFERENCES modulos(id_mod)
ON DELETE CASCADE
);
-- INSERCION DE DATOS DE PRUEBA
INSERT INTO departamentos VALUES (10, 'Informatica y Comunicaciones'), (20, '
Formacion y Orientacion Laboral');
INSERT INTO profesores VALUES (1, 'Ada', 10), (2, 'Alan', 10), (3, 'Grace', 20);
INSERT INTO modulos VALUES (101, 'GBD', 1), (102, 'ASO', 1), (103, 'LMSGI', 2);
INSERT INTO matriculas VALUES (1001, 'Estudiante A', 101), (1002, 'Estudiante B',
101), (1003, 'Estudiante C', 103);
show tables;
select * from departamentos;
select * from matriculas;
select * from modulos;
select * from profesores;


select * from modulos;
SET SQL_SAFE_UPDATES = 0;
UPDATE profesores SET id_prof = 99 where id_prof= 1;

select * from modulos;

DELETE FROM profesores where id_prof = 2;

Select * from profesores;
DELETE from departamentos where id_dept = 20;
select * from profesores;


Select * from matriculas;
delete from modulos where id_mod = 101;
select * from matriculas;