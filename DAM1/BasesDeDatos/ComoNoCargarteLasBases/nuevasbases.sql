-- Apuntes y trabajo sobre la base de datos de logìstica global alv
use logistica_global;
-- vamos a sanear toda esta pinche tabla alv
-- primero vamos a por la tabal de almacendes:
	SELECT * FROM almacenes;
    SELECT cod_almacen, COUNT(*) FROM almacenes GROUP BY cod_almacen having count(*)>1;
    SELECT * FROM almacenes where cod_almacen IN(SELECT cod_almacen FROM almacenes GROUP BY cod_almacen HAVING COUNT(*)>1);
		-- codigos de prueba 
        SELECT * from almacenes a1 join almacenes a2 on a1.cod_almacen = a2.cod_almacen and a1.id=a2.id;
    -- vamos a por codigos de almacén:
    SET SQL_SAFE_UPDATES = 0;
    START TRANSACTION;
    UPDATE almacenes SET cod_almacen =TRIM(REPLACE(cod_almacen, '_',''));
		-- SE nos presenta un problema con los cidogos de almacen, tnemos codigos repeditos y que no tienen datos iguales
        -- se va a optar por cambiar el codigo de los repetidos con su id relacionado y vamos a hacerlo de dos formas distintas
		Select  * from almacenes a1 join almacenes a2 on a1.id=a2.id and a1.id>a2.id; -- esta es como la forma maás clásica para encontrar duplicados y eliminarlos,
        -- En este caso no nos sale nada por el hecho de que lso duplicados no están dentro del id, sino del cod_almacen, ahora
        -- vamos a hacer un aprueba con el codigo de almacen
        SELECT * FROM almacenes a1 JOIN almacenes a2 ON a1.cod_almacen=a2.cod_almacen and a1.id>a2.id;-- Con esto eliminamos, o seleccionamos el registro con el id más grande. ahora vamos a cambiarlo
        -- caí en cuenta de que tambien, antes habría que revisar si estos almacenes están referenciados por su codigo de almacen y 
        -- tienen registros en otras tablas. NO, NO LOS TIENEN
        /*UPDATE almacenes SET 
			cod_almacen = CONCAT('ALM-',id) 
				WHERE id IN (
					SELECT a1.id FROM almacenes as a1
						JOIN almacenes as a2
                        ON a1.cod_almacen=a2.cod_almacen 
                        AND a1.id>a2.id
                        );*/            -- ESTA MÄL
		UPDATE almacenes a1
			JOIN almacenes a2 
				ON a1.cod_almacen = a2.cod_almacen
				AND a1.id>a2.id
			SET a1.cod_almacen = CONCAT('ALM-',a1.id);
		-- ROLLBACK;
        COMMIT;
        -- PAra este ejercicio mi querido amigo Carlos Gerardo Pérez Toledo me recomendó hacer esto
        -- para que no se boren los registros de los almacenes, sino, simplemente señalarlos como duplicados
        /*
        UPDATE almacenes a1
			JOIN almacenes a2
				ON a1.cod_almacen = a2.cod_almacen
				AND a1.id > a2.id
			SET a1.cod_almacen = CONCAT(a1.cod_almacen, '-DUP-', a1.id);
        */
        -- AQUI QUEDA PENDIENTE EL FORMATO DE cod_almacen PORQUE hay un ALM-001, y muchos ALM-25
        
        -- OTRA FORMA DE ELIMINAR DUPLICADOS
        /*
        DELETE FROM pacientes
			WHERE id NOT IN (
				SELECT id_keep
					FROM (
						SELECT MIN(id) AS id_keep
							FROM pacientes
							GROUP BY nif
					) t
			);
		*/
        UPDATE almacenes 
			SET cod_almacen = CONCAT('ALM-', id)
            WHERE id NOT IN(
				SELECT id_keep
                FROM(
                SELECT MIN(id) AS id_keep
                FROM almacenes
                GROUP BY cod_almacen
                ) t
            );-- YA ESTAAAAA. LA OTRA FORMA ES REAL!!!!
    
        -- LOS ULTIMOS SIETE ME ESTAN FRUSTRANDO
        -- A pesar de que se esté referenciando a los almaceenes en otras tablas, no se referencia a ningun almacene n concreto, por lo que
        -- voya optar por eliminar estos, al menos los que no tienen sentido, no sin antes mandarlos a cuarentena
        SELECT * FROM almacenes ORDER BY id DESC LIMIT 7;
        
        CREATE TABLE almacenes_pendientes_revision(
        id INT PRIMARY KEY,
        cod_almacen VARCHAR(20),
        nombre_sucursal VARCHAR(50),
        ciudad_ubicacion VARCHAR(30),
        capacidad_m3 VARCHAR(20),
        tel_contacto VARCHAR(15),
        tipo_gestion VARCHAR (20),
        ubicacion_geografica VARCHAR(50)
        );
        
        INSERT INTO almacenes_pendientes_revision select * from almacenes where id between 201 and 207;
        
        SELECT * from almacenes_pendientes_revision;
        
        DELETE FROM almacenes where id between 201 and 207;
        
        -- ya está, tambien se mandaron a los duplicados de alamcen a y almacen b porque no tiene los demás datos para poder sanear esto
        -- ciudad_ubicacion
        select * from almacenes where ciudad_ubicacion is null;
        -- hay varios elementos null y ciudades acortadas, vamos a poner 'DESCONOCIDO' en elmentos NULL y ponerle la ciudad completa
        -- en donde hay acortaciones
        SELECT * FROM almacenes WHERE ciudad_ubicacion = 'Barna';
        SELECT * FROM almacenes WHERE ciudad_ubicacion = 'VLC';
        SELECT * FROM almacenes WHERE ciudad_ubicacion NOT IN('Barna', 'VLC', 'Sevilla ', 'Madrid');-- TAmbien hay que TRIMEAR SEVILLA
        SET SQL_SAFE_UPDATES = 0;
        START TRANSACTION;
        -- vamos a utilizar un CASE
        UPDATE almacenes SET ciudad_ubicacion = CASE
			WHEN ciudad_ubicacion = 'Barna' THEN('Barcelona')
            WHEN ciudad_ubicacion = 'VLC' THEN('Valencia')
            WHEN ciudad_ubicacion IS NULL THEN('DESCONOCIDO')
            ELSE TRIM(ciudad_ubicacion)
		END;
        COMMIT;
        ALTER TABLE almacenes
			MODIFY ciudad_ubicacion VARCHAR(15) NOT NULL;
		-- YA está, ahora vamos a por capacidad_m3
        
        
        
        
        
	