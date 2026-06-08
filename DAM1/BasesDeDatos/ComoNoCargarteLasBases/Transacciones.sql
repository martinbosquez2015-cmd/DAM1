show databases;
-- TRANSACCIONES
use fp_transacciones;

-- Sintaxis básica
	-- 01. Alta segura de un registro
START TRANSACTION;
INSERT INTO alumnos (nombre, estado)VALUES ('Elena', 'Activo');
SELECT * FROM alumnos WHERE nombre = 'Elena';
COMMIT;
	-- 02. Prueba y descarte (El botón de pánico)
START TRANSACTION;
SELECT * FROM alumnos;
INSERT INTO alumnos (nombre, estado) VALUES (NULL, 'Error Intencionado');
ROLLBACK;
SELECT * FROM alumnos;
	-- 03. Actualización controlada
START TRANSACTION;
UPDATE pedidos SET estado ='Enviado' WHERE id = 1;
SELECT * FROM pedidos WHERE id = 1;
COMMIT;
	-- 04. Prevención de desastres en UPDATE
START TRANSACTION;
UPDATE empleados SET salario = 1; -- ¡CABRON TE OLVIDASTE DEL WHERE ALVAREGA!
SELECT * FROM empleados;
ROLLBACK; -- ya we, no la cagaste
	-- 	05. Simulación de borrado (Soft-delete manual)
START TRANSACTION;
DELETE FROM alumnos WHERE estado = 'Inactivo';
SELECT * FROM alumnos; -- Aquí luis se fue a la verga(bromi, por este chiste del soft-delete, aun tenemos cosillas de su registro y relaciones con otras tablas para o perder información)
ROLLBACK;

-- Lógica transaccional y relaciones
	-- 06. Transferencia de valores (Stock entre almacenes)
START TRANSACTION;
UPDATE almacen SET stock = stock - 10 WHERE id =1;
UPDATE almacen SET stock = stock + 10 WHERE id =2;
COMMIT;
	-- 07. Alta Maestro-Detalle (Uso de LAST_INSERT_ID)
START TRANSACTION;
INSERT INTO facturas (fecha) VALUES (CURDATE());
SET @factura_id = LAST_INSERT_ID();
INSERT INTO factura_detalle (factura_id, producto) VALUES (@factura_id, 'Monitor 24"'), (@factura_id, 'Teclado Mecánico');
COMMIT;
	-- 08. Baja en Cascada Manual (Sin ON DELETE CASCADE configurado)
START TRANSACTION;
DELETE FROM historial_conexiones WHERE usuario_id =5;
DELETE FROM usuarios WHERE id = 5;
COMMIT;-- Si hacemos un borrado manual de varias cosas es vital empezar la trnasaccion porque la podemos liar bien parda
	-- 09. Actualización con registro de auditoría (Log)
START TRANSACTION;
UPDATE almacen SET stock = stock + 50 WHERE id = 1;
INSERT INTO auditoria_precios (producto_id, fecha, accion) VALUES (1, NOW(), 'REPOSICION DE 50 UNIDADES DE SWITCH');
COMMIT;-- Siempre que se hagan cambis, es buena práctica registratlos en una tabla de auditoria para blah blah blah

-- Conceptos críticos y peligros
	-- 10. Cierre implícito traicionero (El peligro del DDL)
	-- Las sentencias DDL provocan un COMMIT automático.
START TRANSACTION;
UPDATE almacen SET stock = stock -1 WHERE id = 1;
-- Alguien decide crear una tabla temporal o truncar otra en medio:
TRUNCATE TABLE modulos;
ROLLBACK;
-- Resultado: El ROLLBACK no tiene efecto sobre el UPDATE.
-- El TRUNCATE forzó un COMMIT implícito previo.
	-- 11. Transacciones "Anidadas" (El riesgo de un nuevo START TRANSACTION)
START TRANSACTION;
UPDATE alumnos SET nota = 10.00 WHERE id =1;
-- Un script mal diseñado intenta abrir otra transacción interna:
START TRANSACTION; -- ¡CUIDADO! Esto provoca un COMMIT implícito de la anterior.
UPDATE alumnos SET estado = 'Matrícula de honor' WHERE id =1;
ROLLBACK;-- Solo el segundo cambio se deshace. El 10.00 se guardó.

-- 



