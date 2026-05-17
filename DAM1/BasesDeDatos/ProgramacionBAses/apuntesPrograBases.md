# Apuntes y CHeetsheet para programación en bases de datos
## Cosillas a tomar en cuenta
>
> | Consejos  | why?      |
> |-----------|-----------|
> | Siempre usar WHERE en SELECT INTO    | evitar error > 1172    |
> | Nunca comparar NULL con =    | SQL funciona > distinto    |
> | Inicializar variables    | evitar NULL inesperados    |
> | Declarar DETERMINISTIC/READS SQL DATA    | evitar > error 1418    |
> | Revisar BEFORE/AFTER    | cambia completamente el > trigger    |
> | Recordar NEW y OLD    | muy preguntado    |
> | Cerrar cursores    | buena práctica    |
> | Pensar si función debe ser determinista    | clave conceptual    |
> | <>    | eso es como !=    |

> - __IMPORTANTE SIEMPRE EL CAMBIO DEL LIMITADOR CON ```DELIMITER // y luego DELIMITER ;```__
> - Encerrar la sentencia de código con ```BEGIN``` y ```END //```
> - __Sintaxis de programacion y bucles etc:__
>   - Sentencia IF: 
>   ```
>    IF p_edad >= 18 THEN
>        SET p_mensaje = ’Mayor de > edad’;
>    ELSE
>        SET p_mensaje = ’Menor de > edad’;
>    END IF;
>    ```
>   - Estructura CASE (Múltiples opciones):
>   ```
>   CASE p_categoria_id
>   WHEN 1 THEN SET p_nombre_cat >= ’Acción’;
>   WHEN 2 THEN SET p_nombre_cat >= ’Animación’;
>   ELSE SET p_nombre_cat = >’Otros’;
>   END CASE;
>   ```
>   - Bucle WHILE (Repetición >controlada):
>   ```
>   DECLARE i INT DEFAULT 1;
>   WHILE i <= 5 DO
>   INSERT INTO tabla_log(msg) >VALUES (CONCAT(’Paso ’, i));
>   SET i = i + 1;
>   END WHILE;
>   ```
>    - Bucle LOOP con LEAVE >(Salida forzada):
>   ```
>   mi_bucle: LOOP
>   IF v_error = TRUE THEN
>   LEAVE mi_bucle;
>   END IF;
>   -- Realizar acciones...
>   END LOOP mi_bucle;
>   ```
> - La forma de mandar mensajes de error para no cagarla: 
>   ```
>   SIGNAL SQLSTATE ’45000’ SET MESSAGE_TEXT = >   ’Actor demasiado famoso para
>   borrar’;
>   ```
 - como inicializar valiables y declararlas al toque
```
 DECLARE i INT DEFAULT 0;
```
 - como asignar otro valor a una variable
```
 SET i = 6;
```
- Último ID insertado
```
LAST_INSERT_ID()
```

## 1. Procedimientos
```
CREATE PROCEDURE get_actor_stats(IN p_actor_id INT, OUT p_films INT, OUT p_avg_len
DECIMAL(10,2))
BEGIN
    SELECT COUNT(*), AVG(length) INTO p_films, p_avg_len
    FROM film JOIN film_actor USING(film_id) WHERE actor_id = p_actor_id;
END //
DELIMITER ;
```
cómo llamarlos:
```
CALL get_actor_stats(1, @films, @avereich);
SELECT @films, @avereich;
```

## 2. Funciones
- __Cualidades y cosas con las funciones:__
    - ```DETERMINISTIC``` y ```NOT DETERMINISTIC```: ```DETERMINISTIC``` refiere a funciones que siempre serán exactas, cuando la llames siempre te dará un mismo resultado o una misma estructura que puede ser replicada por otro ordenador en otro momento. Por otra parte ```NOT DETERMINISTIC``` refiere a funciones que te dan resultados mas variables, como por ejemplo un ```NOW()``` que nos da una fecha que varía segun el tiempo y reloj local a pesar de que se aplique la misma funcion
    - ```READS SQL DATA``` y ```MODIFIES SQL DATA```: Simple, una solo hace consultas y la otra los modifica. Tambien hay otra opcion llamada ```NO SQL``` que refiere a cuando haces funciones que no tocan la base de datos, mas funciones del tipo matematicas

