use FugaTech_Forensic;



-- gestion desafe updates
UPDATE clientes 
SET 
    email = REPLACE(email, ',', '.')
WHERE
    email LIKE '%@%,%'; -- pinga, no funciona porque pimero tienes que desactivar el seguro de niños

SET SQL_SAFE_UPDATES = 0;
UPDATE clientes 
SET 
    email = REPLACE(email, ',', '.')
WHERE
    email LIKE '%@%,%';
SET SQL_SAFE_UPDATES=1;

-- Voy a poner apuntes del truncate pero no lo voy ejercutar porque no me quiero cargar la base de datos jeje 

SET FOREIGN_KEY_CHECKS = 0;

TRUNCATE TABLE ventas;
TRUNCATE TABLE clientes;

SET FOREIGN_KEY_CHECKS = 1;
-- co0n esta cosa eliminamos todos lo datos de la tabla, pero sigue la estructura para poder ser utilizada 

-- Migración SELECT MASIVAAAAAAA

-- 		1. Creamos la tabla de destino (Estructura optimizada para marketing)
-- 		Nota: No tiene por qué ser idéntica a la tabla origen.
CREATE TABLE IF NOT EXISTS clientes_vip (
	cliente_id INT ,-- le iba  aponer el AUTO_INCREMENT, pero ahora veo que no tiene sentido meter esto porque 
    -- vamos a sacar datos de la otra tabla, por lo que el id de los clientes que vienen no siempre pueden ser 
    -- incrementales, sino que uno puede ser 1, y el otro un 8
    nombre_completo VARCHAR(150),
    email_completo VARCHAR(100),
    potencial_compra DECIMAL(10,2),
    fecha_inclusion DATETIME DEFAULT NOW(),
    CONSTRAINT pk_cliente_id PRIMARY KEY(cliente_id)
    );
TRUNCATE TABLE clientes_vip;

-- ANTES DE HACER LA INSERCION MASIVA QUIER TRATAR DE SANEAR ESTA PARTE
select * from clientes;
SET SQL_SAFE_UPDATES = 0;

-- nombre de JUAN GOMEZ
UPDATE clientes SET nombre = TRIM(nombre);
UPDATE clientes SET nombre =  REPLACE(nombre,'  ', ' ')
WHERE nombre LIKE('%  %');-- NO TE OLVIDES DE ESTE WHERE CUANDO HAGAS UN UPDATE XD
SET SQL_SAFE_UPDATES = 1;
-- numeros de telefono
select * from clientes;
UPDATE clientes SET telefono = TRIM(REPLACE(REPLACE(REPLACE(telefono,'+', ''),' ',''), '-',''));
-- Cuidado con este tipo de consulta, por tu chistecito ya me cargue la base de datos xd
-- NO TE OLVIDES DEL ELSE, SINO LOS CAMPOS QUE NO CUMPLEN LAS CONDICIONES SE JODEN ALV
UPDATE clientes SET telefono = 
	CASE
		WHEN telefono LIKE '0034%' THEN SUBSTRING(telefono, 5)
        WHEN telefono LIKE '34%' THEN SUBSTRING(telefono,3)
        ELSE telefono
END;




INSERT INTO clientes_vip(
cliente_id,
nombre_completo,
email_completo,
potencial_compra
) SELECT 
id,
TRIM(nombre),
LOWER(email), -- los apuntes de Vitor dicen esto, pero ya hiciumos el cambio en la base de datos
-- supongo que lo poen porque luegop del truncate, volvemos a cargar la base de datos tal y como
-- estasba la pendeja xd
credito*1.20 -- Le calculamos el potencial con un 20% más
FROM clientes
WHERE activo = 1
	AND credito >50;
    

SELECT * fROM clientes_vip;


-- VAMOOOOOOOOS

-- cuestiones y coas de upsert
-- 		el upsert está ahi porque si hay algun dato que quieras insertar y choca con
-- 		algun dato primario, entonces lo que haces es que no te cambie todo sino los datos que tu quieras

-- 		Tecnica de UPSERT aplicada a la tabla de clientes.
-- 		Si el cliente con ID 1 no existe, se crea con los datos proporcionados.
-- 		Si el ID 1 ya existe, se actualiza su credito (anadiendo 100) y se marca como activo.
INSERT INTO clientes(id, nombre, email, telefono, credito, activo)
VALUES(
	1,
    'Juan Gomez',
    'juan.gomez@empresa.local',
    '+34 600-111-222',
    100.00,
    1
    )
ON DUPLICATE KEY UPDATE
	credito = credito +100.00,
    activo = 1;
    
select * from clientes;


