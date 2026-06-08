-- Saneamiento parte 1
use gha_analytics;
-- BLINDAJE ESTRUCTURAL
	-- 1 Normalización de identidad
		-- Eliminar duplicados manteniendo el ID más bajo
			-- Considero que antes de eliminar los duplicados, haré consistentes un par de cosas(creo)
            SELECT * from pacientes;
            SELECT * from pacientes p1 inner join pacientes p2 on p1.nif = p2.nif;
            SELECT * from pacientes p1 inner join pacientes p2 on p1.nif = p2.nif and p1.nombre_completo=p2.nombre_completo where p1.id>p2.id;-- Esta el la solución de vitor para borrar esa huevada
			-- pero ni idea, no entiendo muy bien como funciona, en lugar de poner un select se pone un delete para eliminar los duplicados
            START TRANSACTION;
				SELECT * FROM pacientes;
                SET SQL_SAFE_UPDATES=0;
                UPDATE pacientes SET nombre_completo = TRIM(REPLACE(nombre_completo, '  ', ' '));-- normalizamos los nombres un poquillo
                Commit;
            SET SQL_SAFE_UPDATES=1;    
			DELETE FROM pacientes where id in(SELECT mas from(SELECT MAX(id) as mas from pacientes group by nif having count(*)>1) t);-- ya no se D:
            DELETE p1 FROM pacientes p1 JOIN pacientes p2 on p1.nif=p2.nif and p1.nombre_completo=p2.nombre_completo where p1.id>p2.id;-- usemos este mejor, ya le entendí xd
            -- al eliminar los ids se genera un problema, y es que hay ids relacionados con los repetidos en otras tablas, o sea que luego habrá que gestionar esa mamada
            -- por ahora la tabla visitas tiene un ind de paciente 4, y ese ya lo borramos man
        -- formalizar el nif con regex
			-- primero le quitaremos los guiones y espacios innecesarios
            select nif from pacientes;
            SET SQL_SAFE_UPDATES = 0;
            START TRANSACTION;
				UPDATE pacientes SET nif = TRIM(REPLACE(nif,'-',''));
                SELECT nif FROM pacientes;
			COMMIT;
            -- aquí se genera un problema cone l id 9, porque este man tiene un NULL_NIF, y para
            -- poder ponerle el regex que queremos, primero necesitamos encargarnos de esta, por lo que, 
            -- en esta ocasión lo pndré en otra tabla y lo eliminaré, esto es posible en esta porque
            -- no tiene relaciones con otras tablas(AFORTUNADAMENTE)
            CREATE TABLE pacientes_invalidos as SELECT * from pacientes where nif NOT REGEXP '^[1-9]{8}[A-Z]$';
            SELECT * from pacientes_invalidos;
            DELETE FROM pacientes where nif NOT REGEXP '^[0-9]{8}[A-Z]$';
            SELECT * from pacientes;
            -- Ahora si creamos la constraint de check
            ALTER TABLE pacientes
				ADD CONSTRAINT chk_nif_correct CHECK (nif REGEXP '^[0-9]{8}[A-Z]$');

			
		
        -- convertir la columna nif en unique y not null
			-- aqui le haremos not null y le variaremos el varchar
            ALTER TABLE pacientes
				MODIFY COLUMN nif VARCHAR(9) NOT NULL;
			ALTER TABLE pacientes
				ADD CONSTRAINT uq_nif UNIQUE(nif);
                
		-- hay otros datos que mejorar, pero por ahora trataré de ceñireme la práctica
	
    -- 2. Consistencia de colegiados
		-- hacer que los numeros de colegiados tengan el formato COL-XX-YYYY (donde XX es la provincia y YYYY el número)
        SELECT * FROM medicos;
        SET SQL_SAFE_UPDATES = 0;
        START TRANSACTION;
			SELECT SUBSTRING(num_colegiado,1,2), SUBSTRING(num_colegiado,4) FROM medicos; -- prueba para ver si funciona la wea
			UPDATE medicos SET num_colegiado = CONCAT('COL-',SUBSTRING(num_colegiado,1,2),'-', SUBSTRING(num_colegiado,4)) 
				WHERE num_colegiado LIKE '28%';-- version no funcional aun WHERE num_colegiado NOT REGEXP '^COL-[0-9]{2}[0-9]{4}$'AND LENGTH(num_colegiado)=7
			SELECT CONCAT('COL-',SUBSTRING(num_colegiado,4,2),'-',SUBSTRING(num_colegiado,6)) from medicos;-- consulta previa para ver que la wea funciona
			UPDATE medicos SET num_colegiado = CONCAT('COL-',SUBSTRING(num_colegiado,4,2),'-',SUBSTRING(num_colegiado,6)) 
				WHERE id = 3;-- A este especialmente hay un problema de desicion, tenia el numero COL289900, 
					-- es 28 el codigo de provincia?, o es 00?, en este caso, y para sugerir un cambio en 
					-- el colegiado inventado del id 5, se opta porque el codigo de provincia es 28
			UPDATE medicos SET num_colegiado = CONCAT('COL-00-0',SUBSTRING(num_colegiado,5))
				WHERE id = 5;
            -- 00 = Provincia temporal
            SELECT * FROM medicos;
		-- ROLLBACK;
        COMMIT;
        SET SQL_SAFE_UPDATES =1;
        -- aplicar una restricción check para validar este formato
        ALTER TABLE medicos 
			ADD CONSTRAINT chk_colegiado 
				CHECK(num_colegiado REGEXP '^COL-[0-9]{2}-[0-9]{4}');
		-- Mi querido amigo chat dice que tambien sería recomendable hacer que los colegiados
		-- sean unicos pero ahora me la pela la verda
        
	-- 3. Integridad Referencial
		-- Los médicos con especialidades inexistentes deben asignarse a la especialidad ’Medicina General’.
			-- primero vamos a hacer una prueba de consulta para que salga la wea(me lo hizo chat)
		SET SQL_SAFE_UPDATES = 0;
        START TRANSACTION;
        SELECT * from medicos where especialidad_id NOT IN (SELECT id from especialidades);
        UPDATE medicos SET especialidad_id = 1 WHERE especialidad_id NOT IN (SELECT id FROM especialidades);
        SELECT * from medicos where especialidad_id NOT IN (SELECT id from especialidades);
        COMMIT;
        SET SQL_SAFE_UPDATES=1;
        -- Añade las FOREIGN KEY correspondientes en medicos y visitas.
			-- medicos tiene que tener una foreign key con especialidades y visitas con medicos, so
            ALTER TABLE medicos
				ADD CONSTRAINT fk_medicos_especialidades 
					FOREIGN KEY(especialidad_id) REFERENCES especialidades(id) 
                    ON DELETE RESTRICT ON UPDATE CASCADE;-- para eliminar una constraint que hiciste mal es ALTER TABLE nombre_de_tabla DROP CONSTRAINT nombre_de_restriccion;
			ALTER TABLE visitas
				ADD CONSTRAINT fk_visitas_medicos
					FOREIGN KEY(medico_id) REFERENCES medicos(id)
                    ON DELETE RESTRICT ON UPDATE CASCADE;-- la wea no funciona porque hay ids de medicos que no sirven ptm
			-- qué podemos hcaer? pues podemos crear un medico y un paciente con ese id ooo...
            -- no sé ;-;
            -- xd
            -- voy a hacer al medico y al paciente
            -- por cuestion de apuntes tienes que primero demostrar las claves que no existen, que están huerfanas dentro de la tabla de visitas
            SELECT * FROM visitas;
            SELECT * FROM visitas WHERE paciente_id NOT IN (SELECT id FROM pacientes); -- HAber hecho esto fue mejor de lo que me imaginaba, había olvidado por completo el registro repedito de borramos...
            -- AY NO, NO ME ACUERDO DE COMO IBA LA CONSULTA ANTES DE CAMBIAR TODO PTM
            -- ya, el id de paciente 4 pertenece al 1, jose luis ibañez del monte destructor de pussys
            -- bueno, hacemos tambien ese cambi, ahora vamos a ver los medicos inexistentes
            SELECT * FROM visitas WHERE medico_id NOT IN(SELECT id FROM medicos);
            -- hora si hacemos los cambios cabron
            SET SQL_SAFE_UPDATES = 0;
            SELECT * FROM pacientes;
            START TRANSACTION;
            UPDATE visitas SET paciente_id=1 WHERE paciente_id = 4;
            -- cabron solo salen pinches problemas de esto, ahora on se que hacer con el auto_increment de los id's, tipo, si cogo el id 
		
            select max(id) into @last_id_paciente from pacientes;
            SELECT @last_id_paciente;
            UPDATE pacientes
            