- __Estructura:__
```diff
DELIMITER //
+ CREATE FUNCTION 
+ calcular_multa_mejorado(f_rental_id INT)
RETURNS DECIMAL(10,2) 
+ NOT DETERMINISTIC
+ READS SQL DATA
BEGIN
	DECLARE dias_permitidos INT DEFAULT 5;
    DECLARE dias_totales INT;
    DECLARE dias_contados INT;
	DECLARE multa_total DECIMAL(10,2) DEFAULT 0;
    DECLARE fecha_devolucion DATETIME DEFAULT NULL;
    SELECT return_date INTO fecha_devolucion FROM rental where rental_id=f_rental_id;
    IF fecha_devolucion IS NOT NULL THEN
		SELECT DATEDIFF(fecha_devolucion, rental_date) INTO dias_totales FROM rental where rental_id=f_rental_id;
	else
		SELECT DATEDIFF(NOW(), rental_date) INTO dias_totales fROM rental where rental_id=f_rental_id;
	END IF;
    IF dias_totales>dias_permitidos THEN
+		SET dias_contados = dias_totales - dias_permitidos;
        SET multa_total = dias_contados*1.50;
	END IF;
+    RETURN multa_total;
END //
DELIMITER //
```
> Esta funcion no es determinista debido a que la función varóa segun la fecha en la que estemos por el ```NOW()``` y es un ```READS SQL DATA``` debido a que no modifica los datos de sql
La funcion se llama así:
```
SELECT rental_id, calcular_multa_mejorado(rental_id) as multa FROM rental having multa !=0;
```

## 3. Triggers
Son disparadores que actuan cuando se ejecutan inserts, updates y deletes, pueden hacer cosas interesantes como bloquear eliminaciones especificas en una base de datos

| Before  | After      |
|-----------|-----------|
| Antes de guardar    | después de guardar    |

ejemplos de uso:
```
DELIMITER //
CREATE TRIGGER audit_pay AFTER UPDATE ON payment FOR EACH ROW
BEGIN
IF OLD.amount <> NEW.amount THEN
INSERT INTO audit_payments(payment_id, old_amt, new_amt)
VALUES (OLD.payment_id, OLD.amount, NEW.amount);
END IF;
END //
DELIMITER ;
```

```
DELIMITER //
CREATE TRIGGER protect_actors BEFORE DELETE ON actor FOR EACH ROW
BEGIN
DECLARE v_count INT;
SELECT COUNT(*) INTO v_count FROM film_actor WHERE actor_id = OLD.actor_id;
IF v_count > 20 THEN
SIGNAL SQLSTATE ’45000’ SET MESSAGE_TEXT = ’Actor demasiado famoso para
borrar’;
END IF;
END //
DELIMITER ;

```

```
DELIMITER //
CREATE TRIGGER cust_upper BEFORE UPDATE ON customer FOR EACH ROW
BEGIN
SET NEW.first_name = UPPER(NEW.first_name);
END //
DELIMITER ;
```

```
DELIMITER //
CREATE TRIGGER check_min_inventory BEFORE INSERT ON rental FOR EACH ROW
BEGIN
DECLARE v_count INT;
SELECT COUNT(*) INTO v_count FROM inventory WHERE inventory_id = NEW.
inventory_id;
IF v_count = 0 THEN
SIGNAL SQLSTATE ’45000’ SET MESSAGE_TEXT = ’Copia de inventario no
existente’;
END IF;
END //
DELIMITER ;
```

```
DELIMITER //
CREATE TRIGGER email_hist BEFORE UPDATE ON customer FOR EACH ROW
BEGIN
IF OLD.email <> NEW.email THEN
INSERT INTO email_history(customer_id, old_email) VALUES (OLD.customer_id,
OLD.email);
END IF;
END //
DELIMITER ;

```
## 4 . Cursores
Son cosas para hacer cambios o verificaciones de a poco, fila por fila