-- Saneamientos: aqui te paso el saneado de los numeros de telefono de ejemplo que puso 
-- Vitor en los apuntes, pero no lo voy a ejecutart ahora poque ya los tengo xd
-- Supongamos telefonos importados como "+34 600 123 456" o "0034 600-123-456"
UPDATE clientes
SET telefono = REPLACE(REPLACE(REPLACE(telefono, '+34', ''), '0034', ''), '-', '')
WHERE telefono LIKE '+34%' OR telefono LIKE '0034%' OR telefono LIKE '%-%';
-- Segundo pase: limpiar posibles espacios generados
UPDATE clientes SET telefono = TRIM(telefono);


-- Usar JOins para sanear
-- 		Bloquear a los clientes cuyas cuentas bancarias asociadas esten marcadas como fraudulentas

SET SQL_SAFE_UPDATES = 0;
UPDATE clientes
SET activo=0
WHERE id IN (
	SELECT id_cliente FROM cuentas_bancarias WHERE fraude=1
	);
    
SET SQL_SAFE_UPDATES = 1;
select * from clientes;



SET SQL_SAFE_UPDATES=0;

UPDATE catalogo c
INNER JOIN importacion_tarifas t ON c.referencia= t.referencia
SET c.precio = t.nuevo_precio, c.fecha_actualizacion = NOW();

SET SQL_SAFE_UPDATES=1;

-- Vitor aqui añade los CASE con un ejemplo un poco curioso para igualar los prefijos de los telefonos
SET SQL_SAFE_UPDATES = 0;
select * from clientes;
UPDATE clientes
SET telefono = CASE
	WHEN email LIKE '%local' THEN (CONCAT('+34 ',telefono))
    WHEN nombre LIKE 'Admin%' THEN '+00 000000000'
    else telefono
END
WHERE activo = 1;

SET SQL_SAFE_UPDATES = 1;

-- cosillas con lso nulls yc uestiones para tratar con ellos a la hora de sanaer bases
-- -- =============================================================================
-- GESTIÓN DE NULLS: IFNULL vs COALESCE
-- =============================================================================
-- 0. Preparación de datos de prueba (Escenarios de nulos)
INSERT INTO clientes (nombre, email, telefono, credito) VALUES
('Sujeto A', NULL, '600-000-001', 10.00), -- Solo teléfono
('Sujeto B', 'b@test.com', NULL, 20.00), -- Solo email
('Sujeto C', NULL, NULL, 0.00), -- Sin datos de contacto
('Sujeto D', 'd@test.com', '600-000-004', 5.00); -- Datos completos

-- 1. IFNULL: El "plan B" binario (solo 2 argumentos)
-- Si el teléfono es NULL, pone 'DESCONOCIDO'.
select * from clientes;

SET SQL_SAFE_UPDATES = 0;
UPDATE clientes
SET telefono = IFNULL(telefono,'DESCONOCIDO')
WHERE nombre like 'Sujeto%';
SET SQL_SAFE_UPDATES = 1;
-- 2. COALESCE: El "Selector de Prioridades" (N argumentos)
-- Devuelve el primer valor NO NULO de una lista.
-- Escenario: 1. Email (Preferido), 2. Teléfono (Backup), 3. Texto por defecto
-- Lo que hace esto es ver su es que exite null en los campos de los argumentos que le pasas, si no es null, entonces te devuelve el primer resultado, si es null el primer argumento entonces te envía el segundo, y si no el tercero, y si todos son null pues entonces ya ni modo, recurre a la cadena de texto que el mandas como argumetno final.
select * from clientes;
SELECT
	nombre,
	COALESCE(email, telefono, 'ILOCALIZABLE') AS contacto_urgente
FROM clientes
WHERE nombre LIKE 'Sujeto%';

-- 3. Evitar que una concatenación "rompa" el resultado
-- Problema: 'Sr. ' + NULL = NULL (El NULL es como un agujero negro)
SELECT 
	CONCAT ('Expediente: ', COALESCE(nombre, 'ANONIMO')) AS info_sujeto
FROM clientes;



-- Cast y demás cosas
-- Conversión de tipos y saneamiento de fechas
-- Ejemplo: Convertir texto '01/01/2020' a tipo DATETIME
explain sys_logs;
SET SQL_SAFE_UPDATES = 0;
UPDATE sys_logs
SET created_at = STR_TO_DATE('12/03/2026 10:30:00', '%d/%m/%Y %H:%i:%s')
WHERE id= 1;

-- Uso de CAST para asegurar tipos numéricos en importaciones de cadenas
UPDATE clientes 
SET  credito = CAST('150.00' AS DECIMAL (10,2))
WHERE nombre = 'Carlos Ruiz';

SET SQL_SAFE_UPDATES = 1;

