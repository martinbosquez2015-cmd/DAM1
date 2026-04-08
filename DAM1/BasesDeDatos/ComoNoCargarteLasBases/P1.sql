use gha_analytics;
/* Analizar la base de datos*/
show tables;
select * from pacientes;
select * from pacientes 
p1 join pacientes p2 on p1.nombre_completo=p2.nombre_completo where p1.id!=p2.id;

SELECT * from pacientes p1 join pacientes p2 using(id) where p1.nombre_completo=p2.nombre_completo;
select *,(select 1 from pacientes p2 where p1.nif=p2.nif) from pacientes p1;-- no vale
select * from pacientes p1 where nombre_completo in (select * from pacientes group by nombre_completo having count(*)>1);
SELECT *
FROM pacientes
WHERE nombre_completo IN (
    SELECT nombre_completo
    FROM pacientes
    GROUP BY nombre_completo
    HAVING COUNT(*) > 1
);
SELECT p1.*
FROM pacientes p1
JOIN pacientes p2
  ON p1.nif = p2.nif
 AND p1.id > p2.id;
START TRANSACTION;
SET SQL_SAFE_UPDATES=0;
UPDATE pacientes SET nombre_completo = TRIM(REPLACE(nombre_completo, '  ', ' '));
select * from pacientes;
/*rollback;*/

/*START TRANSACTION;*/
DELETE p1
FROM pacientes p1
JOIN pacientes p2
  ON p1.nif = p2.nif
 AND p1.id > p2.id;
 -- rollback
 commit;
 SET SQL_SAFE_UPDATES=1;
 
 
 START TRANSACTION;
 SET SQL_SAFE_UPDATES=0;
 ALTER TABLE pacientes
	ADD CONSTRAINT chk_nif CHECK (nif REGEXP '^[0-9]{8}[A-Z]$');
ROLLBACK;
/*AQUÍ SE GENERA UN ERROR. LO QUE SE DEBE HACER ES PRIMERO CAMBIAR LOS VALORES QUE NO CUMPLEN EL FORMATO*/
 
 