Ejemplos de uso:
Resumen de Ventas Staff:
```
DELIMITER //
CREATE PROCEDURE total_staff_sales()
BEGIN
DECLARE v_id INT;
DECLARE v_total DECIMAL(10,2);
DECLARE v_fin INT DEFAULT FALSE;
DECLARE cur CURSOR FOR SELECT staff_id FROM staff;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_fin = TRUE;
OPEN cur;
read_loop: LOOP
FETCH cur INTO v_id;
IF v_fin THEN LEAVE read_loop; END IF;
SELECT SUM(amount) INTO v_total FROM payment WHERE staff_id = v_id;
INSERT INTO staff_report(id, total) VALUES (v_id, v_total);
END LOOP;
CLOSE cur;
END //
DELIMITER ;

```
Normalizador de Nombres:
```
DELIMITER //
CREATE PROCEDURE capitalize_actors()
BEGIN
DECLARE v_id INT;
DECLARE v_fname VARCHAR(45);
DECLARE v_fin INT DEFAULT FALSE;
DECLARE cur CURSOR FOR SELECT actor_id, first_name FROM actor;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_fin = TRUE;
OPEN cur;
loop1: LOOP
FETCH cur INTO v_id, v_fname;
IF v_fin THEN LEAVE loop1; END IF;
UPDATE actor SET first_name = CONCAT(UPPER(LEFT(v_fname,1)), LOWER(
SUBSTRING(v_fname,2)))
WHERE actor_id = v_id;
END LOOP;
CLOSE cur;
END //
DELIMITER ;

```
Informe Ingresos por Categoría:
```
DELIMITER //
CREATE PROCEDURE cat_report()
BEGIN
DECLARE v_name VARCHAR(25);
DECLARE v_rev DECIMAL(10,2);
DECLARE v_fin INT DEFAULT FALSE;
DECLARE cur CURSOR FOR SELECT name FROM category;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_fin = TRUE;
OPEN cur;
loop_r: LOOP
FETCH cur INTO v_name;
IF v_fin THEN LEAVE loop_r; END IF;
SELECT SUM(amount) INTO v_rev FROM payment JOIN rental USING(rental_id)
JOIN inventory USING(inventory_id) JOIN film_category USING(film_id)
JOIN category USING(category_id) WHERE name = v_name;
INSERT INTO cat_stats VALUES (v_name, v_rev);
END LOOP;
CLOSE cur;
END //
DELIMITER ;
```
Aviso de Devolución:
```
DELIMITER //
CREATE PROCEDURE overdue_report()
BEGIN
DECLARE v_id INT;
DECLARE v_fin INT DEFAULT FALSE;
DECLARE cur CURSOR FOR SELECT rental_id FROM rental WHERE return_date IS NULL
AND rental_date < DATE_SUB(NOW(), INTERVAL 7 DAY);
DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_fin = TRUE;
OPEN cur;
loop_o: LOOP
FETCH cur INTO v_id;
IF v_fin THEN LEAVE loop_o; END IF;
INSERT INTO overdue_logs(rental_id) VALUES (v_id);
END LOOP;
CLOSE cur;
END //
DELIMITER ;

```
Reemplazo Masivo de Descripción:
```
DELIMITER //
CREATE PROCEDURE replace_desc(IN p_old VARCHAR(50), IN p_new VARCHAR(50))
BEGIN
DECLARE v_id INT;
DECLARE v_desc TEXT;
DECLARE v_fin INT DEFAULT FALSE;
DECLARE cur CURSOR FOR SELECT film_id, description FROM film;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_fin = TRUE;
OPEN cur;
loop_res: LOOP
FETCH cur INTO v_id, v_desc;
IF v_fin THEN LEAVE loop_res; END IF;
IF v_desc LIKE CONCAT(’%’, p_old, ’%’) THEN
UPDATE film SET description = REPLACE(v_desc, p_old, p_new) WHERE
film_id = v_id;
END IF;
END LOOP;
CLOSE cur;
END //
DELIMITER ;

```
>Explicacion de mi querido compañeroamigo xd
>Qué hace este procedimiento
>
>Traducción humana:
>
>“Busca alquileres no devueltos desde hace más de 7 días y guarda un >log por cada uno”.
>
>Lo importante:
>
>NO hace:
>
>INSERT INTO overdue_logs
>SELECT ...
>En vez de eso
>
>va:
>
>uno por uno
>
>usando cursor.
>
>VAMOS PIEZA A PIEZA
>1. DECLARE CURSOR
>DECLARE cur CURSOR FOR
>SELECT rental_id
>FROM rental
>WHERE return_date IS NULL
>AND rental_date < DATE_SUB(NOW(), INTERVAL 7 DAY);
>Qué significa
>
>Creas un cursor llamado:
>
>cur
>
>que recorrerá el resultado de este SELECT.
>
>Resultado mental
>
>Imagina que el SELECT devuelve:
>
>rental_id
>10
>15
>22
>El cursor hará
>10 → 15 → 22
>
>uno por uno.
>
>MUY IMPORTANTE
>
>Aquí NO se ejecuta todavía.
>
>Solo:
>
>“preparas el recorrido”
>2. DECLARE HANDLER
>
>Esto es CLAVE.
>
>DECLARE CONTINUE HANDLER FOR NOT FOUND
>SET v_fin = TRUE;
>Qué problema existe
>
>Cuando el cursor llegue al final:
>
>ya no habrá más filas
>Entonces FETCH fallaría.
>El HANDLER dice
>
>“cuando no queden filas,
>no explotes,
>simplemente pon:
>v_fin = TRUE”
>
>Sin HANDLER
>
>el procedimiento rompería con error.
>
>Analogía simple
>
>Es como detectar:
>
>“se acabó la lista”
>3. OPEN
>OPEN cur;
>Qué hace
>
>Abre el cursor.
>
>Mentalmente
>“empieza el recorrido”
>Antes del OPEN
>
>el cursor NO puede usarse.
>
>4. LOOP
>loop_o: LOOP
>Esto crea un bucle infinito.
>Nombre del loop
>loop_o
>¿Por qué tiene nombre?
>
>Para poder salir con:
>
>LEAVE loop_o;
>5. FETCH
>
>Esto es EL CORAZÓN del cursor.
>
>FETCH cur INTO v_id;
>Qué hace
>
>Coge:
>
>del cursor y la mete en variables.
>
>Ejemplo REAL
>
>Si el cursor tiene:
>
>rental_id
>10
>15
>22
>Primer FETCH
>v_id = 10
>Segundo FETCH
>v_id = 15
>Tercero
>v_id = 22
>Después
>
>No quedan filas.
>
>↓
>
>El HANDLER activa:
>
>v_fin = TRUE
>6. IF v_fin
>IF v_fin THEN
>    LEAVE loop_o;
>END IF;
>Traducción humana
>
>“Si ya no hay más filas:
>sal del bucle”.
>
>LEAVE
>
>Es como:
>
>break
>
>en otros lenguajes.
>
>7. INSERT
>INSERT INTO overdue_logs(rental_id)
>VALUES (v_id);
>Qué hace
>
>Por cada alquiler retrasado:
>
>inserta un log
>Resultado mental
>
>Si había:
>
>rental_id
>10
>15
>22
>El procedimiento hará
>INSERT ... VALUES(10)
>INSERT ... VALUES(15)
>INSERT ... VALUES(22)
>8. CLOSE
>CLOSE cur;
>Qué hace
>
>Cierra el cursor y libera recursos.
>
>MUY importante
>
>Buenas prácticas:
>
>si abres → debes cerrar
>RESUMEN VISUAL COMPLETO
>Paso 1
>
>Preparar cursor:
>
>lista de rental_id
>Paso 2
>
>Abrir cursor
>
>↓
>
>Paso 3
>
>FETCH fila
>
>↓
>
>Paso 4
>
>¿hay fila?
>
>sí
>
>procesar
>
>↓
>
>volver al LOOP
>
>no
>
>salir
>
>Paso 5
>
>Cerrar cursor
>
>SEGUNDO EJEMPLO DEL PDF
>replace_desc()
>
>Qué hace
>
>Busca texto en descripciones de películas y lo reemplaza.
>
>Cursor usado
>DECLARE cur CURSOR FOR
>SELECT film_id, description FROM film;
>IMPORTANTE
>
>Aquí el FETCH tiene DOS variables.
>
>FETCH
>FETCH cur INTO v_id, v_desc;
>Porque el SELECT devuelve:
>columna
>film_id
>description
>REGLA IMPORTANTÍSIMA
>
>El FETCH debe tener:
>
>MISMO número de variables
>
>que columnas devuelve el cursor.
>
>MAL
>SELECT film_id, description
>FETCH INTO v_id
>BIEN
>FETCH INTO v_id, v_desc
>Luego hace
>IF v_desc LIKE CONCAT('%', p_old, '%')
>Qué significa
>
>“si la descripción contiene cierto texto”.
>
>Después
>UPDATE film
>SET description = REPLACE(...)
>REPLACE()
>
>Sustituye texto.
>
>Ejemplo
>REPLACE('hola mundo', 'mundo', 'Juan')
>
>↓
>
>hola Juan
>CUÁNDO USAR CURSORES
>Buenos casos
>Caso	Motivo
>lógica fila a fila	necesitas decisiones
>auditoría	insertar logs
>validaciones complejas	condiciones distintas
>procesos secuenciales	recorrer registros
>MALOS casos
>
>⚠️ MUY importante.
>
>SQL normalmente debe trabajar en bloque
>
>Esto:
>
>UPDATE film SET ...
>
>es MUCHÍSIMO más rápido que cursor.
>
>Porque cursor implica
>fila por fila
>Regla profesional
>Si puedes hacerlo sin cursor → mejor
>ERROR TÍPICO 1 — olvidar HANDLER
>
>Entonces FETCH explota al final.
>
>ERROR TÍPICO 2 — olvidar OPEN
>
>Cursor no inicializado.
>
>ERROR TÍPICO 3 — olvidar CLOSE
>
>Consumes recursos innecesarios.
>
>ERROR TÍPICO 4 — FETCH incorrecto
>
>Número de columnas ≠ variables.
>
>CHEATSHEET MENTAL DEFINITIVO
>Cursor = recorrido fila a fila
>Orden obligatorio
>DECLARE
>OPEN
>FETCH
>LOOP
>CLOSE
>FETCH
>coge una fila
>HANDLER
>detecta final
>LEAVE
>sale del loop
>Regla de oro
>Cursor = potente pero lento
>
>Porque rompe la filosofía masiva de SQL.
---
## noshe
ejemplos aparte para no olvidar 
```
DELIMITER //
CREATE PROCEDURE GenerarEnviosMasivos()
BEGIN
DECLARE i INT DEFAULT 0;
WHILE i < 100000 DO
INSERT INTO envios (tracking_number, cliente_id, f_salida, importe_envio)
VALUES (CONCAT(’TRK-’, FLOOR(RAND()*99999999)),
FLOOR(1 + RAND() * 500),
DATE_FORMAT(DATE_ADD(’2025-01-01’, INTERVAL i MINUTE),
ELT(1 + FLOOR(RAND() * 4), ’%d/%m/%Y’, ’%Y-%m-%d’, ’%d-%
m-%y’, ’%y/%m/%d’)),
CONCAT(ROUND(RAND()*500, 2), ’ EUR’));
SET i = i + 1;
IF i % 20000 = 0 THEN
SELECT CONCAT(’... ’, i, ’ envios procesados.’) AS Progreso;
END IF;
END WHILE;
END //
DELIMITER ;
```
---
recordatorio de modificación de bases:
## Cheat Sheet: Manipulación de Datos (DML) en Bloques Lógicos

