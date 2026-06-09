
/*
ATENCION WE
COSAS QUE PODRÌAN CAER EN ESTA TONTERIA
	- COSAS CON FECHAS Y OPERACIONES
    - ELIMINAR DUPLICADOS
    - HACER NUEVAS TABLAS
    - FOREIGN KEYS
*/
-- Apuntes y trabajo sobre la base de datos de logìstica global alv
use logistica_global;
-- vamos a sanear toda esta pinche tabla alv
/*
*************************************************************************
=========================================================================
primero vamos a por la tabal de almacendes:------------------------------
=========================================================================
*************************************************************************
*/
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
        SET SQL_SAFE_UPDATES = 1;
        ALTER TABLE almacenes
			MODIFY ciudad_ubicacion VARCHAR(15) NOT NULL;
            
		-- YA está, ahora vamos a por capacidad_m3
        select * from almacenes;
        SET SQL_SAFE_UPDATES = 0 ;
        START TRANSACTION;
			UPDATE almacenes SET capacidad_m3 = TRIM(REPLACE(REPLACE(capacidad_m3, 'metros cúbicos', ''),'m3', '')); -- lito poio
		COMMIT;
        SET SQL_SAFE_UPDATES = 1;
        
        -- ahora vamos con los prefijos de los telefonos
        select * from almacenes; -- creo que hya un problema la longitud de ciertos telèfonos, tipo, si quisiera noramalizar esto y añadir un check me va a dar problemas
        SET SQL_SAFE_UPDATES = 0;
        START TRANSACTION;
			UPDATE almacenes SET tel_contacto = TRIM(REPLACE(tel_contacto, '+34',''));-- rollback
            SELECT *, length(tel_contacto) as si from almacenes having si<9;
            -- si consideramos solucionar esto pues unad e las opciones esponere esto a null, pero acabo de recordar que con 
            -- las ciudades lo que hice fue poner 'DESCONOCIDO' a los valores null, y lo màs recomendable es poner null esos numeros de 
            -- telèfono y no 'DESCONOCIDO, así que por mientras estoy con el culo a dos manos, nah bromi
            UPDATE almacenes SET tel_contacto = 'DESCONOCIDO' WHERE length(tel_contacto)<9; -- no es muy optimo poner la funcion luego del where y antes del operador de comparacion, pero meh
		ROLLBACK; -- hice un rolllbak porque no se si mantener lo de los refijos o no al final| pero tambien de paso soluciono esto de una forma
			-- FROMA 2
        START TRANSACTION;
			SELECT *, length(tel_contacto) as si from almacenes;
			UPDATE almacenes SET tel_contacto = NULL WHERE NOT length(tel_contacto)=13; -- ya està
		COMMIT;
        SET SQL_SAFE_UPDATES = 1;
        
        -- Tpos de gestion
        select * from almacenes;
        select tipo_gestion, count(*) from almacenes group by tipo_gestion;
			-- Solo hay dos tipos de gestión, por hacerlo bonito, las gestiones estárán en mayusculas(luego le pondré una cosa para que solo puedas elegir unas opciones)
		SET SQL_SAFE_UPDATES = 0;
        START TRANSACTION;
			UPDATE almacenes SET tipo_gestion = TRIM(UPPER(tipo_gestion));
            select tipo_gestion, count(*) from almacenes group by tipo_gestion;
		COMMIT; -- ya está
        SET SQL_SAFE_UPDATES = 1;
        -- UBICACIÓN GEOGRÁFICA: la guinda del pastel de esta tabla
			-- El problema principal es que aquí nos encontramos con atributos multivaluados, debido a que el campo tiene dos
			-- datos en todos, o casi todos los registros: Lat y LON
        select * from almacenes where ubicacion_geografica LIKE 'Lat:%Lon%';-- al final si son todos xd, vamos a hacer un index substring
        select SUBSTRING(SUBSTRING_INDEX(ubicacion_geografica, '|', 1), 5), SUBSTRING(SUBSTRING_INDEX(ubicacion_geografica, '|', -1),7) from almacenes; -- Tengo que preguntarle a victor por qué pantuflas este valor es 7 del substring y no 5
        /*ALTER TABLE almacenes
			DROP COLUMN longiud;*/ -- Me equivoque con esta wea xd, pero te dejo el apute por si te equivocas de nuevo
            ALTER TABLE almacenes
				DROP COLUMN latitud,
                DROP COLUMN longitud;
       
       ALTER TABLE almacenes 
			ADD latitud DECIMAL(9,4),
            ADD longitud DECIMAL(8,4); -- EN realidad la latitud y la longitud no son así, tienen más decimales, pero para el ejemplo lo dejaremos así
        SET SQL_SAFE_UPDATES = 0;
        
			/*INSERT INTO almacenes(latitud, longitud)
				select CAST(SUBSTRING(SUBSTRING_INDEX(ubicacion_geografica, '|', 1), 5) as DECIMAL(7,4)), CAST(SUBSTRING(SUBSTRING_INDEX(ubicacion_geografica, '|', -1),7) as DECIMAL(6,4)) from almacenes;*/
                -- esta insersión está mal, porque con un inster into le estamos pidiendo al mysql que cree nuevas filas, mas no que inserte lo que le pides en la filas ya existentes
                
        START TRANSACTION; 
			UPDATE almacenes 
				SET latitud = CAST(SUBSTRING(SUBSTRING_INDEX(ubicacion_geografica, '|', 1), 5) as DECIMAL(7,4)), 
                longitud = CAST(SUBSTRING(SUBSTRING_INDEX(ubicacion_geografica, '|', -1),7) as DECIMAL(6,4));
		SAVEPOINT si;
		COMMIT;
        SET SQL_SAFE_UPDATES = 1;
        ALTER TABLE almacenes
			DROP COLUMN ubicacion_geografica;
		SELECT * FROM almacenes;
			-- FALTA PONER UN CONSTRAINT PARA ESTO DE LA LATITUD Y LA LONGITUD
            ALTER TABLE almacenes
				ADD CONSTRAINT chk_latitud CHECK (latitud between -90 and 90),
                ADD CONSTRAINT chk_longitud CHECK(longitud BETWEEN -180 and 180);
		-- PENDIENTE: CREAR UNA TABLA CON CIUDADES Y AÑADIR ENTIDAD REFERENCIAL CON ESAS CIUDADES Y ESTA TABLA DE almacenes
        
        /*
*************************************************************************
=========================================================================
ahora vamos a la tabbla clientessadsdwasdd:------------------------------
=========================================================================
*************************************************************************
*/

	-- ################___SUPER IMPORTANTE: SANEAMIENTO DE FECHAS___#####################
		SELECT fecha_alta_cliente, count(*) from clientes group by fecha_alta_cliente;
        SELECT * from clientes where fecha_alta_cliente LIKE '%-%-%';
        SELECT * from clientes where fecha_alta_cliente LIKE '%/%/%';
        SELECT * FROM clientes where fecha_alta_cliente regexp '^[0-9]{2}-[0-9]{2}-[0-9]{2}$|^[0-9]{2}/[0-9]{2}/[0-9]{2}$';
        -- aqui tenemos ciertos pedillos, como por ejemplo el año de la fecha, hay años que no son 2020, sino 20, y
        -- de esa manera no se puede descubir cual es la fecha real
        -- otro es el orden, hay años en la izquierda y luego en la derecha
        -- tambien no sabemos si el mes es el de en medio o ño, luego veremos
        /*VICTOR NOS DIJO QUE NO ES MUY POSIBLE SABER CUALES SERÍAN LAS FECHAS POR LA FALTA DE INFORMACION, TRATEREMOS DE SANEAR
        LO DEMÄS; PERO QUE AQUÏ QUEDEN COSAS DE COMO SANEAR Y CALCULAR FECHAS :))*/
        SET SQL_SAFE_UPDATES = 0;
        START TRANSACTION;
			UPDATE clientes 
				SET fecha_alta_cliente = STR_TO_DATE(fecha_alta_cliente, '%d-%m-%Y')
					WHERE fecha_alta_cliente REGEXP '^[0-9]{2}-[0-9]{2}-[0-9]{4}$';
			UPDATE clientes
				SET fecha_alta_cliente = STR_TO_DATE(fecha_alta_cliente, '%Y-%m-%d')
					WHERE fecha_alta_cliente REGEXP '^[0-9]{4}-[0-9]{2}-[0-9]{2}$';
			UPDATE clientes
				SET fecha_alta_cliente = STR_TO_DATE(fecha_alta_cliente, '%d/%m/%Y')
					WHERE fecha_alta_cliente REGEXP '^[0-9]{2}/[0-9]{2}/[0-9]{4}$';
			UPDATE clientes
				SET fecha_alta_cliente = STR_TO_DATE(fecha_alta_cliente, '%Y/%m/%d')
					WHERE fecha_alta_cliente REGEXP '^[0-9]{4}/[0-9]{2}/[0-9]{2}$';
                
		ROLLBACK;
	SHOW TABLES;
    SELECT  * FROM clientes;
    SELECT length(cif_nif) from clientes;
        -- averigualr si hay repetidos
        select  count(*) from clientes group by cif_nif having count(*)>1; -- no hya repetidos
		select  count(*) from clientes group by razon_social having count(*)>1;-- tamapoco hay repetidos
        
        -- Credito sucio
        select * from clientes where limite_credito_sucio like '%USD'; -- todos los valores con USD tienen un espacio entre medias, o sea ' USD'
        select  * from clientes where limite_credito_sucio like '%€%'; -- todos los valores € no van con espacio
        select 233+267;-- la suma de los creditos sucios es 500, los clientes totales son 503, pero los ultimos tres son los que no cumple, tambien veo que no cumplen con muchas cosas
			-- vamos a hacer una consulta para solo agarrarnos el monto de dinero de los USD
            SELECT SUBSTRING(limite_credito_sucio,-4, 4) from clientes where limite_credito_sucio like '%USD';-- no me sale xd
            SELECT SUBSTRING_INDEX(limite_credito_sucio, ' USD', 1) from clientes where limite_credito_sucio like'%USD';-- esta es la consulta ganadora man
		-- ahora vamos a sanear esto, primero vamos a substringear eso y luego lo vamos a parsear a numero
        explain clientes;
        SET SQL_SAFE_UPDATES = 0;
        /*START TRANSACTION;
			UPDATE clientes SET limite_credito_sucio = CAST(SUBSTRING_INDEX(limite_credito_sucio,' USD', 1) AS DECIMAL(10,2))*0.86 where limite_credito_sucio like '%USD;
		ROLLBACK;*/
        -- MAN,creo que voya hacer una tabla aparte para meter aho tiodo y cambiar el nombre de la tabla
        ALTER TABLE clientes
			ADD COLUMN limite_credito_sucio_euros DECIMAL(10,2) NOT NULL DEFAULT 0;
		START TRANSACTION;
			UPDATE 
				clientes 
            SET
				limite_credito_sucio_euros =
            CASE 
				WHEN limite_credito_sucio LIKE '%USD' THEN
					CAST(SUBSTRING_INDEX(limite_credito_sucio,' USD', 1) AS DECIMAL(12,2))*0.86
				WHEN limite_credito_sucio LIKE '%€' THEN
					CAST(SUBSTRING_INDEX(limite_credito_sucio,'€',1) AS DECIMAL(12.2))
				else
					0
			END;
		commit;
		-- ROLLBACK;
        -- ahora que me doy cuenta, no es necesario que  un limite de credito sucio tenga decimales si al final es algo un poco más conceptual ;-;
        -- ya está, ahora vamos a elimitar esa verga de columna y lito poio, tambien vamos a leiminar los ultimos tres registros poniendo en otra tabla y blah blah blah
        ALTER TABLE clientes
			DROP COLUMN limite_credito_sucio;
		SELECT * from clientes;

 /*
*************************************************************************
=========================================================================
ahora vamos a la condenada tabla envios!!!:------------------------------
=========================================================================
*************************************************************************
*/
	-- Man, ahora solo le voy a meter la integridad refencial, me da paja sanear lo demás
	Select * from envios limit 10;
    select * from envios where cliente_id>503;-- vamos, no hay clientes que se pasen de lanza
    select * from envios where cliente_id<1; -- hay dos soluciones posibles creo
    -- la primera es crear un cliente auxiliar para estos ids negativos, la segunda es adjudicar esos ids a donde nos digan
    -- vamos a hacer la primera porque es casi lo mismo que la segunda con algunas cosillas de más
    select * from clientes;
    select length(cif_nif) from clientes;
    INSERT INTO clientes(cif_nif, razon_social, fecha_alta_cliente,limite_credito_sucio_euros)
    VALUES('Z99999999', 'EMPRESA AUXILIAR', NOW(), 9999999.99);
    select MAX(id) from clientes;
    -- ahora que ya creamos el cliente especial, vamos a hacer esto
    SET SQL_SAFE_UPDATES = 0;
    START TRANSACTION;
		UPDATE envios SET cliente_id=
			(SELECT MAX(id) from clientes) WHERE cliente_id<1;
		SELECT * FROM envios where cliente_id=(SELECT MAX(id) FROM clientes);
	COMMIT;-- lito poio, ahora solo le metemos la integridad refencial y estamos reeedysss
    ALTER TABLE envios
		ADD CONSTRAINT fk_envios_clientes FOREIGN KEY(cliente_id)
			REFERENCES clientes(id);
    









        /*
*************************************************************************
=========================================================================
ahora vamos a la pinchi tabla empleadossss:------------------------------
=========================================================================
*************************************************************************
*/
	-- vamos a ver los problemas
    select * from empleados;
    select si, length(si) from (SELECT REPLACE(nif_nie,' ','') as si from empleados) t;
    select length(si),count(*) from (SELECT REPLACE(nif_nie,' ','') as si from empleados) t group by length(si);
	-- podemos ver varios errores con los nies
			select * from envios;
			select * from envios where empleado_id is not null;-- podemos borrar empleados porque estos manes no están acá
	-- chance, antes de sanear esto me voy a ir a lo de los envios para meterle integridad referencial
        
		
            
		
        
                
        
        
	