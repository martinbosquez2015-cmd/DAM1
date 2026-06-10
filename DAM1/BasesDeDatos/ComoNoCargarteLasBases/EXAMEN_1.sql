/*
=====================================================================
_____________________________________________________________________
---------------------------------------------------------------------
EXAMEN DE BASES
---------------------------------------------------------------------
_____________________________________________________________________
=====================================================================
*/


use logistica_global;

/*
=====================================================================
1. Gestion Salarial
=====================================================================
*/
	SELECT * FROM empleados where salario_base_sucio not like '% EUR'; -- ignoramos las ùltimas insersiones isn sentido

	ALTER TABLE empleados 
		ADD COLUMN salario_neto DECIMAL(10,2) NOT NULL DEFAULT 0;-- columna añadida
	SELECT SUBSTRING_INDEX(salario_base_sucio, ' EUR', 1) FROM empleados;-- consulta de prueba
    SET SQL_SAFE_UPDATES = 0;
    START TRANSACTION;
		UPDATE empleados SET salario_neto = 
        CASE
			WHEN salario_base_sucio NOT LIKE '% EUR' THEN 0
			ELSE 
				CAST(SUBSTRING_INDEX(salario_base_sucio, ' EUR', 1) AS DECIMAL(10,2)) -- pregunto lo del commit primero y luego seguimos y ejecutamos el ejercicio
		END;
	SAVEPOINT primer_commit;
        UPDATE empleados SET salario_neto = salario_neto * 0.85;
	ROLLBACK TO SAVEPOINT primer_commit;
		UPDATE empleados SET salario_neto = salario_neto * 0.82;
		SELECT * FROM empleados;
	COMMIT;
    SET SQL_SAFE_UPDATES = 1;
		

 /*
=====================================================================
2. Saneamiento de infraestructura
=====================================================================
*/
	SELECT * FROM almacenes;
    -- primero saneamos los nombres
    SET SQL_SAFE_UPDATES = 0;
    START TRANSACTION;
		UPDATE almacenes SET cod_almacen = TRIM(REPLACE(cod_almacen, '_',''));
	DELETE a1 FROM almacenes a1 join almacenes a2 on a1.cod_almacen=a2.cod_almacen
    where (length(a1.nombre_sucursal)<length(a2.nombre_sucursal) or ( length(a1.nombre_sucursal) = length(a2.nombre_sucursal) AND a1.id>a2.id));
    COMMIT;
    SET SQL_SAFE_UPDATES = 1;
    

  /*
=====================================================================
3. Integridad de plantilla
=====================================================================
*/   
	-- primero vemos los almacenes ids a los que se apuntan y no existen
    SELECT * FROM empleados;-- en realidad todo està a null, pero no le voy a tomar importancia
    SELECT * FROM empleados WHERE almacen_id NOT IN (SELECT id FROM almacenes);
    SET SQL_SAFE_UPDATES = 0;
    START TRANSACTION;
		UPDATE empleados SET almacen_id = 
			1 WHERE almacen_id NOT IN (SELECT id FROM almacenes);
	COMMIT;
    ALTER TABLE empleados
		ADD CONSTRAINT fk_empleados_almacenes FOREIGN KEY (almacen_id)
			REFERENCES almacenes(id)
            ON DELETE RESTRICT ON UPDATE CASCADE;
            