Este documento contiene la sintaxis esencial y buenas prácticas para realizar `INSERT`, `UPDATE` y `DELETE` dentro de funciones, procedimientos almacenados, triggers y cursores.

---

### 1. INSERT (Inserción de Datos)

#### Inserción Estándar
INSERT INTO tabla (columna1, columna2) 
VALUES (valor1, valor2);

#### Inserción desde Variables (Procedimientos/Funciones)
-- Ejemplo en PL/pgSQL o PL/SQL
INSERT INTO empleados (nombre, salario, fecha_ingreso) 
VALUES (v_nombre, v_salario, CURRENT_DATE);

#### Inserción Masiva (SELECT)
Útil para volcar datos de control o auditoría dentro de un script.
INSERT INTO historico_empleados (id, accion, fecha)
SELECT id, 'MIGRACION', NOW() 
FROM empleados 
WHERE activo = false;

---

### 2. UPDATE (Modificación de Datos)

> ⚠️ REGLA DE ORO: En scripts y procedimientos, asegúrate de que el WHERE use la clave primaria o una variable única para evitar actualizaciones masivas accidentales.

#### Actualización Estándar con Variables
UPDATE empleados 
SET salario = v_nuevo_salario,
    ultima_modificacion = NOW()
WHERE id_empleado = v_id_empleado;

