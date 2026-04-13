-- 1 Fase 0: Preparación del Entorno
use gha_analytics;
/* Analizar la base de datos*/
show tables;
SELECT 
    *
FROM
    especialidades;
SELECT 
    *
FROM
    medicos;
SELECT 
    *
FROM
    pacientes;
SELECT 
    *
FROM
    raw_import_visitas;
SELECT 
    raw_data
FROM
    raw_import_visitas;-- ??
SELECT 
    *
FROM
    visitas;


-- 2 Escenario 1: Blindaje Estructural (6 Puntos)

/*select * from pacientes 
p1 join pacientes p2 on p1.nombre_completo=p2.nombre_completo where p1.id!=p2.id;
Esta es una forma de hacer que te muestren los duplicados, funciona pero no es eficiente, por ello se opta por esta otra opción(dada por mi querido amigo chatgpt)
También hay otra opción para poder apreciar la consulta, pero es muy similar a la dad en este comentario*/
SELECT 
    *
FROM
    pacientes
WHERE
    nif IN (SELECT 
            nif
        FROM
            pacientes
        GROUP BY nif
        HAVING COUNT(*) > 1);
SELECT 
    nif, COUNT(*)
FROM
    pacientes
GROUP BY nif
HAVING COUNT(*) > 1;
SELECT 
    p1.*
FROM
    pacientes p1
        JOIN
    pacientes p2 ON p1.nif = p2.nif AND p1.id > p2.id;
    
/*Vistos los datos repedtidos, ahora se procederá realizar los respectivbos cambios*/

START TRANSACTION;
SET SQL_SAFE_UPDATES=0;
UPDATE pacientes 
SET 
    nombre_completo = TRIM(REPLACE(nombre_completo, '  ', ' '));
UPDATE pacientes 
SET 
    nif = TRIM(REPLACE(nif, '-', '')); /* se corrige este campo para evitar poblemas a futuro con la unificacion de filas repetidas, pero por
    un valor más didactico(en caso de que se vuelva a revisar el presente documento a modo de apuntes y repaso), se repite esta sentencia a la hora de darle
    un formato al nif*/


/*rollback;*/
/*A pesar de existir dos maneras, ene ste documento, de llegar a los pacientes, se opta por solo mostrar una solucion, para eliminar a aquellos que tienen datos repetidos*/
DELETE p1 FROM pacientes p1
        JOIN
    pacientes p2 ON p1.nif = p2.nif AND p1.id > p2.id;

 -- rollback
 commit;
 SET SQL_SAFE_UPDATES=1;
 
 
 START TRANSACTION; -- hay que aclarar que iniciar un SAFE TRANSACTION AQUÍ ES ESTÚPIDAMENTE INNECESARIO; ESTO DEBIDO A QUE SOLO FUNCIONA CUANDO SE MODIFICAN ASPECTOS DE LA TABLA INTERIORMENTE
 -- DE HECHO; NO SE RECOMIENDA HACER UN ALTER TABLE DENTRO DE UNA SENTENCIA START TRANSACTION, PROVOCARÍA UN COMMIT Y HARÍA QUE NO SE PUEDA VOLVER ATRÁS CON LOS CAMBIOS
 -- SET SQL_SAFE_UPDATES=0;
 ALTER TABLE pacientes
	ADD CONSTRAINT chk_nif CHECK (nif REGEXP '^[0-9]{8}[A-Z]$');
-- ROLLBACK;
/*AQUÍ SE GENERA UN ERROR. LO QUE SE DEBE HACER ES PRIMERO CAMBIAR LOS VALORES QUE NO CUMPLEN EL FORMATO , por lo que se observará a los mismos*/


SET SQL_SAFE_UPDATES=0;
START TRANSACTION;
SELECT * FROM pacientes; /*se puede ver que hay errores con espacios y caractetres no deseados(-), además se va a generar un problema con respecto a un nif que se
describe como "NULL_NIF", habría que ponerlo como 99999999A, evitando que se parezca al nif que tiene como numero 99999999Z para evitar problemas al hacer que el campo
de nif sea UNIQUE*/
UPDATE pacientes SET nif = TRIM(REPLACE(nif,'-',''));
SELECT * FROM pacientes;
UPDATE pacientes SET nif = REPLACE(nif, 'NULL_NIF', '99999999A');
-- rollback;
COMMIT;
/*Una vez hechos los cambios, se procedera a añadir el formato con el alter table*/
ALTER TABLE pacientes
	ADD CONSTRAINT chk_nif CHECK (nif REGEXP '^[0-9]{8}[A-Z]$');
 SET SQL_SAFE_UPDATES=1;
 