-- REESTRUCTURACIÓN QUIRÚRJICA: MODIFICACIÓN DEL ESQUEMA
-- 		añadir y eliminar columnas
-- 			Añadir una columna de NIF después del nombre
ALTER TABLE clientes ADD COLUMN nif VARCHAR(12) AFTER nombre;

-- 			Eliminar una columna que ya no es necesaria (ejemplo conceptual)
-- 			ALTER TABLE sys_logs DROP COLUMN metadata_obsoleta;


-- 		Modificar tipos de datos y nombres 
-- 			Ampliar la longitud permitida para el nombre del cliente
ALTER TABLE clientes MODIFY COLUMN nombre VARCHAR(250);

-- 			Ejemplo de cambio de nombre y tipo(Sintaxis MYSQL)
-- 			ALTER TABLE clientes CHANGE COLUMN nombre nombre_completo VARCHAR(200)

-- 		Imponer la integridad: Unicidad y obligatoriedad
-- 			Forzar la unicidad de los correos electrónicos para evitar duplicados en el futuro
ALTER TABLE clientes ADD CONSTRAINT uq_email UNIQUE (email);

-- 			Convertir una columna en obligatoria (NOT NULL)
-- 			¡Atención! Primero saneamos los nulos existentes para evitar errores de restricción
SET SQL_SAFE_UPDATES = 0;
UPDATE clientes SET nif  = '00000000000T' WHERE nif IS NULL;
SET SQL_SAFE_UPDATES = 1;
ALTER TABLE clientes MODIFY nif VARCHAR(12) NOT NULL;
-- 		Validación de reglas de negocio (CHECK)
-- 			Impedir que el crédito del cliente sea negativo mediante una restricción de validación
ALTER TABLE clientes ADD CONSTRAINT chk_credito_positivo CHECK (credito>=0);

-- 			Impedir que el crédito del cliente sea negativo mediante una restricción de validación
select * from clientes;
ALTER TABLE clientes ADD CONSTRAINT chk_nif_formato CHECK (nif REGEXP '^[0-9]{8}[A-Z]$'); -- Esta nos da un error, lo que significa que es hora de sanear!!
SET SQL_SAFE_UPDATES = 0;
UPDATE clientes SET nif = '00000000T';
SET SQL_SAFE_UPDATES = 1;
ALTER TABLE clientes ADD CONSTRAINT chk_nif_formato CHECK (nif REGEXP '^[0-9]{8}[A-Z]$'); -- ahora si funciona la huevada

-- SARGability: El peligro de las funciones en el WHERE
-- 		La cosa aquí es que si le metes funciones a un where, optimizas de muy mala manera tu query porque con esta peyejada haces que el where tenga antes que hacer menjurjes para poder buscar bien dentro de las tablas, las funciones u operaciones matemáticas están bien para luego del priemr elemento del where, para que el where no tenga que ahcer la funcion una y otra vez en cada campo
-- 		Rendimiento y SARGability (Search ARgument ABLE)
-- 		MAL: Evita funciones en la columna del WHERE (Invalida índices)
SELECT * FROM clientes WHERE UPPER(email)='JUAN@MAIL.COM';
-- BIEN: Compara contra la columna directamente (SARGable)
SELECT * FROM clientes WHERE email = 'juan@mail.com';
-- MAL: TRIM() en el WHERE obliga a un Full Table Scan al motor
UPDATE clientes SET activo = 0 WHERE TRIM(nombre) = 'Juan Gomez';
-- 		Non-SARGable: WHERE price * 1.2 > 50
-- 		SARGable: WHERE price > 50 / 1.2

-- Eliminación de datos y auditoría
-- 		DELETE vs TRUNCATE, ejemplos
-- 			El DELETE borra todo fila por fila y se perdura la cuenta del AUTO_INCREMENT, el truncate no, es estructural y elminina todos los datos de la fila, pero no su estructura
-- 			Purga de registros obsoletos basandose en fechas (Ej. Ley de Proteccion de Datos)
SET SQL_SAFE_UPDATES = 0;
DELETE FROM sys_logs
WHERE created_at < DATE_SUB(NOW(), INTERVAL 5 YEAR);

-- 			Vaciado inmediato y reseteo del auto_incremento de la tabla de importacion tras procesarla
TRUNCATE TABLE import_raw;
SET SQL_SAFE_UPDATES = 1;

-- 		Verificación Post-intervencion
-- 			Verificación post-intervención mediante agregación
-- 			Comprobar si han quedado correos repetidos tras el UPDATE
SELECT email,COUNT(*) as repetidos FROM clientes GROUP BY email 
HAVING COUNT(*)>1;
select * from clientes;-- me cagué porque me salió un resultado, pero luego vi que era por dos nulls dentro de email

-- 			Verificar la distribución de datos tras un saneamiento masivo
SELECT activo, COUNT(*) FROM clientes
GROUP BY activo;




 