#### Actualización Condicional Basada en Otra Tabla
UPDATE empleados e
SET e.bono = t.monto_bono
FROM tabla_bonos t
WHERE e.categoria_id = t.categoria_id 
  AND e.id_empleado = v_id_empleado;

---

### 3. DELETE (Eliminación de Datos)

#### Eliminación Segura por Variable
DELETE FROM empleados 
WHERE id_empleado = v_id_empleado;

#### DELETE con RETURNING (PostgreSQL / Oracle)
Excelente para capturar datos eliminados y meterlos en variables o tablas de log en el mismo paso.
DELETE FROM sesiones 
WHERE expirada = true 
RETURNING id_usuario INTO v_usuario_afectado;

---

### 4. Uso Especializado en Estructuras Avanzadas

#### A. En TRIGGERS (Disparadores)
Los triggers usan pseudotablas (NEW y OLD) para capturar el estado del dato.

* INSERT: Solo existe NEW (valores entrantes). OLD es NULL.
* UPDATE: Existen NEW (valores modificados) y OLD (valores anteriores).
* DELETE: Solo existe OLD (valores que se van a borrar). NEW es NULL.

-- Ejemplo conceptual dentro de un Trigger de Auditoría (Row-Level)
IF TG_OP = 'UPDATE' THEN
    INSERT INTO auditoria (id_reg, valor_antiguo, valor_nuevo)
    VALUES (OLD.id, OLD.salario, NEW.salario);
