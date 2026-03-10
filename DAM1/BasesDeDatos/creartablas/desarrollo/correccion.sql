USE gestion_universidad;

-- Activamos el modo estricto para capturar errores de ENUM y truncamiento de cadenas
SET SESSION sql_mode = 'STRICT_ALL_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

DELIMITER //

DROP PROCEDURE IF EXISTS TestCorreccionUniversidad //

CREATE PROCEDURE TestCorreccionUniversidad()
BEGIN
    -- ========================================================================
    -- FASE 0: LIMPIEZA Y PREPARACIÓN
    -- ========================================================================
    -- El orden es vital por las claves foráneas
    DELETE FROM imparten;
    DELETE FROM asignaturas;
    DELETE FROM grados;
    
    -- Para limpiar facultades y profesores con referencias circulares (id_decano),
    -- desactivamos temporalmente los checks si fuera necesario, o borramos con cuidado.
    SET FOREIGN_KEY_CHECKS = 0;
    DELETE FROM profesores;
    DELETE FROM facultades;
    SET FOREIGN_KEY_CHECKS = 1;

    -- Datos base válidos
    INSERT INTO facultades (id_facultad, codigo, nombre) VALUES (1, 'F001', 'Informática');
    INSERT INTO profesores (id_profesor, nif, nombre_completo, id_facultad) VALUES (1, '12345678Z', 'Profesor Test', 1);
    INSERT INTO asignaturas (id_asignatura, codigo_asig, nombre) VALUES (1, 'ISO-001', 'Sistemas Operativos');

    -- ========================================================================
    -- FASE 1: TESTS DE FACULTADES
    -- ========================================================================
    BEGIN
        DECLARE EXIT HANDLER FOR SQLEXCEPTION SELECT '✅ ÉXITO [Fac]: UNIQUE/CHAR(4) bloqueó código inválido o duplicado.' AS 'Resultado';
        INSERT INTO facultades (codigo, nombre) VALUES ('F001', 'Duplicada'); -- Error por UNIQUE
        SELECT '❌ ERROR [Fac]: Se permitió duplicar el código de facultad.' AS 'Resultado';
    END;

    BEGIN
        DECLARE EXIT HANDLER FOR SQLEXCEPTION SELECT '✅ ÉXITO [Fac]: NOT NULL bloqueó nombre nulo.' AS 'Resultado';
        INSERT INTO facultades (codigo, nombre) VALUES ('F002', NULL);
        SELECT '❌ ERROR [Fac]: Se permitió nombre de facultad NULL.' AS 'Resultado';
    END;

    -- ========================================================================
    -- FASE 2: TESTS DE PROFESORES
    -- ========================================================================
    BEGIN
        DECLARE EXIT HANDLER FOR SQLEXCEPTION SELECT '✅ ÉXITO [Prof]: UNIQUE bloqueó NIF duplicado.' AS 'Resultado';
        INSERT INTO profesores (nif, nombre_completo, id_facultad) VALUES ('12345678Z', 'Otro', 1);
        SELECT '❌ ERROR [Prof]: Se permitió NIF duplicado.' AS 'Resultado';
    END;

    BEGIN
        DECLARE EXIT HANDLER FOR SQLEXCEPTION SELECT '✅ ÉXITO [Prof]: CHECK bloqueó salario <= 0.' AS 'Resultado';
        INSERT INTO profesores (nif, nombre_completo, salario, id_facultad) VALUES ('88888888X', 'Pobre', -10.00, 1);
        SELECT '❌ ERROR [Prof]: Se permitió un salario negativo o cero.' AS 'Resultado';
    END;

    BEGIN
        -- Test de valor por defecto
        INSERT INTO profesores (id_profesor, nif, nombre_completo, id_facultad) VALUES (99, '99999999Q', 'Default Man', 1);
        IF (SELECT salario FROM profesores WHERE id_profesor = 99) = 2000.00 THEN
            SELECT '✅ ÉXITO [Prof]: DEFAULT salario funciona (2000.00).' AS 'Resultado';
        ELSE
            SELECT '❌ ERROR [Prof]: El salario por defecto no es 2000.00.' AS 'Resultado';
        END IF;
    END;

    -- ========================================================================
    -- FASE 3: TESTS DE ASIGNATURAS E IMPARTEN
    -- ========================================================================
    BEGIN
        DECLARE EXIT HANDLER FOR SQLEXCEPTION SELECT '✅ ÉXITO [Asig]: CHECK bloqueó créditos < 3.' AS 'Resultado';
        INSERT INTO asignaturas (codigo_asig, nombre, creditos) VALUES ('ERR', 'Error', 2);
        SELECT '❌ ERROR [Asig]: Se permitieron menos de 3 créditos.' AS 'Resultado';
    END;

    BEGIN
        -- Test ENUM en imparten
        DECLARE EXIT HANDLER FOR SQLEXCEPTION SELECT '✅ ÉXITO [Imp]: ENUM bloqueó tipo_grupo inválido.' AS 'Resultado';
        INSERT INTO imparten (id_profesor, id_asignatura, tipo_grupo) VALUES (1, 1, 'LABORATORIO');
        SELECT '❌ ERROR [Imp]: Se permitió un valor no incluido en el ENUM (TEORIA/PRACTICA).' AS 'Resultado';
    END;

    -- ========================================================================
    -- FASE 4: TEST DE BORRADO EN CASCADA
    -- ========================================================================
    BEGIN
        INSERT INTO imparten (id_profesor, id_asignatura, tipo_grupo) VALUES (1, 1, 'TEORIA');
        DELETE FROM profesores WHERE id_profesor = 1;
        
        IF (SELECT COUNT(*) FROM imparten WHERE id_profesor = 1) = 0 THEN
            SELECT '✅ ÉXITO [Imp]: ON DELETE CASCADE funcionó correctamente.' AS 'Resultado';
        ELSE
            SELECT '❌ ERROR [Imp]: El registro sigue existiendo tras borrar al profesor (Falla CASCADE).' AS 'Resultado';
        END IF;
    END;

    -- ========================================================================
    -- FASE 5: TEST DE VISTAS
    -- ========================================================================
    BEGIN
        -- Verificamos si las vistas existen consultando information_schema
        IF EXISTS (SELECT 1 FROM information_schema.VIEWS WHERE TABLE_NAME = 'v_cuadro_docente') AND 
           EXISTS (SELECT 1 FROM information_schema.VIEWS WHERE TABLE_NAME = 'v_resumen_facultades') THEN
            SELECT '✅ ÉXITO [Vistas]: Las vistas existen en el esquema.' AS 'Resultado';
        ELSE
            SELECT '❌ ERROR [Vistas]: No se encuentran las vistas requeridas.' AS 'Resultado';
        END IF;
    END;

END //

DELIMITER ;

-- Ejecución del test
CALL TestCorreccionUniversidad();