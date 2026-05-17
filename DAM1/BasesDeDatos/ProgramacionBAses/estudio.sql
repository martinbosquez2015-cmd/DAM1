use sakila;
DELIMITER //
CREATE PROCEDURE saludo()
BEGIN 
	SELECT 'Hola mundo feñiz' AS mensaje;
END //
DELIMITER ; 
CALL saludo();

DELIMITER //
CREATE PROCEDURE contar_peliculas(OUT p_total INT)
BEGIN
	SELECT COUNT(*) INTO p_total FROM film;
END //
DELIMITER ;

CALL contar_peliculas(@resultado);
SELECT @resultado;

DELIMITER //
CREATE PROCEDURE buscar_actor(IN p_apellido VARCHAR(45))
BEGIN
	SELECT first_name, last_name FROM actor
    WHERE last_name LIKE CONCAT(p_apellido, '%');
END //
DELIMITER ;
CALL buscar_actor('Jackman');
CALL buscar_actor('Linganguluguliguliwachaasdsadasdasdasdasdasdasdasdasdads')

DELIMITER //
CREATE PROCEDURE get_actor_stats(IN p_actor_id INT, OUT p_films INT, OUT p_avg_len DECIMAL(10,2))
BEGIN
	SELECT COUNT(*), AVG(length) INTO p_films, p_avg_len
    FROM  film JOIN film_actor USING (film_id) WHERE actor_id = p_actor_id;
END //
DELIMITER ;

CALL get_actor_stats(1, @films, @avereich);
SELECT @films, @avereich;

-- Operación matemática simple
DELIMITER //
CREATE FUNCTION calcular_iva(p_precio DECIMAL(10,2))
RETURNS DECIMAL(10,2) DETERMINISTIC
BEGIN
	RETURN p_precio * 1.21;
END //
DELIMITER ;

SELECT calcular_iva(10.0);
-- Vamos a probar hacer una consulta calculando el iva para esta huevada
explain film;
SELECT calcular_iva(SELECT replacement_cost from film f2 where film_id=1);-- no sé como mejorar esto man :(
SELECT film_id, title, calcular_iva(replacement_cost) from film;
-- Formateo de Texto:
DELIMITER //
CREATE FUNCTION nombre_completo(p_nombre VARCHAR(45), p_apellido VARCHAR(45))
RETURNS VARCHAR(100) DETERMINISTIC
BEGIN 
	RETURN CONCAT(p_apellido, ', ', p_nombre);
END //
DELIMITER ;

SELECT nombre_completo(first_name, last_name) from actor;

-- Consulta simple de BBDD:
DELIMITER //
CREATE FUNCTION dias_alquiler(p_rental_id INT)
RETURNS INT READS SQL DATA
BEGIN
	DECLARE v_dias INT;
    SELECT DATEDIFF(return_date, rental_date) INTO v_dias
    FROM rental WHERE rental_id = p_rental_id;
    RETURN v_dias;
END //
DELIMITER ;

SELECT rental_id, dias_alquiler(rental_id) from rental;
-- Ejemplo REal de SAKILA(COMPLICAO)
DELIMITER // 
CREATE FUNCTION inventory_in_stock(p_inventory_id INT) 
RETURNS BOOLEAN READS SQL DATA
BEGIN
	DECLARE v_rentals INT;
    DECLARE v_out INT;
    SELECT COUNT(*) INTO v_rentals FROM rental WHERE inventory_id =p_inventory_id;
    IF v_rentals = 0 THEN RETURN TRUE; END IF;
    SELECT COUNT(rental_id) INTO v_out
    FROM inventory LEFT JOIN rental USING(inventory_id)
    WHERE inventory.inventory_id = p_inventory_id AND rental.return_date IS NULL;
    IF v_out > 0 THEN RETURN FALSE; ELSE RETURN TRUE; END IF;
    END //
    DELIMITER ;
    



-- Triggers
-- Función para capitalizar
DELIMITER //
CREATE TRIGGER capitalizar_apellido BEFORE INSERT ON actor
FOR EACH ROW
BEGIN
	SET NEW.last_name = UPPER(NEW.last_name);
END //
DELIMITER ;
-- registro de auditoría simple
DELIMITER //
CREATE TRIGGER log_nuevo_cliente AFTER INSERT ON customer
FOR EACH ROW
BEGIN
	INSERT INTO logs(accion, id_cliente) VALUES('NUEVO', NEW.customer_id);
END //
DELIMITER ;
-- Impedir una accion (SIGNAL)
DELIMITER //
CREATE TRIGGER no_borrar_actores BEFORE DELETE ON actor
FOR EACH ROW
BEGIN
	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Prohibido borrar actores';
END //
DELIMITER ;

-- EJEMPLO REAL SAKILA(Sincronizacion)
DELIMITER // 
CREATE TRIGGER ins_film AFTER INSERT ON film
FOR EACH ROW
BEGIN
	INSERT INTO film_text (film_id, title, description)
    VALUES (NEW.film_id, NEW.title, NEW.description);
END //
DELIMITER ;