END IF;

#### B. En CURSORES (Modificación en el sitio)
Si estás recorriendo filas con un cursor y necesitas modificar o eliminar la fila actual en la que está parado el puntero.

-- Requiere declarar el cursor con: FOR UPDATE
UPDATE empleados 
SET salario = salario * 1.1
WHERE CURRENT OF mi_cursor; -- Modifica la fila actual del bucle

#### C. Control de Transacciones (Crucial en Scripts y SPs)
Para asegurar que los inserts/updates/deletes no dejen la base de datos corrupta si algo falla.

BEGIN; -- Iniciar transacción

    UPDATE cuentas SET balance = balance - 100 WHERE id = 1;
    UPDATE cuentas SET balance = balance + 100 WHERE id = 2;

-- Si todo está bien:
COMMIT; 

-- Si ocurre un error en el bloque de excepción:
ROLLBACK;

---

### 5. Tips de Rendimiento para Programación SQL
* Evita Row-by-Row (RBAR): Si puedes hacer un UPDATE masivo con un WHERE, no uses un cursor para hacer UPDATE fila por fila. El motor SQL es más rápido procesando conjuntos.
* Evita Mutating Tables en Triggers: No hagas un UPDATE o INSERT a la Tabla A dentro de un trigger que se dispara por la Tabla A, o causarás un bucle infinito o un error de tabla mutante.
* Manejo de Nulos: En actualizaciones con variables, usa COALESCE(v_valor, columna_original) para evitar machacar datos existentes con un NULL accidental.