/*
=====================================================================
4. Auditoría de Retraso
=====================================================================
*/  
	SELECT * from envios LIMIT 10;
    SET @expresion_regular = '^[0-9]{2}/[0-9]{2}/[0-9]{4}$|^[0-9]{4}/[0-9]{2}/[0-9]{2}$|^[0-9]{2}-[0-9]{2}-[0-9]{4}$|^0-9]{4}-[0-9]{2}-[0-9]{2}$';
    SELECT * FROM envios WHERE f_llegada_prevista REGEXP @expresion_regular and f_entrega_real REGEXP @expresion_regular;-- ya tenemos la consulta maestra para que esta wea funcione
    ALTER TABLE envios
		ADD COLUMN dias_retraso INT DEFAULT NULL,
        ADD COLUMN posible_calculo TINYINT DEFAULT 0; -- esta tabla no es del todo necesaria, pero la añado para poder "mejorar" la eficiencia del saneamiento sql
        
	SET SQL_SAFE_UPDATES = 0;
    START TRANSACTION;
		UPDATE envios SET posible_calculo = 1 WHERE f_llegada_prevista REGEXP @expresion_regular AND f_entrega_real REGEXP @expresion_regular;
        SELECT * FROM envios LIMIT 30;-- comprobamos
			UPDATE envios 
				SET f_llegada_prevista = STR_TO_DATE(f_llegada_prevista, '%d-%m-%Y')
					WHERE f_llegada_prevista REGEXP '^[0-9]{2}-[0-9]{2}-[0-9]{4}$';
			UPDATE envios
				SET f_llegada_prevista = STR_TO_DATE(f_llegada_prevista, '%Y-%m-%d')
					WHERE f_llegada_prevista REGEXP '^[0-9]{4}-[0-9]{2}-[0-9]{2}$';
			UPDATE envios
				SET f_llegada_prevista = STR_TO_DATE(f_llegada_prevista, '%d/%m/%Y')
					WHERE f_llegada_prevista REGEXP '^[0-9]{2}/[0-9]{2}/[0-9]{4}$';
			UPDATE envios
				SET f_llegada_prevista = STR_TO_DATE(f_llegada_prevista, '%Y/%m/%d')
					WHERE f_llegada_prevista REGEXP '^[0-9]{4}/[0-9]{2}/[0-9]{2}$';
			
            UPDATE envios 
				SET f_entrega_real = STR_TO_DATE(f_entrega_real, '%d-%m-%Y')
					WHERE f_entrega_real REGEXP '^[0-9]{2}-[0-9]{2}-[0-9]{4}$';
			UPDATE envios
				SET f_entrega_real = STR_TO_DATE(f_entrega_real, '%Y-%m-%d')
					WHERE f_entrega_real REGEXP '^[0-9]{4}-[0-9]{2}-[0-9]{2}$';
			UPDATE envios
				SET f_entrega_real = STR_TO_DATE(f_entrega_real, '%d/%m/%Y')
					WHERE f_entrega_real REGEXP '^[0-9]{2}/[0-9]{2}/[0-9]{4}$';
			UPDATE envios
				SET f_entrega_real = STR_TO_DATE(f_entrega_real, '%Y/%m/%d')
					WHERE f_entrega_real REGEXP '^[0-9]{4}/[0-9]{2}/[0-9]{2}$';
                    
        UPDATE envios SET dias_retraso = DATEDIFF(f_entrega_real, f_llegada_prevista) WHERE posible_calculo = 1;
        SELECT * FROM envios where posible_calculo = 1;
        SELECT * FROM envios where dias_retraso > 0; -- creo que ya està niquelado, no hay dias negativos, pero se puede dar el xaso, si fuera a darse, entonces yo harìa un update dias null en donde sean negativos
	COMMIT;
    
/*
=====================================================================
5. Normalización de gestion
=====================================================================
*/
	SELECT * FROM almacenes;

    DROP TABLE tipos_gestion;
    CREATE TABLE tipos_gestion
		(id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
		gestion VARCHAR(20) NOT NULL
		);
    INSERT INTO tipos_gestion(gestion)
    SELECT UPPER(tipo_gestion) FROM almacenes WHERE tipo_gestion IS NOT NULL GROUP BY tipo_gestion;
    select * from tipos_gestion;
    ALTER TABLE almacenes
		ADD COLUMN tipo_gestion_id INT DEFAULT NULL;
        
	UPDATE almacenes join tipos_gestion on almacenes.tipo_gestion=tipos_gestion.gestion SET tipo_gestion_id = tipos_gestion.id;
    SELECT * FROM almacenes;
    ALTER TABLE almacenes
	ADD CONSTRAINT fk_almacenes__tipos_gestion FOREIGN KEY(tipo_gestion_id)
			REFERENCES tipos_gestion(id);
        
    
